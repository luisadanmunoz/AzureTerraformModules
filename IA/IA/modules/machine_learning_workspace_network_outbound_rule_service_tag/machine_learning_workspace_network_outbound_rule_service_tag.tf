#############################################################################
# MACHINE LEARNING WORKSPACE NETWORK OUTBOUND RULE SERVICE TAG
#############################################################################
resource "azurerm_machine_learning_workspace_network_outbound_rule_service_tag" "machine_learning_workspace_network_outbound_rule_service_tag" {
  name         = var.machine_learning_workspace_network_outbound_rule_service_tag_name
  workspace_id = var.workspace_id
  service_tag  = var.service_tag
  protocol     = var.protocol
  port_ranges  = var.port_ranges

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
