################################################################################
# Directory Role Outputs
################################################################################

output "id" {
  description = "The Terraform resource ID of the directory role."
  value       = var.create ? azuread_directory_role.this[0].id : null
}

output "object_id" {
  description = "The object ID of the directory role."
  value       = var.create ? azuread_directory_role.this[0].object_id : null
}

output "display_name" {
  description = "The display name of the directory role."
  value       = var.create ? azuread_directory_role.this[0].display_name : null
}

output "template_id" {
  description = "The template ID of the directory role."
  value       = var.create ? azuread_directory_role.this[0].template_id : null
}

output "description" {
  description = "The description of the directory role."
  value       = var.create ? azuread_directory_role.this[0].description : null
}
