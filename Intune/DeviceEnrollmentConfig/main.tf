################################################################################
# Microsoft Intune Device Enrollment Limit Configuration
################################################################################

resource "microsoft365_device_enrollment_limit_configuration" "this" {
  count = var.create && var.config_type == "deviceEnrollmentLimitConfiguration" ? 1 : 0

  display_name = var.display_name
  description  = var.description
  priority     = var.priority
  limit        = var.device_limit

  dynamic "assignment" {
    for_each = var.assignments
    content {
      target_type = assignment.value.target_type
      group_id    = assignment.value.group_id
      filter_id   = assignment.value.filter_id
      filter_type = assignment.value.filter_type
    }
  }
}

################################################################################
# Microsoft Intune Device Enrollment Platform Restrictions Configuration
################################################################################

resource "microsoft365_device_enrollment_platform_restrictions_configuration" "this" {
  count = var.create && var.config_type == "deviceEnrollmentPlatformRestrictionsConfiguration" ? 1 : 0

  display_name = var.display_name
  description  = var.description
  priority     = var.priority

  # Android restrictions
  dynamic "android_restriction" {
    for_each = var.platform_restrictions != null && var.platform_restrictions.android_restriction != null ? [var.platform_restrictions.android_restriction] : []
    content {
      platform_blocked                   = android_restriction.value.platform_blocked
      personal_device_enrollment_blocked = android_restriction.value.personal_device_enrollment_blocked
      os_minimum_version                 = android_restriction.value.os_minimum_version
      os_maximum_version                 = android_restriction.value.os_maximum_version
      blocked_manufacturers              = android_restriction.value.blocked_manufacturers
      blocked_skus                       = android_restriction.value.blocked_skus
    }
  }

  # Android for Work restrictions
  dynamic "android_for_work_restriction" {
    for_each = var.platform_restrictions != null && var.platform_restrictions.android_for_work_restriction != null ? [var.platform_restrictions.android_for_work_restriction] : []
    content {
      platform_blocked                   = android_for_work_restriction.value.platform_blocked
      personal_device_enrollment_blocked = android_for_work_restriction.value.personal_device_enrollment_blocked
      os_minimum_version                 = android_for_work_restriction.value.os_minimum_version
      os_maximum_version                 = android_for_work_restriction.value.os_maximum_version
      blocked_manufacturers              = android_for_work_restriction.value.blocked_manufacturers
      blocked_skus                       = android_for_work_restriction.value.blocked_skus
    }
  }

  # iOS restrictions
  dynamic "ios_restriction" {
    for_each = var.platform_restrictions != null && var.platform_restrictions.ios_restriction != null ? [var.platform_restrictions.ios_restriction] : []
    content {
      platform_blocked                   = ios_restriction.value.platform_blocked
      personal_device_enrollment_blocked = ios_restriction.value.personal_device_enrollment_blocked
      os_minimum_version                 = ios_restriction.value.os_minimum_version
      os_maximum_version                 = ios_restriction.value.os_maximum_version
      blocked_manufacturers              = ios_restriction.value.blocked_manufacturers
      blocked_skus                       = ios_restriction.value.blocked_skus
    }
  }

  # macOS restrictions
  dynamic "mac_os_restriction" {
    for_each = var.platform_restrictions != null && var.platform_restrictions.mac_os_restriction != null ? [var.platform_restrictions.mac_os_restriction] : []
    content {
      platform_blocked                   = mac_os_restriction.value.platform_blocked
      personal_device_enrollment_blocked = mac_os_restriction.value.personal_device_enrollment_blocked
      os_minimum_version                 = mac_os_restriction.value.os_minimum_version
      os_maximum_version                 = mac_os_restriction.value.os_maximum_version
      blocked_manufacturers              = mac_os_restriction.value.blocked_manufacturers
      blocked_skus                       = mac_os_restriction.value.blocked_skus
    }
  }

  # Windows restrictions
  dynamic "windows_restriction" {
    for_each = var.platform_restrictions != null && var.platform_restrictions.windows_restriction != null ? [var.platform_restrictions.windows_restriction] : []
    content {
      platform_blocked                   = windows_restriction.value.platform_blocked
      personal_device_enrollment_blocked = windows_restriction.value.personal_device_enrollment_blocked
      os_minimum_version                 = windows_restriction.value.os_minimum_version
      os_maximum_version                 = windows_restriction.value.os_maximum_version
      blocked_manufacturers              = windows_restriction.value.blocked_manufacturers
      blocked_skus                       = windows_restriction.value.blocked_skus
    }
  }

  # Windows Mobile restrictions
  dynamic "windows_mobile_restriction" {
    for_each = var.platform_restrictions != null && var.platform_restrictions.windows_mobile_restriction != null ? [var.platform_restrictions.windows_mobile_restriction] : []
    content {
      platform_blocked                   = windows_mobile_restriction.value.platform_blocked
      personal_device_enrollment_blocked = windows_mobile_restriction.value.personal_device_enrollment_blocked
      os_minimum_version                 = windows_mobile_restriction.value.os_minimum_version
      os_maximum_version                 = windows_mobile_restriction.value.os_maximum_version
      blocked_manufacturers              = windows_mobile_restriction.value.blocked_manufacturers
      blocked_skus                       = windows_mobile_restriction.value.blocked_skus
    }
  }

  dynamic "assignment" {
    for_each = var.assignments
    content {
      target_type = assignment.value.target_type
      group_id    = assignment.value.group_id
      filter_id   = assignment.value.filter_id
      filter_type = assignment.value.filter_type
    }
  }
}

################################################################################
# Microsoft Intune Windows Hello for Business Configuration
################################################################################

resource "microsoft365_device_enrollment_windows_hello_for_business_configuration" "this" {
  count = var.create && var.config_type == "deviceEnrollmentWindowsHelloForBusinessConfiguration" ? 1 : 0

  display_name = var.display_name
  description  = var.description
  priority     = var.priority

  state                                  = try(var.windows_hello_for_business.state, "notConfigured")
  pin_minimum_length                     = try(var.windows_hello_for_business.pin_minimum_length, 4)
  pin_maximum_length                     = try(var.windows_hello_for_business.pin_maximum_length, 127)
  pin_uppercase_characters_usage         = try(var.windows_hello_for_business.pin_uppercase_characters_usage, "allowed")
  pin_lowercase_characters_usage         = try(var.windows_hello_for_business.pin_lowercase_characters_usage, "allowed")
  pin_special_characters_usage           = try(var.windows_hello_for_business.pin_special_characters_usage, "allowed")
  security_device_required               = try(var.windows_hello_for_business.security_device_required, false)
  unlock_with_biometrics_enabled         = try(var.windows_hello_for_business.unlock_with_biometrics_enabled, true)
  remote_passport_enabled                = try(var.windows_hello_for_business.remote_passport_enabled, true)
  pin_recovery_enabled                   = try(var.windows_hello_for_business.pin_recovery_enabled, true)
  pin_expiration_in_days                 = try(var.windows_hello_for_business.pin_expiration_in_days, 0)
  pin_previous_block_count               = try(var.windows_hello_for_business.pin_previous_block_count, 0)
  enhanced_biometrics_state              = try(var.windows_hello_for_business.enhanced_biometrics_state, "notConfigured")
  security_key_for_sign_in               = try(var.windows_hello_for_business.security_key_for_sign_in, "notConfigured")

  dynamic "assignment" {
    for_each = var.assignments
    content {
      target_type = assignment.value.target_type
      group_id    = assignment.value.group_id
      filter_id   = assignment.value.filter_id
      filter_type = assignment.value.filter_type
    }
  }
}
