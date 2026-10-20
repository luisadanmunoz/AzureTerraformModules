#############################################################################
# OUTPUT USER ASSIGNED IDENTITY
#############################################################################
output "id" {
  description = "value of the user assigned identity id"
  value       = azurerm_user_assigned_identity.user_assigned_identity.id

}
output "name" {
  description = "value of the user assigned identity name"
  value       = azurerm_user_assigned_identity.user_assigned_identity.name

}
output "principal_id" {
  description = "value of the user assigned identity principal_id"
  value       = azurerm_user_assigned_identity.user_assigned_identity.principal_id

}