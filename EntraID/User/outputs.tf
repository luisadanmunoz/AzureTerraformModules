################################################################################
# User Outputs
################################################################################

output "id" {
  description = "The Terraform resource ID of the user."
  value       = var.create ? azuread_user.this[0].id : null
}

output "object_id" {
  description = "The object ID of the user."
  value       = var.create ? azuread_user.this[0].object_id : null
}

output "user_principal_name" {
  description = "The user principal name (UPN)."
  value       = var.create ? azuread_user.this[0].user_principal_name : null
}

output "mail" {
  description = "The primary email address."
  value       = var.create ? azuread_user.this[0].mail : null
}

output "onpremises_sam_account_name" {
  description = "The on-premises SAM account name."
  value       = var.create ? azuread_user.this[0].onpremises_sam_account_name : null
}
