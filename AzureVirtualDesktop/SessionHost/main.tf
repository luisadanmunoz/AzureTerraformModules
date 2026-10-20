################################################################################
# Random Password (if not provided)
################################################################################

resource "random_password" "admin" {
  count = var.create && var.admin_password == null ? 1 : 0

  length           = 24
  special          = true
  override_special = "!@#$%^&*"
  min_lower        = 2
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2
}

################################################################################
# Network Interfaces
################################################################################

resource "azurerm_network_interface" "this" {
  count = var.create ? var.instance_count : 0

  name                = "${local.base_name}-${format("%03d", count.index + 1)}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  enable_accelerated_networking = var.enable_accelerated_networking

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }

  tags = local.tags
}

################################################################################
# Session Host VMs
################################################################################

resource "azurerm_windows_virtual_machine" "this" {
  count = var.create ? var.instance_count : 0

  name                = "${local.base_name}-${format("%03d", count.index + 1)}"
  computer_name       = "${var.name_prefix}${var.environment}${format("%03d", count.index + 1)}"
  resource_group_name = var.resource_group_name
  location            = var.location

  size           = var.vm_size
  admin_username = var.admin_username
  admin_password = var.admin_password != null ? var.admin_password : random_password.admin[0].result

  license_type = var.license_type
  timezone     = var.timezone

  network_interface_ids = [azurerm_network_interface.this[count.index].id]

  # Availability
  availability_set_id = var.availability_set_id
  zone                = var.zones_distribution ? local.zones[count.index % length(local.zones)] : var.availability_zone

  # Trusted Launch
  secure_boot_enabled = var.secure_boot_enabled
  vtpm_enabled        = var.vtpm_enabled

  encryption_at_host_enabled = var.encryption_at_host_enabled

  # OS Disk
  os_disk {
    name                   = "${local.base_name}-${format("%03d", count.index + 1)}-osdisk"
    caching                = var.os_disk.caching
    storage_account_type   = var.os_disk.storage_account_type
    disk_size_gb           = var.os_disk.disk_size_gb
    disk_encryption_set_id = var.os_disk.disk_encryption_set_id
  }

  # Source Image
  source_image_id = local.use_custom_image ? var.source_image_id : null

  dynamic "source_image_reference" {
    for_each = local.use_custom_image ? [] : [1]
    content {
      publisher = var.source_image_reference.publisher
      offer     = var.source_image_reference.offer
      sku       = var.source_image_reference.sku
      version   = var.source_image_reference.version
    }
  }

  # Identity
  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" || var.identity_type == "SystemAssigned, UserAssigned" ? var.identity_ids : null
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [
      admin_password,
    ]
  }
}

################################################################################
# Azure AD Join Extension
################################################################################

resource "azurerm_virtual_machine_extension" "aad_join" {
  count = var.create && local.is_aad_join ? var.instance_count : 0

  name                       = "AADLoginForWindows"
  virtual_machine_id         = azurerm_windows_virtual_machine.this[count.index].id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForWindows"
  type_handler_version       = "2.0"
  auto_upgrade_minor_version = true

  settings = var.aad_join.intune_enrollment ? jsonencode({
    mdmId = "0000000a-0000-0000-c000-000000000000"
  }) : null

  tags = local.tags

  depends_on = [azurerm_windows_virtual_machine.this]
}

################################################################################
# Active Directory Domain Join Extension
################################################################################

resource "azurerm_virtual_machine_extension" "ad_domain_join" {
  count = var.create && local.is_ad_join && var.ad_domain_join != null ? var.instance_count : 0

  name                       = "JsonADDomainExtension"
  virtual_machine_id         = azurerm_windows_virtual_machine.this[count.index].id
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    Name    = var.ad_domain_join.domain_name
    OUPath  = var.ad_domain_join.ou_path
    User    = "${var.ad_domain_join.domain_name}\\${var.ad_domain_join.domain_username}"
    Restart = "true"
    Options = "3" # Join domain and create computer account
  })

  protected_settings = jsonencode({
    Password = var.ad_domain_join.domain_password
  })

  tags = local.tags

  depends_on = [azurerm_windows_virtual_machine.this]
}

################################################################################
# AVD Agent Extension
################################################################################

resource "azurerm_virtual_machine_extension" "avd_agent" {
  count = var.create ? var.instance_count : 0

  name                       = "DSC-AVDAgent"
  virtual_machine_id         = azurerm_windows_virtual_machine.this[count.index].id
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.73"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    modulesUrl            = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_1.0.02714.342.zip"
    configurationFunction = "Configuration.ps1\\AddSessionHost"
    properties = {
      hostPoolName          = regex("[^/]+$", var.hostpool_id)
      aadJoin               = local.is_aad_join
      UseAgentDownloadEndpoint = true
    }
  })

  protected_settings = jsonencode({
    properties = {
      registrationInfoToken = var.registration_token
    }
  })

  tags = local.tags

  depends_on = [
    azurerm_virtual_machine_extension.aad_join,
    azurerm_virtual_machine_extension.ad_domain_join
  ]
}
