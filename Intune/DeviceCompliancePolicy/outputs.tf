################################################################################
# Device Compliance Policy Outputs
################################################################################

output "id" {
  description = "The ID of the Device Compliance Policy."
  value = var.create ? coalesce(
    var.platform == "windows10" ? try(microsoft365_device_compliance_policy_windows10.this[0].id, null) : null,
    var.platform == "iOS" ? try(microsoft365_device_compliance_policy_ios.this[0].id, null) : null,
    var.platform == "android" ? try(microsoft365_device_compliance_policy_android.this[0].id, null) : null,
    var.platform == "macOS" ? try(microsoft365_device_compliance_policy_macos.this[0].id, null) : null
  ) : null
}

output "display_name" {
  description = "The display name of the Device Compliance Policy."
  value       = var.create ? var.display_name : null
}

output "platform" {
  description = "The platform of the Device Compliance Policy."
  value       = var.create ? var.platform : null
}

################################################################################
# Windows 10 Specific Outputs
################################################################################

output "windows10_policy_id" {
  description = "The ID of the Windows 10 compliance policy."
  value       = var.create && var.platform == "windows10" ? try(microsoft365_device_compliance_policy_windows10.this[0].id, null) : null
}

################################################################################
# iOS Specific Outputs
################################################################################

output "ios_policy_id" {
  description = "The ID of the iOS compliance policy."
  value       = var.create && var.platform == "iOS" ? try(microsoft365_device_compliance_policy_ios.this[0].id, null) : null
}

################################################################################
# Android Specific Outputs
################################################################################

output "android_policy_id" {
  description = "The ID of the Android compliance policy."
  value       = var.create && var.platform == "android" ? try(microsoft365_device_compliance_policy_android.this[0].id, null) : null
}

################################################################################
# macOS Specific Outputs
################################################################################

output "macos_policy_id" {
  description = "The ID of the macOS compliance policy."
  value       = var.create && var.platform == "macOS" ? try(microsoft365_device_compliance_policy_macos.this[0].id, null) : null
}
