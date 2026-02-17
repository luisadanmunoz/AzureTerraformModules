################################################################################
# Device Enrollment Configuration Outputs
################################################################################

output "id" {
  description = "The ID of the Device Enrollment Configuration."
  value = var.create ? coalesce(
    var.config_type == "deviceEnrollmentLimitConfiguration" ? try(microsoft365_device_enrollment_limit_configuration.this[0].id, null) : null,
    var.config_type == "deviceEnrollmentPlatformRestrictionsConfiguration" ? try(microsoft365_device_enrollment_platform_restrictions_configuration.this[0].id, null) : null,
    var.config_type == "deviceEnrollmentWindowsHelloForBusinessConfiguration" ? try(microsoft365_device_enrollment_windows_hello_for_business_configuration.this[0].id, null) : null
  ) : null
}

output "display_name" {
  description = "The display name of the Device Enrollment Configuration."
  value       = var.create ? var.display_name : null
}

output "config_type" {
  description = "The type of the Device Enrollment Configuration."
  value       = var.create ? var.config_type : null
}

################################################################################
# Enrollment Limit Configuration Outputs
################################################################################

output "enrollment_limit_config_id" {
  description = "The ID of the enrollment limit configuration."
  value       = var.create && var.config_type == "deviceEnrollmentLimitConfiguration" ? try(microsoft365_device_enrollment_limit_configuration.this[0].id, null) : null
}

################################################################################
# Platform Restrictions Configuration Outputs
################################################################################

output "platform_restrictions_config_id" {
  description = "The ID of the platform restrictions configuration."
  value       = var.create && var.config_type == "deviceEnrollmentPlatformRestrictionsConfiguration" ? try(microsoft365_device_enrollment_platform_restrictions_configuration.this[0].id, null) : null
}

################################################################################
# Windows Hello for Business Configuration Outputs
################################################################################

output "windows_hello_config_id" {
  description = "The ID of the Windows Hello for Business configuration."
  value       = var.create && var.config_type == "deviceEnrollmentWindowsHelloForBusinessConfiguration" ? try(microsoft365_device_enrollment_windows_hello_for_business_configuration.this[0].id, null) : null
}
