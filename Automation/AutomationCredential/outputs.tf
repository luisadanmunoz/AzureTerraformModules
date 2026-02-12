################################################################################
# Credential Outputs
################################################################################

output "credential_ids" {
  description = "Map of credential names to their IDs."
  value = {
    for name, cred in azurerm_automation_credential.this :
    name => cred.id
  }
}

output "credential_names" {
  description = "List of created credential names."
  value       = keys(azurerm_automation_credential.this)
}
