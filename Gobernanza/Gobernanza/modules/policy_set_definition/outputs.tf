#############################################################################
# OUTPUT POLICY SET DEFINITION
#############################################################################
output "id" {
  value = azurerm_policy_set_definition.policy_set_definition.id
}

output "name" {
  value = var.policy_set_definition_name
}
