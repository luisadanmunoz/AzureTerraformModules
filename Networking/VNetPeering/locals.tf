################################################################################
# Local Values
################################################################################

locals {
  # Extract remote VNet name from ID if not provided
  remote_vnet_name_from_id = try(
    element(split("/", var.remote_virtual_network_id), length(split("/", var.remote_virtual_network_id)) - 1),
    "remote"
  )

  remote_vnet_name = var.remote_virtual_network_name != null ? var.remote_virtual_network_name : local.remote_vnet_name_from_id

  # Auto-generate peering name
  generated_name = "peer-${var.virtual_network_name}-to-${local.remote_vnet_name}"
  peering_name   = var.name != null ? var.name : local.generated_name

  # Auto-generate reverse peering name
  reverse_generated_name = "peer-${local.remote_vnet_name}-to-${var.virtual_network_name}"
  reverse_peering_name   = var.reverse_peering_name != null ? var.reverse_peering_name : local.reverse_generated_name

  # Extract local VNet ID for reverse peering
  local_vnet_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}"
}

data "azurerm_subscription" "current" {}
