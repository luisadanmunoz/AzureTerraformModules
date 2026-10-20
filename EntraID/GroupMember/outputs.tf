################################################################################
# Group Member Outputs
################################################################################

output "id" {
  description = "The Terraform resource ID of the group membership."
  value       = var.create ? azuread_group_member.this[0].id : null
}
