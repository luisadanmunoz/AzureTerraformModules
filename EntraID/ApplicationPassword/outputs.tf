################################################################################
# Application Password Outputs
################################################################################

output "id" {
  description = "The Terraform resource ID of the application password."
  value       = var.create ? azuread_application_password.this[0].id : null
}

output "key_id" {
  description = "A UUID used to uniquely identify this password credential."
  value       = var.create ? azuread_application_password.this[0].key_id : null
}

output "display_name" {
  description = "The display name of the password."
  value       = var.create ? azuread_application_password.this[0].display_name : null
}

output "value" {
  description = "The password value. This is a sensitive value and should be stored securely."
  value       = var.create ? azuread_application_password.this[0].value : null
  sensitive   = true
}

output "start_date" {
  description = "The start date from which the password is valid."
  value       = var.create ? azuread_application_password.this[0].start_date : null
}

output "end_date" {
  description = "The end date until which the password is valid."
  value       = var.create ? azuread_application_password.this[0].end_date : null
}
