#############################################################################
# OUTPUT POLICY DEFINITION - MANAGEMENT GROUP LANDING ZONE
#############################################################################

output "id_definition" {
  description = "value of the id tag"
  value       = azurerm_policy_definition.policy_definition.id
}

output "name_definition" {
  description = "value of the name tag"
  value       = azurerm_policy_definition.policy_definition.name
}


#############################################################################
# OUTPUT MANAGEMENT GROUP POLICY ASSIGNMENT
#############################################################################
output "id_assignment" {
  description = "value of the id tag"
  value       = azurerm_management_group_policy_assignment.management_group_policy_assignment.id
}
output "name_assignment" {
  description = "value of the name tag"
  value       = azurerm_management_group_policy_assignment.management_group_policy_assignment.name

}
