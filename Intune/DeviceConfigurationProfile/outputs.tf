################################################################################
# Device Configuration Profile Outputs
################################################################################

output "id" {
  description = "The ID of the Device Configuration Profile."
  value = var.create ? coalesce(
    var.platform == "windows10" && var.profile_type == "deviceRestrictions" ? try(microsoft365_device_configuration_windows10.device_restrictions[0].id, null) : null,
    var.platform == "windows10" && var.profile_type == "custom" ? try(microsoft365_device_configuration_custom_windows10.this[0].id, null) : null,
    var.platform == "iOS" && var.profile_type == "deviceRestrictions" ? try(microsoft365_device_configuration_ios.device_restrictions[0].id, null) : null
  ) : null
}

output "display_name" {
  description = "The display name of the Device Configuration Profile."
  value       = var.create ? var.display_name : null
}

output "platform" {
  description = "The platform of the Device Configuration Profile."
  value       = var.create ? var.platform : null
}

output "profile_type" {
  description = "The type of the Device Configuration Profile."
  value       = var.create ? var.profile_type : null
}

################################################################################
# Windows 10 Device Restrictions Outputs
################################################################################

output "windows10_device_restrictions_id" {
  description = "The ID of the Windows 10 device restrictions profile."
  value       = var.create && var.platform == "windows10" && var.profile_type == "deviceRestrictions" ? try(microsoft365_device_configuration_windows10.device_restrictions[0].id, null) : null
}

################################################################################
# Windows 10 Custom Profile Outputs
################################################################################

output "windows10_custom_id" {
  description = "The ID of the Windows 10 custom profile."
  value       = var.create && var.platform == "windows10" && var.profile_type == "custom" ? try(microsoft365_device_configuration_custom_windows10.this[0].id, null) : null
}

################################################################################
# iOS Device Restrictions Outputs
################################################################################

output "ios_device_restrictions_id" {
  description = "The ID of the iOS device restrictions profile."
  value       = var.create && var.platform == "iOS" && var.profile_type == "deviceRestrictions" ? try(microsoft365_device_configuration_ios.device_restrictions[0].id, null) : null
}
