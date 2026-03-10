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
# Linux Virtual Machine Scale Set
################################################################################

# DEPENDENCY: Resource Group must exist
# DEPENDENCY: Subnet must exist

resource "azurerm_linux_virtual_machine_scale_set" "this" {
  count = var.create && local.is_linux ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  instances           = var.autoscale.enabled ? null : var.instances

  admin_username                  = var.admin_username
  admin_password                  = local.admin_password
  disable_password_authentication = var.disable_password_authentication

  zones                        = length(var.zones) > 0 ? var.zones : null
  zone_balance                 = length(var.zones) > 0 ? var.zone_balance : null
  proximity_placement_group_id = var.proximity_placement_group_id
  platform_fault_domain_count  = var.platform_fault_domain_count
  single_placement_group       = var.single_placement_group
  overprovision                = var.overprovision
  upgrade_mode                 = var.upgrade_mode
  health_probe_id              = var.health_probe_id

  secure_boot_enabled        = var.secure_boot_enabled
  vtpm_enabled               = var.vtpm_enabled
  encryption_at_host_enabled = var.encryption_at_host_enabled

  # Scale-in policy
  scale_in {
    rule                   = var.scale_in.rule
    force_deletion_enabled = var.scale_in.force_deletion_enabled
  }

  # Admin SSH Keys
  dynamic "admin_ssh_key" {
    for_each = var.admin_ssh_keys
    content {
      username   = admin_ssh_key.value.username
      public_key = admin_ssh_key.value.public_key
    }
  }

  # Network Interface
  network_interface {
    name                          = "${local.resource_name}-nic"
    primary                       = true
    enable_accelerated_networking = var.enable_accelerated_networking

    ip_configuration {
      name                                         = "internal"
      primary                                      = true
      subnet_id                                    = var.subnet_id
      load_balancer_backend_address_pool_ids       = var.load_balancer_backend_address_pool_ids
      application_gateway_backend_address_pool_ids = var.application_gateway_backend_address_pool_ids
    }
  }

  # OS Disk
  os_disk {
    caching                = var.os_disk.caching
    storage_account_type   = var.os_disk.storage_account_type
    disk_size_gb           = var.os_disk.disk_size_gb
    disk_encryption_set_id = var.os_disk.disk_encryption_set_id
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

  # Data Disks
  dynamic "data_disk" {
    for_each = var.data_disks
    content {
      lun                    = data_disk.value.lun
      disk_size_gb           = data_disk.value.disk_size_gb
      storage_account_type   = data_disk.value.storage_account_type
      caching                = data_disk.value.caching
      create_option          = data_disk.value.create_option
      disk_encryption_set_id = data_disk.value.disk_encryption_set_id
    }
  }

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

  # Extensions
  dynamic "extension" {
    for_each = var.extensions
    content {
      name                       = extension.value.name
      publisher                  = extension.value.publisher
      type                       = extension.value.type
      type_handler_version       = extension.value.type_handler_version
      auto_upgrade_minor_version = extension.value.auto_upgrade_minor_version
      settings                   = extension.value.settings
      protected_settings         = extension.value.protected_settings
    }
  }

  tags = local.tags
}

################################################################################
# Windows Virtual Machine Scale Set
################################################################################

resource "azurerm_windows_virtual_machine_scale_set" "this" {
  count = var.create && local.is_windows ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  instances           = var.autoscale.enabled ? null : var.instances

  admin_username = var.admin_username
  admin_password = local.admin_password

  zones                        = length(var.zones) > 0 ? var.zones : null
  zone_balance                 = length(var.zones) > 0 ? var.zone_balance : null
  proximity_placement_group_id = var.proximity_placement_group_id
  platform_fault_domain_count  = var.platform_fault_domain_count
  single_placement_group       = var.single_placement_group
  overprovision                = var.overprovision
  upgrade_mode                 = var.upgrade_mode
  health_probe_id              = var.health_probe_id

  secure_boot_enabled        = var.secure_boot_enabled
  vtpm_enabled               = var.vtpm_enabled
  encryption_at_host_enabled = var.encryption_at_host_enabled

  # Scale-in policy
  scale_in {
    rule                   = var.scale_in.rule
    force_deletion_enabled = var.scale_in.force_deletion_enabled
  }

  # Network Interface
  network_interface {
    name                          = "${local.resource_name}-nic"
    primary                       = true
    enable_accelerated_networking = var.enable_accelerated_networking

    ip_configuration {
      name                                         = "internal"
      primary                                      = true
      subnet_id                                    = var.subnet_id
      load_balancer_backend_address_pool_ids       = var.load_balancer_backend_address_pool_ids
      application_gateway_backend_address_pool_ids = var.application_gateway_backend_address_pool_ids
    }
  }

  # OS Disk
  os_disk {
    caching                = var.os_disk.caching
    storage_account_type   = var.os_disk.storage_account_type
    disk_size_gb           = var.os_disk.disk_size_gb
    disk_encryption_set_id = var.os_disk.disk_encryption_set_id
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

  # Data Disks
  dynamic "data_disk" {
    for_each = var.data_disks
    content {
      lun                    = data_disk.value.lun
      disk_size_gb           = data_disk.value.disk_size_gb
      storage_account_type   = data_disk.value.storage_account_type
      caching                = data_disk.value.caching
      create_option          = data_disk.value.create_option
      disk_encryption_set_id = data_disk.value.disk_encryption_set_id
    }
  }

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

  # Extensions
  dynamic "extension" {
    for_each = var.extensions
    content {
      name                       = extension.value.name
      publisher                  = extension.value.publisher
      type                       = extension.value.type
      type_handler_version       = extension.value.type_handler_version
      auto_upgrade_minor_version = extension.value.auto_upgrade_minor_version
      settings                   = extension.value.settings
      protected_settings         = extension.value.protected_settings
    }
  }

  tags = local.tags
}

################################################################################
# Autoscale Settings
################################################################################

resource "azurerm_monitor_autoscale_setting" "this" {
  count = var.create && var.autoscale.enabled ? 1 : 0

  name                = "${local.resource_name}-autoscale"
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = local.is_linux ? azurerm_linux_virtual_machine_scale_set.this[0].id : azurerm_windows_virtual_machine_scale_set.this[0].id

  profile {
    name = "default"

    capacity {
      default = var.autoscale.default_count
      minimum = var.autoscale.min_count
      maximum = var.autoscale.max_count
    }

    # Scale out rule
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = local.is_linux ? azurerm_linux_virtual_machine_scale_set.this[0].id : azurerm_windows_virtual_machine_scale_set.this[0].id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = var.autoscale.scale_out_cpu_threshold
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    # Scale in rule
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = local.is_linux ? azurerm_linux_virtual_machine_scale_set.this[0].id : azurerm_windows_virtual_machine_scale_set.this[0].id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = var.autoscale.scale_in_cpu_threshold
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }

  tags = local.tags
}
