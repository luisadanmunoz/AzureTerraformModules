#############################################################################
# POLICY DEFINITION
#############################################################################

resource "azurerm_policy_definition" "policy_definition" {
  name                = var.name
  policy_type         = var.policy_type
  description         = var.description
  mode                = var.mode
  display_name        = var.display_name
  management_group_id = "/providers/Microsoft.Management/managementGroups/${var.management_group_id}"
  policy_rule         = var.policy_rule

  parameters = <<PARAMETERS

{}

PARAMETERS

  lifecycle {
    ignore_changes = [parameters]
  }
}
#############################################################################
# MANAGEMENT GROUP POLICY ASSIGNMENT
#############################################################################

resource "azurerm_management_group_policy_assignment" "management_group_policy_assignment" {
  name                 = var.name
  policy_definition_id = azurerm_policy_definition.policy_definition.id
  management_group_id  = "/providers/Microsoft.Management/managementGroups/${var.management_group_id}"
  location             = var.location

  dynamic "identity" {
    for_each = var.identity == true ? [1] : []
    content {
      type         = "UserAssigned"
      identity_ids = var.identity_ids
    }

  }
}
