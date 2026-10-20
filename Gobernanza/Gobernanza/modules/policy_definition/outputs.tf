#############################################################################
# OUTPUT POLICY DEFINITION
#############################################################################
output "id" {
  value = azurerm_policy_definition.policy_definition.id
}

output "name" {
  value = var.policy_definition_name
}
