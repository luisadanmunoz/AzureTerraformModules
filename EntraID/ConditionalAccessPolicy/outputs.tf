################################################################################
# Conditional Access Policy Outputs
################################################################################

output "id" {
  description = "The Terraform resource ID of the policy."
  value       = var.create ? azuread_conditional_access_policy.this[0].id : null
}

output "object_id" {
  description = "The object ID of the policy."
  value       = var.create ? azuread_conditional_access_policy.this[0].object_id : null
}

output "display_name" {
  description = "The display name of the policy."
  value       = var.create ? azuread_conditional_access_policy.this[0].display_name : null
}

output "state" {
  description = "The state of the policy."
  value       = var.create ? azuread_conditional_access_policy.this[0].state : null
}
