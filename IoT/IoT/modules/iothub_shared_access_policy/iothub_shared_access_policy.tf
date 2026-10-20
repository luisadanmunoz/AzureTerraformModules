#############################################################################
# IOT HUB SHARED ACCESS POLICY
#############################################################################
resource "azurerm_iothub_shared_access_policy" "iothub_shared_access_policy" {
  name                = var.iothub_shared_access_policy_name
  resource_group_name = var.resource_group_name
  iothub_name         = var.iothub_name
  registry_read       = var.registry_read
  registry_write      = var.registry_write
  service_connect     = var.service_connect
  device_connect      = var.device_connect

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
        coalesce(var.registry_read, false) ||
        coalesce(var.registry_write, false) ||
        coalesce(var.service_connect, false) ||
        coalesce(var.device_connect, false)
      )
      error_message = "At least one permission must be enabled."
    }

    precondition {
      condition = (
        coalesce(var.registry_write, false) == false ||
        coalesce(var.registry_read, false)
      )
      error_message = "registry_read must be true when registry_write is true."
    }
  }
}
