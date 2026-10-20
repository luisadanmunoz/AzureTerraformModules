#############################################################################
# AZURE FIREWALL POLICY RULE COLLECTION GROUP
#############################################################################
resource "azurerm_firewall_policy_rule_collection_group" "firewall_network_rule_collection_group" {
  name               = var.name
  firewall_policy_id = var.firewall_policy_id
  priority           = var.priority

  network_rule_collection {
    name     = var.name_network_rule_collection
    priority = var.priority_network_rule_collection
    action   = var.action
    rule {
      name                  = var.name_rule
      protocols             = var.protocols
      source_addresses      = var.source_addresses
      destination_addresses = var.destination_addresses
      destination_ports     = var.destination_ports
    }
  }
}