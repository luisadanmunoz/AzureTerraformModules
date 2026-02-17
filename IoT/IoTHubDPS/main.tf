################################################################################
# Azure IoT Hub Device Provisioning Service
################################################################################

resource "azurerm_iothub_dps" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = var.sku_name
    capacity = var.sku_capacity
  }

  allocation_policy             = var.allocation_policy
  data_residency_enabled        = var.data_residency_enabled
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "linked_hub" {
    for_each = var.linked_hubs
    content {
      connection_string       = linked_hub.value.connection_string
      location                = linked_hub.value.location
      apply_allocation_policy = linked_hub.value.apply_allocation_policy
      allocation_weight       = linked_hub.value.allocation_weight
    }
  }

  dynamic "ip_filter_rule" {
    for_each = var.ip_filter_rules
    content {
      name    = ip_filter_rule.value.name
      ip_mask = ip_filter_rule.value.ip_mask
      action  = ip_filter_rule.value.action
      target  = ip_filter_rule.value.target
    }
  }

  tags = local.tags
}
