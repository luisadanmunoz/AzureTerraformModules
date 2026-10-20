################################################################################
# Group Outputs
################################################################################

output "id" {
  description = "The Terraform resource ID of the group."
  value       = var.create ? azuread_group.this[0].id : null
}

output "object_id" {
  description = "The object ID of the group."
  value       = var.create ? azuread_group.this[0].object_id : null
}

output "display_name" {
  description = "The display name of the group."
  value       = var.create ? azuread_group.this[0].display_name : null
}

output "mail" {
  description = "The SMTP address for the group."
  value       = var.create ? azuread_group.this[0].mail : null
}

output "onpremises_sam_account_name" {
  description = "The on-premises SAM account name."
  value       = var.create ? azuread_group.this[0].onpremises_sam_account_name : null
}

output "onpremises_security_identifier" {
  description = "The on-premises security identifier (SID)."
  value       = var.create ? azuread_group.this[0].onpremises_security_identifier : null
}
