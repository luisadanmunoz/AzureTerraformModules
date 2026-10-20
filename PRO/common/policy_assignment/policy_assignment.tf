#############################################################################
# MANAGEMENT GROUP POLICY ASSIGNMENT
#############################################################################

resource "azurerm_management_group_policy_assignment" "policy_assignment" {
  name                 = var.name
  policy_definition_id = var.policy_type == "definition" ? "/providers/Microsoft.Authorization/policyDefinitions/${var.policy_definition_id}" : "/providers/Microsoft.Authorization/policySetDefinitions/${var.policy_definition_id}"
  management_group_id  = "/providers/Microsoft.Management/managementGroups/${var.management_group_id}"
  display_name         = var.display_name
  description          = var.description
  location             = var.location
  parameters           = jsonencode(var.parameters)

  dynamic "identity" {
    for_each = var.identity == true ? [1] : []
    content {
      type         = "UserAssigned"
      identity_ids = var.identity_ids
    }

  }

  lifecycle {
    ignore_changes = [parameters]
  }

}