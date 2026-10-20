################################################################################
# Maintenance Configuration
################################################################################

# DEPENDENCY: Resource Group must exist

resource "azurerm_maintenance_configuration" "this" {
  count = var.create ? 1 : 0

  name                     = local.resource_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  scope                    = var.scope
  visibility               = var.visibility
  in_guest_user_patch_mode = var.in_guest_user_patch_mode
  properties               = var.properties

  # Maintenance Window
  dynamic "window" {
    for_each = var.window != null ? [var.window] : []
    content {
      start_date_time      = window.value.start_date_time
      expiration_date_time = window.value.expiration_date_time
      duration             = window.value.duration
      time_zone            = window.value.time_zone
      recur_every          = window.value.recur_every
    }
  }

  # Install Patches (for InGuestPatch scope)
  dynamic "install_patches" {
    for_each = var.install_patches != null && var.scope == "InGuestPatch" ? [var.install_patches] : []
    content {
      reboot = install_patches.value.reboot

      dynamic "linux" {
        for_each = install_patches.value.linux != null ? [install_patches.value.linux] : []
        content {
          classifications_to_include    = linux.value.classifications_to_include
          package_names_mask_to_exclude = linux.value.package_names_mask_to_exclude
          package_names_mask_to_include = linux.value.package_names_mask_to_include
        }
      }

      dynamic "windows" {
        for_each = install_patches.value.windows != null ? [install_patches.value.windows] : []
        content {
          classifications_to_include = windows.value.classifications_to_include
          kb_numbers_to_exclude      = windows.value.kb_numbers_to_exclude
          kb_numbers_to_include      = windows.value.kb_numbers_to_include
        }
      }
    }
  }

  tags = local.tags
}
