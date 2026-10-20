#############################################################################
# IOT HUB DPS SHARED ACCESS POLICY
#############################################################################
resource "azurerm_iothub_dps_shared_access_policy" "iothub_dps_shared_access_policy" {
  name                = var.iothub_dps_shared_access_policy_name
  resource_group_name = var.resource_group_name
  iothub_dps_name     = var.iothub_dps_name
  enrollment_read     = var.enrollment_read
  enrollment_write    = var.enrollment_write
  registration_read   = var.registration_read
  registration_write  = var.registration_write
  service_config      = var.service_config

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }

  lifecycle {
    precondition {
      condition = (
        coalesce(var.enrollment_read, false) ||
        coalesce(var.enrollment_write, false) ||
        coalesce(var.registration_read, false) ||
        coalesce(var.registration_write, false) ||
        coalesce(var.service_config, false)
      )
      error_message = "At least one permission must be enabled."
    }

    precondition {
      condition = (
        coalesce(var.enrollment_read, false) == false ||
        coalesce(var.registration_read, false)
      )
      error_message = "registration_read must be true when enrollment_read is true."
    }

    precondition {
      condition = (
        coalesce(var.registration_write, false) == false ||
        coalesce(var.registration_read, false)
      )
      error_message = "registration_read must be true when registration_write is true."
    }

    precondition {
      condition = (
        coalesce(var.enrollment_write, false) == false ||
        (
          coalesce(var.enrollment_read, false) &&
          coalesce(var.registration_read, false) &&
          coalesce(var.registration_write, false)
        )
      )
      error_message = "enrollment_write requires enrollment_read, registration_read and registration_write."
    }
  }
}
