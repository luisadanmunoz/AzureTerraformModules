#############################################################################
# MACHINE LEARNING WORKSPACE NETWORK OUTBOUND RULE FQDN
#############################################################################
resource "azurerm_machine_learning_workspace_network_outbound_rule_fqdn" "machine_learning_workspace_network_outbound_rule_fqdn" {
  name             = var.machine_learning_workspace_network_outbound_rule_fqdn_name
  workspace_id     = var.workspace_id
  destination_fqdn = var.destination_fqdn

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
