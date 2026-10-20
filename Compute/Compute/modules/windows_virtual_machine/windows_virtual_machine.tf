#############################################################################
# WINDOWS VIRTUAL MACHINE
#############################################################################
resource "azurerm_windows_virtual_machine" "windows_virtual_machine" {
  name                                                   = var.windows_virtual_machine_name
  resource_group_name                                    = var.resource_group_name
  location                                               = var.location
  size                                                   = var.size
  network_interface_ids                                  = var.network_interface_ids
  admin_username                                         = var.admin_username
  admin_password                                         = var.admin_password
  allow_extension_operations                             = var.allow_extension_operations
  automatic_updates_enabled                              = var.automatic_updates_enabled
  availability_set_id                                    = var.availability_set_id
  bypass_platform_safety_checks_on_user_schedule_enabled = var.bypass_platform_safety_checks_on_user_schedule_enabled
  capacity_reservation_group_id                          = var.capacity_reservation_group_id
  computer_name                                          = var.computer_name
  custom_data                                            = var.custom_data
  dedicated_host_group_id                                = var.dedicated_host_group_id
  dedicated_host_id                                      = var.dedicated_host_id
  disk_controller_type                                   = var.disk_controller_type
  edge_zone                                              = var.edge_zone
  encryption_at_host_enabled                             = var.encryption_at_host_enabled
  eviction_policy                                        = var.eviction_policy
  extensions_time_budget                                 = var.extensions_time_budget
  hotpatching_enabled                                    = var.hotpatching_enabled
  license_type                                           = var.license_type
  max_bid_price                                          = var.max_bid_price
  patch_assessment_mode                                  = var.patch_assessment_mode
  patch_mode                                             = var.patch_mode
  platform_fault_domain                                  = var.platform_fault_domain
  priority                                               = var.priority
  provision_vm_agent                                     = var.provision_vm_agent
  proximity_placement_group_id                           = var.proximity_placement_group_id
  reboot_setting                                         = var.reboot_setting
  secure_boot_enabled                                    = var.secure_boot_enabled
  source_image_id                                        = var.source_image_id
  timezone                                               = var.timezone
  user_data                                              = var.user_data
  virtual_machine_scale_set_id                           = var.virtual_machine_scale_set_id
  vtpm_enabled                                           = var.vtpm_enabled
  zone                                                   = var.zone
  tags                                                   = var.tags

  dynamic "additional_capabilities" {
    for_each = var.additional_capabilities != null ? [var.additional_capabilities] : []

    content {
      hibernation_enabled = try(additional_capabilities.value["hibernation_enabled"], null)
      ultra_ssd_enabled   = try(additional_capabilities.value["ultra_ssd_enabled"], null)
    }
  }

  dynamic "additional_unattend_content" {
    for_each = var.additional_unattend_contents != null ? var.additional_unattend_contents : []

    content {
      content = additional_unattend_content.value["content"]
      setting = additional_unattend_content.value["setting"]
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics != null ? [var.boot_diagnostics] : []

    content {
      storage_account_uri = try(boot_diagnostics.value["storage_account_uri"], null)
    }
  }

  dynamic "gallery_application" {
    for_each = var.gallery_applications != null ? var.gallery_applications : []

    content {
      version_id                                  = gallery_application.value["version_id"]
      automatic_upgrade_enabled                   = try(gallery_application.value["automatic_upgrade_enabled"], null)
      configuration_blob_uri                      = try(gallery_application.value["configuration_blob_uri"], null)
      order                                       = try(gallery_application.value["order"], null)
      tag                                         = try(gallery_application.value["tag"], null)
      treat_failure_as_deployment_failure_enabled = try(gallery_application.value["treat_failure_as_deployment_failure_enabled"], null)
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = try(identity.value["identity_ids"], null)
    }
  }

  dynamic "os_disk" {
    for_each = [var.os_disk]

    content {
      caching                          = os_disk.value["caching"]
      disk_encryption_set_id           = try(os_disk.value["disk_encryption_set_id"], null)
      disk_size_gb                     = try(os_disk.value["disk_size_gb"], null)
      name                             = try(os_disk.value["name"], null)
      secure_vm_disk_encryption_set_id = try(os_disk.value["secure_vm_disk_encryption_set_id"], null)
      security_encryption_type         = try(os_disk.value["security_encryption_type"], null)
      storage_account_type             = try(os_disk.value["storage_account_type"], null)
      write_accelerator_enabled        = try(os_disk.value["write_accelerator_enabled"], null)

      dynamic "diff_disk_settings" {
        for_each = try(os_disk.value["diff_disk_settings"], null) != null ? [os_disk.value["diff_disk_settings"]] : []

        content {
          option    = diff_disk_settings.value["option"]
          placement = try(diff_disk_settings.value["placement"], null)
        }
      }
    }
  }

  dynamic "os_image_notification" {
    for_each = var.os_image_notification != null ? [var.os_image_notification] : []

    content {
      timeout = try(os_image_notification.value["timeout"], null)
    }
  }

  dynamic "plan" {
    for_each = var.plan != null ? [var.plan] : []

    content {
      name      = plan.value["name"]
      product   = plan.value["product"]
      publisher = plan.value["publisher"]
    }
  }

  dynamic "secret" {
    for_each = var.secrets != null ? var.secrets : []

    content {
      key_vault_id = secret.value["key_vault_id"]

      dynamic "certificate" {
        for_each = secret.value["certificates"]

        content {
          store = certificate.value["store"]
          url   = certificate.value["url"]
        }
      }
    }
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_reference != null ? [var.source_image_reference] : []

    content {
      publisher = source_image_reference.value["publisher"]
      offer     = source_image_reference.value["offer"]
      sku       = source_image_reference.value["sku"]
      version   = source_image_reference.value["version"]
    }
  }

  dynamic "termination_notification" {
    for_each = var.termination_notification != null ? [var.termination_notification] : []

    content {
      enabled = termination_notification.value["enabled"]
      timeout = try(termination_notification.value["timeout"], null)
    }
  }

  dynamic "winrm_listener" {
    for_each = var.winrm_listeners != null ? var.winrm_listeners : []

    content {
      protocol        = winrm_listener.value["protocol"]
      certificate_url = try(winrm_listener.value["certificate_url"], null)
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }

  lifecycle {
    precondition {
      condition     = (var.source_image_id != null) != (var.source_image_reference != null)
      error_message = "Exactly one of source_image_id or source_image_reference must be provided."
    }
  }
}
