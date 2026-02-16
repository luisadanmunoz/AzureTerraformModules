################################################################################
# Directory Role Assignment Outputs
################################################################################

output "id" {
  description = "The Terraform resource ID of the role assignment."
  value       = var.create ? azuread_directory_role_assignment.this[0].id : null
}
