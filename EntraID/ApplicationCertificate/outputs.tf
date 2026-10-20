################################################################################
# Application Certificate Outputs
################################################################################

output "id" {
  description = "The Terraform resource ID of the application certificate."
  value       = var.create ? azuread_application_certificate.this[0].id : null
}

output "key_id" {
  description = "A UUID used to uniquely identify this certificate."
  value       = var.create ? azuread_application_certificate.this[0].key_id : null
}

output "start_date" {
  description = "The start date from which the certificate is valid."
  value       = var.create ? azuread_application_certificate.this[0].start_date : null
}

output "end_date" {
  description = "The end date until which the certificate is valid."
  value       = var.create ? azuread_application_certificate.this[0].end_date : null
}
