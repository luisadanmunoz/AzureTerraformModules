################################################################################
# Windows Autopilot Deployment Profile Outputs
################################################################################

output "id" {
  description = "The ID of the Windows Autopilot Deployment Profile."
  value       = var.create ? microsoft365_windows_autopilot_deployment_profile.this[0].id : null
}

output "display_name" {
  description = "The display name of the Windows Autopilot Deployment Profile."
  value       = var.create ? microsoft365_windows_autopilot_deployment_profile.this[0].display_name : null
}

output "device_type" {
  description = "The device type of the Windows Autopilot Deployment Profile."
  value       = var.create ? microsoft365_windows_autopilot_deployment_profile.this[0].device_type : null
}

output "enable_white_glove" {
  description = "Whether white glove mode is enabled."
  value       = var.create ? microsoft365_windows_autopilot_deployment_profile.this[0].enable_white_glove : null
}

output "device_name_template" {
  description = "The device name template."
  value       = var.create ? microsoft365_windows_autopilot_deployment_profile.this[0].device_name_template : null
}
