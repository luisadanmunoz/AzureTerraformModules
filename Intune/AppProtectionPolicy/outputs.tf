################################################################################
# App Protection Policy Outputs
################################################################################

output "id" {
  description = "The ID of the App Protection Policy."
  value = var.create ? coalesce(
    var.platform == "iOS" ? try(microsoft365_app_protection_policy_ios.this[0].id, null) : null,
    var.platform == "android" ? try(microsoft365_app_protection_policy_android.this[0].id, null) : null
  ) : null
}

output "display_name" {
  description = "The display name of the App Protection Policy."
  value       = var.create ? var.display_name : null
}

output "platform" {
  description = "The platform of the App Protection Policy."
  value       = var.create ? var.platform : null
}

################################################################################
# iOS Specific Outputs
################################################################################

output "ios_policy_id" {
  description = "The ID of the iOS app protection policy."
  value       = var.create && var.platform == "iOS" ? try(microsoft365_app_protection_policy_ios.this[0].id, null) : null
}

################################################################################
# Android Specific Outputs
################################################################################

output "android_policy_id" {
  description = "The ID of the Android app protection policy."
  value       = var.create && var.platform == "android" ? try(microsoft365_app_protection_policy_android.this[0].id, null) : null
}
