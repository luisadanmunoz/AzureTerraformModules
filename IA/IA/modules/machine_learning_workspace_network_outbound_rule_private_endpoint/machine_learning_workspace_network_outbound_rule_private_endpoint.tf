#############################################################################
# MACHINE LEARNING WORKSPACE NETWORK OUTBOUND RULE PRIVATE ENDPOINT
#############################################################################
resource "azurerm_machine_learning_workspace_network_outbound_rule_private_endpoint" "machine_learning_workspace_network_outbound_rule_private_endpoint" {
  name                = var.machine_learning_workspace_network_outbound_rule_private_endpoint_name
  workspace_id        = var.workspace_id
  service_resource_id = var.service_resource_id
  sub_resource_target = var.sub_resource_target
  spark_enabled       = var.spark_enabled

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
