#############################################################################
# IOT HUB
#############################################################################
resource "azurerm_iothub" "iothub" {
  name                          = var.iothub_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  event_hub_partition_count     = var.event_hub_partition_count
  event_hub_retention_in_days   = var.event_hub_retention_in_days
  local_authentication_enabled  = var.local_authentication_enabled
  min_tls_version               = var.min_tls_version
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags

  sku {
    name     = var.sku["name"]
    capacity = var.sku["capacity"]
  }

  dynamic "cloud_to_device" {
    for_each = var.cloud_to_device != null ? [var.cloud_to_device] : []

    content {
      default_ttl        = try(cloud_to_device.value["default_ttl"], null)
      max_delivery_count = try(cloud_to_device.value["max_delivery_count"], null)

      dynamic "feedback" {
        for_each = try(cloud_to_device.value["feedback"], null) != null ? [cloud_to_device.value["feedback"]] : []

        content {
          lock_duration      = try(feedback.value["lock_duration"], null)
          max_delivery_count = try(feedback.value["max_delivery_count"], null)
          time_to_live       = try(feedback.value["time_to_live"], null)
        }
      }
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = try(identity.value["identity_ids"], null)
    }
  }

  dynamic "network_rule_set" {
    for_each = var.network_rule_set != null ? [var.network_rule_set] : []

    content {
      apply_to_builtin_eventhub_endpoint = try(network_rule_set.value["apply_to_builtin_eventhub_endpoint"], null)
      default_action                     = try(network_rule_set.value["default_action"], null)

      dynamic "ip_rule" {
        for_each = try(network_rule_set.value["ip_rule"], [])

        content {
          name    = ip_rule.value["name"]
          ip_mask = ip_rule.value["ip_mask"]
          action  = try(ip_rule.value["action"], null)
        }
      }
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
      condition = (
        var.identity == null ||
        can(regex("UserAssigned", var.identity["type"])) == false ||
        try(length(var.identity["identity_ids"]) > 0, false)
      )
      error_message = "identity_ids is required when identity.type includes UserAssigned."
    }
  }
}
