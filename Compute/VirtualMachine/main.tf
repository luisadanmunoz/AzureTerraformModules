################################################################################
# Random Password
################################################################################

resource "random_password" "admin" {
  count = var.create && local.use_generated_password ? 1 : 0

  length           = 24
  special          = true
  override_special = "!@#$%^&*"
  min_lower        = 2
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2
}

################################################################################
# Public IP (Optional)
################################################################################

resource "azurerm_public_ip" "this" {
  count = var.create && var.create_public_ip ? 1 : 0

  name                = "${local.resource_name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = var.public_ip_sku
  zones               = var.zone != null ? [var.zone] : null

  tags = local.tags
}

################################################################################
# Network Interface
################################################################################

# DEPENDENCY: Subnet must exist

resource "azurerm_network_interface" "this" {
  count = var.create && local.create_nic ? 1 : 0

  name                          = "${local.resource_name}-nic"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  enable_accelerated_networking = var.enable_accelerated_networking
  enable_ip_forwarding          = var.enable_ip_forwarding

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address            = var.private_ip_address_allocation == "Static" ? var.private_ip_address : null
    public_ip_address_id          = var.create_public_ip ? azurerm_public_ip.this[0].id : null
  }

  tags = local.tags
}

################################################################################
# Data Disks
################################################################################

resource "azurerm_managed_disk" "data" {
  for_each = var.create ? { for disk in var.data_disks : disk.lun => disk } : {}

  name                   = each.value.name != null ? each.value.name : "${local.resource_name}-datadisk-${each.key}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  storage_account_type   = each.value.storage_account_type
  create_option          = each.value.create_option
  disk_size_gb           = each.value.disk_size_gb
  disk_encryption_set_id = each.value.disk_encryption_set_id
  zone                   = var.zone

  tags = local.tags
}

################################################################################
# Linux Virtual Machine
################################################################################

# DEPENDENCY: Resource Group must exist
# DEPENDENCY: Subnet must exist (if creating NIC)
# DEPENDENCY: Availability Set must exist (if specified)
# DEPENDENCY: Proximity Placement Group must exist (if specified)

resource "azurerm_linux_virtual_machine" "this" {
  count = var.create && local.is_linux ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  computer_name       = local.computer_name

  admin_username                  = var.admin_username
  admin_password                  = local.admin_password
  disable_password_authentication = var.disable_password_authentication

  network_interface_ids = local.network_interface_ids

  zone                          = var.zone
  availability_set_id           = var.availability_set_id
  proximity_placement_group_id  = var.proximity_placement_group_id
  dedicated_host_id             = var.dedicated_host_id
  dedicated_host_group_id       = var.dedicated_host_group_id
  capacity_reservation_group_id = var.capacity_reservation_group_id

  license_type    = var.license_type
  priority        = var.priority
  eviction_policy = var.priority == "Spot" ? var.eviction_policy : null
  max_bid_price   = var.priority == "Spot" ? var.max_bid_price : null

  secure_boot_enabled        = var.secure_boot_enabled
  vtpm_enabled               = var.vtpm_enabled
  encryption_at_host_enabled = var.encryption_at_host_enabled
  patch_mode                 = var.patch_mode
  patch_assessment_mode      = var.patch_assessment_mode

  # Admin SSH Keys
  dynamic "admin_ssh_key" {
    for_each = var.admin_ssh_keys
    content {
      username   = admin_ssh_key.value.username
      public_key = admin_ssh_key.value.public_key
    }
  }

  # OS Disk
  os_disk {
    name                      = var.os_disk.name != null ? var.os_disk.name : "${local.resource_name}-osdisk"
    caching                   = var.os_disk.caching
    storage_account_type      = var.os_disk.storage_account_type
    disk_size_gb              = var.os_disk.disk_size_gb
    disk_encryption_set_id    = var.os_disk.disk_encryption_set_id
    write_accelerator_enabled = var.os_disk.write_accelerator_enabled
  }

  # Source Image
  dynamic "source_image_reference" {
    for_each = var.source_image_reference != null ? [var.source_image_reference] : []
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }

  source_image_id = var.source_image_id

  # Boot Diagnostics
  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics.enabled ? [1] : []
    content {
      storage_account_uri = var.boot_diagnostics.storage_account_uri
    }
  }

  # Identity
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.type == "UserAssigned" || identity.value.type == "SystemAssigned, UserAssigned" ? identity.value.identity_ids : null
    }
  }

  tags = local.tags

  depends_on = [azurerm_network_interface.this]
}

################################################################################
# Windows Virtual Machine
################################################################################

resource "azurerm_windows_virtual_machine" "this" {
  count = var.create && local.is_windows ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  computer_name       = local.computer_name

  admin_username = var.admin_username
  admin_password = local.admin_password

  network_interface_ids = local.network_interface_ids

  zone                          = var.zone
  availability_set_id           = var.availability_set_id
  proximity_placement_group_id  = var.proximity_placement_group_id
  dedicated_host_id             = var.dedicated_host_id
  dedicated_host_group_id       = var.dedicated_host_group_id
  capacity_reservation_group_id = var.capacity_reservation_group_id

  license_type    = var.license_type
  priority        = var.priority
  eviction_policy = var.priority == "Spot" ? var.eviction_policy : null
  max_bid_price   = var.priority == "Spot" ? var.max_bid_price : null

  secure_boot_enabled        = var.secure_boot_enabled
  vtpm_enabled               = var.vtpm_enabled
  encryption_at_host_enabled = var.encryption_at_host_enabled
  patch_mode                 = var.patch_mode
  patch_assessment_mode      = var.patch_assessment_mode

  # OS Disk
  os_disk {
    name                      = var.os_disk.name != null ? var.os_disk.name : "${local.resource_name}-osdisk"
    caching                   = var.os_disk.caching
    storage_account_type      = var.os_disk.storage_account_type
    disk_size_gb              = var.os_disk.disk_size_gb
    disk_encryption_set_id    = var.os_disk.disk_encryption_set_id
    write_accelerator_enabled = var.os_disk.write_accelerator_enabled
  }

  # Source Image
  dynamic "source_image_reference" {
    for_each = var.source_image_reference != null ? [var.source_image_reference] : []
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }

  source_image_id = var.source_image_id

  # Boot Diagnostics
  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics.enabled ? [1] : []
    content {
      storage_account_uri = var.boot_diagnostics.storage_account_uri
    }
  }

  # Identity
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.type == "UserAssigned" || identity.value.type == "SystemAssigned, UserAssigned" ? identity.value.identity_ids : null
    }
  }

  tags = local.tags

  depends_on = [azurerm_network_interface.this]
}

################################################################################
# Data Disk Attachments
################################################################################

resource "azurerm_virtual_machine_data_disk_attachment" "this" {
  for_each = var.create ? { for disk in var.data_disks : disk.lun => disk } : {}

  managed_disk_id    = azurerm_managed_disk.data[each.key].id
  virtual_machine_id = local.is_linux ? azurerm_linux_virtual_machine.this[0].id : azurerm_windows_virtual_machine.this[0].id
  lun                = each.value.lun
  caching            = each.value.caching
}

################################################################################
# VM Extensions
################################################################################

resource "azurerm_virtual_machine_extension" "this" {
  for_each = var.create ? { for ext in var.extensions : ext.name => ext } : {}

  name                       = each.value.name
  virtual_machine_id         = local.is_linux ? azurerm_linux_virtual_machine.this[0].id : azurerm_windows_virtual_machine.this[0].id
  publisher                  = each.value.publisher
  type                       = each.value.type
  type_handler_version       = each.value.type_handler_version
  auto_upgrade_minor_version = each.value.auto_upgrade_minor_version
  settings                   = each.value.settings
  protected_settings         = each.value.protected_settings

  tags = local.tags
}
