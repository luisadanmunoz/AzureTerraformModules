#############################################################################
# GLOBAL TAGS
#############################################################################
variable "tags" {
  description = "value to set the global tags"
  type        = map(string)
  default     = {}
}

#############################################################################
# RESOURCE GROUPS
#############################################################################
variable "resources_groups" {
  description = "value to set the resources groups"
  type = map(object({
    resource_group_name = string
    location            = string
    tags                = optional(map(string))
  }))
  default = {}
}

#############################################################################
# SSH PUBLIC KEYS
#############################################################################
variable "ssh_public_keys" {
  description = "value to set the ssh public keys"
  type = map(object({
    ssh_public_key_name = string
    resource_group_name = optional(string)
    location            = string
    public_key          = string
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# PROXIMITY PLACEMENT GROUPS
#############################################################################
variable "proximity_placement_groups" {
  description = "value to set the proximity placement groups"
  type = map(object({
    proximity_placement_group_name = string
    resource_group_name            = optional(string)
    location                       = string
    allowed_vm_sizes               = optional(list(string))
    zone                           = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# AVAILABILITY SETS
#############################################################################
variable "availability_sets" {
  description = "value to set the availability sets"
  type = map(object({
    availability_set_name          = string
    resource_group_name            = optional(string)
    location                       = string
    managed                        = optional(bool)
    platform_fault_domain_count    = optional(number)
    platform_update_domain_count   = optional(number)
    proximity_placement_group_name = optional(string)
    proximity_placement_group_id   = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# MANAGED DISKS
#############################################################################
variable "managed_disks" {
  description = "value to set the managed disks"
  type = map(object({
    managed_disk_name                 = string
    resource_group_name               = optional(string)
    location                          = string
    create_option                     = string
    storage_account_type              = string
    disk_access_id                    = optional(string)
    disk_encryption_set_id            = optional(string)
    disk_iops_read_only               = optional(number)
    disk_iops_read_write              = optional(number)
    disk_mbps_read_only               = optional(number)
    disk_mbps_read_write              = optional(number)
    disk_size_gb                      = optional(number)
    edge_zone                         = optional(string)
    gallery_image_reference_id        = optional(string)
    hyper_v_generation                = optional(string)
    image_reference_id                = optional(string)
    logical_sector_size               = optional(number)
    max_shares                        = optional(number)
    network_access_policy             = optional(string)
    on_demand_bursting_enabled        = optional(bool)
    optimized_frequent_attach_enabled = optional(bool)
    os_type                           = optional(string)
    performance_plus_enabled          = optional(bool)
    public_network_access_enabled     = optional(bool)
    secure_vm_disk_encryption_set_id  = optional(string)
    security_type                     = optional(string)
    source_resource_id                = optional(string)
    source_uri                        = optional(string)
    storage_account_id                = optional(string)
    trusted_launch_enabled            = optional(bool)
    upload_size_bytes                 = optional(number)
    zone                              = optional(string)
    encryption_settings = optional(object({
      disk_encryption_key = object({
        secret_url      = string
        source_vault_id = string
      })
      key_encryption_key = optional(object({
        key_url         = string
        source_vault_id = string
      }))
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# LINUX VIRTUAL MACHINES
#############################################################################
variable "linux_virtual_machines" {
  description = "value to set the linux virtual machines"
  type = map(object({
    linux_virtual_machine_name                             = string
    resource_group_name                                    = optional(string)
    location                                               = string
    size                                                   = string
    network_interface_ids                                  = list(string)
    admin_username                                         = optional(string)
    admin_password                                         = optional(string)
    allow_extension_operations                             = optional(bool)
    availability_set_name                                  = optional(string)
    availability_set_id                                    = optional(string)
    bypass_platform_safety_checks_on_user_schedule_enabled = optional(bool)
    capacity_reservation_group_id                          = optional(string)
    computer_name                                          = optional(string)
    custom_data                                            = optional(string)
    dedicated_host_group_id                                = optional(string)
    dedicated_host_id                                      = optional(string)
    disable_password_authentication                        = optional(bool)
    disk_controller_type                                   = optional(string)
    edge_zone                                              = optional(string)
    encryption_at_host_enabled                             = optional(bool)
    eviction_policy                                        = optional(string)
    extensions_time_budget                                 = optional(string)
    license_type                                           = optional(string)
    max_bid_price                                          = optional(number)
    patch_assessment_mode                                  = optional(string)
    patch_mode                                             = optional(string)
    platform_fault_domain                                  = optional(number)
    priority                                               = optional(string)
    provision_vm_agent                                     = optional(bool)
    proximity_placement_group_name                         = optional(string)
    proximity_placement_group_id                           = optional(string)
    reboot_setting                                         = optional(string)
    secure_boot_enabled                                    = optional(bool)
    source_image_id                                        = optional(string)
    user_data                                              = optional(string)
    virtual_machine_scale_set_id                           = optional(string)
    vtpm_enabled                                           = optional(bool)
    zone                                                   = optional(string)
    additional_capabilities = optional(object({
      hibernation_enabled = optional(bool)
      ultra_ssd_enabled   = optional(bool)
    }))
    admin_ssh_keys = optional(list(object({
      username            = string
      ssh_public_key_name = optional(string)
      public_key          = optional(string)
    })))
    boot_diagnostics = optional(object({
      storage_account_uri = optional(string)
    }))
    gallery_applications = optional(list(object({
      version_id                                  = string
      automatic_upgrade_enabled                   = optional(bool)
      configuration_blob_uri                      = optional(string)
      order                                       = optional(number)
      tag                                         = optional(string)
      treat_failure_as_deployment_failure_enabled = optional(bool)
    })))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    os_disk = object({
      caching                          = string
      disk_encryption_set_id           = optional(string)
      disk_size_gb                     = optional(number)
      name                             = optional(string)
      secure_vm_disk_encryption_set_id = optional(string)
      security_encryption_type         = optional(string)
      storage_account_type             = optional(string)
      write_accelerator_enabled        = optional(bool)
      diff_disk_settings = optional(object({
        option    = string
        placement = optional(string)
      }))
    })
    os_image_notification = optional(object({
      timeout = optional(string)
    }))
    plan = optional(object({
      name      = string
      product   = string
      publisher = string
    }))
    secrets = optional(list(object({
      key_vault_id = string
      certificates = list(object({
        url = string
      }))
    })))
    source_image_reference = optional(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))
    termination_notification = optional(object({
      enabled = bool
      timeout = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# WINDOWS VIRTUAL MACHINES
#############################################################################
variable "windows_virtual_machines" {
  description = "value to set the windows virtual machines"
  type = map(object({
    windows_virtual_machine_name                           = string
    resource_group_name                                    = optional(string)
    location                                               = string
    size                                                   = string
    network_interface_ids                                  = list(string)
    admin_username                                         = optional(string)
    admin_password                                         = optional(string)
    allow_extension_operations                             = optional(bool)
    automatic_updates_enabled                              = optional(bool)
    availability_set_name                                  = optional(string)
    availability_set_id                                    = optional(string)
    bypass_platform_safety_checks_on_user_schedule_enabled = optional(bool)
    capacity_reservation_group_id                          = optional(string)
    computer_name                                          = optional(string)
    custom_data                                            = optional(string)
    dedicated_host_group_id                                = optional(string)
    dedicated_host_id                                      = optional(string)
    disk_controller_type                                   = optional(string)
    edge_zone                                              = optional(string)
    encryption_at_host_enabled                             = optional(bool)
    eviction_policy                                        = optional(string)
    extensions_time_budget                                 = optional(string)
    hotpatching_enabled                                    = optional(bool)
    license_type                                           = optional(string)
    max_bid_price                                          = optional(number)
    patch_assessment_mode                                  = optional(string)
    patch_mode                                             = optional(string)
    platform_fault_domain                                  = optional(number)
    priority                                               = optional(string)
    provision_vm_agent                                     = optional(bool)
    proximity_placement_group_name                         = optional(string)
    proximity_placement_group_id                           = optional(string)
    reboot_setting                                         = optional(string)
    secure_boot_enabled                                    = optional(bool)
    source_image_id                                        = optional(string)
    timezone                                               = optional(string)
    user_data                                              = optional(string)
    virtual_machine_scale_set_id                           = optional(string)
    vtpm_enabled                                           = optional(bool)
    zone                                                   = optional(string)
    additional_capabilities = optional(object({
      hibernation_enabled = optional(bool)
      ultra_ssd_enabled   = optional(bool)
    }))
    additional_unattend_contents = optional(list(object({
      content = string
      setting = string
    })))
    boot_diagnostics = optional(object({
      storage_account_uri = optional(string)
    }))
    gallery_applications = optional(list(object({
      version_id                                  = string
      automatic_upgrade_enabled                   = optional(bool)
      configuration_blob_uri                      = optional(string)
      order                                       = optional(number)
      tag                                         = optional(string)
      treat_failure_as_deployment_failure_enabled = optional(bool)
    })))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    os_disk = object({
      caching                          = string
      disk_encryption_set_id           = optional(string)
      disk_size_gb                     = optional(number)
      name                             = optional(string)
      secure_vm_disk_encryption_set_id = optional(string)
      security_encryption_type         = optional(string)
      storage_account_type             = optional(string)
      write_accelerator_enabled        = optional(bool)
      diff_disk_settings = optional(object({
        option    = string
        placement = optional(string)
      }))
    })
    os_image_notification = optional(object({
      timeout = optional(string)
    }))
    plan = optional(object({
      name      = string
      product   = string
      publisher = string
    }))
    secrets = optional(list(object({
      key_vault_id = string
      certificates = list(object({
        store = string
        url   = string
      }))
    })))
    source_image_reference = optional(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))
    termination_notification = optional(object({
      enabled = bool
      timeout = optional(string)
    }))
    winrm_listeners = optional(list(object({
      protocol        = string
      certificate_url = optional(string)
    })))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# VIRTUAL MACHINE DATA DISK ATTACHMENTS
#############################################################################
variable "virtual_machine_data_disk_attachments" {
  description = "value to set the virtual machine data disk attachments"
  type = map(object({
    managed_disk_name         = optional(string)
    managed_disk_id           = optional(string)
    virtual_machine_name      = optional(string)
    virtual_machine_id        = optional(string)
    lun                       = number
    caching                   = string
    create_option             = optional(string)
    write_accelerator_enabled = optional(bool)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# VIRTUAL MACHINE EXTENSIONS
#############################################################################
variable "virtual_machine_extensions" {
  description = "value to set the virtual machine extensions"
  type = map(object({
    virtual_machine_extension_name = string
    virtual_machine_name           = optional(string)
    virtual_machine_id             = optional(string)
    publisher                      = string
    type                           = string
    type_handler_version           = string
    auto_upgrade_minor_version     = optional(bool)
    automatic_upgrade_enabled      = optional(bool)
    failure_suppression_enabled    = optional(bool)
    provision_after_extensions     = optional(list(string))
    settings                       = optional(any)
    protected_settings             = optional(any)
    protected_settings_from_key_vault = optional(object({
      secret_url      = string
      source_vault_id = string
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}
