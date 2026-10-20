#############################################################################
# IOT HUB DPS
#############################################################################
resource "azurerm_iothub_dps" "iothub_dps" {
  name                          = var.iothub_dps_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  allocation_policy             = var.allocation_policy
  data_residency_enabled        = var.data_residency_enabled
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags

  sku {
    name     = var.sku["name"]
    capacity = var.sku["capacity"]
  }

  dynamic "ip_filter_rule" {
    for_each = var.ip_filter_rule != null ? var.ip_filter_rule : []

    content {
      name    = ip_filter_rule.value["name"]
      ip_mask = ip_filter_rule.value["ip_mask"]
      action  = ip_filter_rule.value["action"]
      target  = try(ip_filter_rule.value["target"], null)
    }
  }

  dynamic "linked_hub" {
    for_each = var.linked_hub != null ? var.linked_hub : []

    content {
      connection_string       = linked_hub.value["connection_string"]
      location                = linked_hub.value["location"]
      allocation_weight       = try(linked_hub.value["allocation_weight"], null)
      apply_allocation_policy = try(linked_hub.value["apply_allocation_policy"], null)
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
}
