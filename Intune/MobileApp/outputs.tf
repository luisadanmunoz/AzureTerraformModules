################################################################################
# Mobile App Outputs
################################################################################

output "id" {
  description = "The ID of the Mobile App."
  value = var.create ? coalesce(
    var.app_type == "iosStoreApp" ? try(microsoft365_mobile_app_ios_store.this[0].id, null) : null,
    var.app_type == "androidStoreApp" ? try(microsoft365_mobile_app_android_store.this[0].id, null) : null,
    var.app_type == "webLink" ? try(microsoft365_mobile_app_web_link.this[0].id, null) : null,
    var.app_type == "win32LobApp" ? try(microsoft365_mobile_app_win32_lob.this[0].id, null) : null
  ) : null
}

output "display_name" {
  description = "The display name of the Mobile App."
  value       = var.create ? var.display_name : null
}

output "app_type" {
  description = "The type of the Mobile App."
  value       = var.create ? var.app_type : null
}

################################################################################
# iOS Store App Outputs
################################################################################

output "ios_store_app_id" {
  description = "The ID of the iOS Store App."
  value       = var.create && var.app_type == "iosStoreApp" ? try(microsoft365_mobile_app_ios_store.this[0].id, null) : null
}

################################################################################
# Android Store App Outputs
################################################################################

output "android_store_app_id" {
  description = "The ID of the Android Store App."
  value       = var.create && var.app_type == "androidStoreApp" ? try(microsoft365_mobile_app_android_store.this[0].id, null) : null
}

################################################################################
# Web Link App Outputs
################################################################################

output "web_link_app_id" {
  description = "The ID of the Web Link App."
  value       = var.create && var.app_type == "webLink" ? try(microsoft365_mobile_app_web_link.this[0].id, null) : null
}

################################################################################
# Win32 LOB App Outputs
################################################################################

output "win32_lob_app_id" {
  description = "The ID of the Win32 LOB App."
  value       = var.create && var.app_type == "win32LobApp" ? try(microsoft365_mobile_app_win32_lob.this[0].id, null) : null
}
