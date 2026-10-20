################################################################################
# Microsoft Intune Device Compliance Policy - Windows 10
################################################################################

resource "microsoft365_device_compliance_policy_windows10" "this" {
  count = var.create && var.platform == "windows10" ? 1 : 0

  display_name = var.display_name
  description  = var.description

  # Password settings
  password_required                          = try(var.windows_compliance_settings.password_required, false)
  password_required_type                     = try(var.windows_compliance_settings.password_required_type, "deviceDefault")
  password_minimum_length                    = try(var.windows_compliance_settings.password_minimum_length, null)
  password_minutes_of_inactivity_before_lock = try(var.windows_compliance_settings.password_minutes_of_inactivity_before_lock, null)
  password_expiration_days                   = try(var.windows_compliance_settings.password_expiration_days, null)
  password_previous_password_block_count     = try(var.windows_compliance_settings.password_previous_password_block_count, null)

  # Device health settings
  require_healthy_device_report = try(var.windows_compliance_settings.require_healthy_device_report, false)

  # OS version settings
  os_minimum_version        = try(var.windows_compliance_settings.os_minimum_version, null)
  os_maximum_version        = try(var.windows_compliance_settings.os_maximum_version, null)
  mobile_os_minimum_version = try(var.windows_compliance_settings.mobile_os_minimum_version, null)
  mobile_os_maximum_version = try(var.windows_compliance_settings.mobile_os_maximum_version, null)

  # Security settings
  early_launch_anti_malware_driver_enabled = try(var.windows_compliance_settings.early_launch_anti_malware_driver_enabled, null)
  bit_locker_enabled                       = try(var.windows_compliance_settings.bit_locker_enabled, false)
  secure_boot_enabled                      = try(var.windows_compliance_settings.secure_boot_enabled, false)
  code_integrity_enabled                   = try(var.windows_compliance_settings.code_integrity_enabled, false)
  storage_require_encryption               = try(var.windows_compliance_settings.storage_require_encryption, false)

  # Firewall and Defender
  active_firewall_required = try(var.windows_compliance_settings.active_firewall_required, false)
  defender_enabled         = try(var.windows_compliance_settings.defender_enabled, false)
  defender_version         = try(var.windows_compliance_settings.defender_version, null)
  antivirus_required       = try(var.windows_compliance_settings.antivirus_required, false)
  anti_spyware_required    = try(var.windows_compliance_settings.anti_spyware_required, false)

  # Device threat protection
  device_threat_protection_enabled                = try(var.windows_compliance_settings.device_threat_protection_enabled, false)
  device_threat_protection_required_security_level = try(var.windows_compliance_settings.device_threat_protection_required_security_level, null)

  # Other settings
  configuration_manager_compliance_required = try(var.windows_compliance_settings.configuration_manager_compliance_required, false)
  tpm_required                              = try(var.windows_compliance_settings.tpm_required, false)

  # Scheduled actions for non-compliance
  dynamic "scheduled_actions_for_rule" {
    for_each = var.scheduled_actions_for_rule
    content {
      rule_name = scheduled_actions_for_rule.value.rule_name

      dynamic "scheduled_action_configurations" {
        for_each = scheduled_actions_for_rule.value.scheduled_action_configurations
        content {
          action_type          = scheduled_action_configurations.value.action_type
          grace_period_hours   = scheduled_action_configurations.value.grace_period_hours
          notification_template_id = scheduled_action_configurations.value.notification_template_id
          notification_message_cc_list = scheduled_action_configurations.value.notification_message_cc_list
        }
      }
    }
  }

  # Assignments
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
# Microsoft Intune Device Compliance Policy - iOS
################################################################################

resource "microsoft365_device_compliance_policy_ios" "this" {
  count = var.create && var.platform == "iOS" ? 1 : 0

  display_name = var.display_name
  description  = var.description

  # Passcode settings
  passcode_required                          = try(var.ios_compliance_settings.passcode_required, false)
  passcode_block_simple                      = try(var.ios_compliance_settings.passcode_block_simple, false)
  passcode_minimum_length                    = try(var.ios_compliance_settings.passcode_minimum_length, null)
  passcode_required_type                     = try(var.ios_compliance_settings.passcode_required_type, "deviceDefault")
  passcode_minutes_of_inactivity_before_lock = try(var.ios_compliance_settings.passcode_minutes_of_inactivity_before_lock, null)
  passcode_expiration_days                   = try(var.ios_compliance_settings.passcode_expiration_days, null)
  passcode_previous_passcode_block_count     = try(var.ios_compliance_settings.passcode_previous_passcode_block_count, null)

  # OS version settings
  os_minimum_version       = try(var.ios_compliance_settings.os_minimum_version, null)
  os_maximum_version       = try(var.ios_compliance_settings.os_maximum_version, null)
  os_minimum_build_version = try(var.ios_compliance_settings.os_minimum_build_version, null)
  os_maximum_build_version = try(var.ios_compliance_settings.os_maximum_build_version, null)

  # Security settings
  security_block_jailbroken_devices = try(var.ios_compliance_settings.security_block_jailbroken_devices, false)

  # Device threat protection
  device_threat_protection_enabled                = try(var.ios_compliance_settings.device_threat_protection_enabled, false)
  device_threat_protection_required_security_level = try(var.ios_compliance_settings.device_threat_protection_required_security_level, null)

  # Email settings
  managed_email_profile_required = try(var.ios_compliance_settings.managed_email_profile_required, false)

  # Scheduled actions for non-compliance
  dynamic "scheduled_actions_for_rule" {
    for_each = var.scheduled_actions_for_rule
    content {
      rule_name = scheduled_actions_for_rule.value.rule_name

      dynamic "scheduled_action_configurations" {
        for_each = scheduled_actions_for_rule.value.scheduled_action_configurations
        content {
          action_type          = scheduled_action_configurations.value.action_type
          grace_period_hours   = scheduled_action_configurations.value.grace_period_hours
          notification_template_id = scheduled_action_configurations.value.notification_template_id
          notification_message_cc_list = scheduled_action_configurations.value.notification_message_cc_list
        }
      }
    }
  }

  # Assignments
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
# Microsoft Intune Device Compliance Policy - Android
################################################################################

resource "microsoft365_device_compliance_policy_android" "this" {
  count = var.create && var.platform == "android" ? 1 : 0

  display_name = var.display_name
  description  = var.description

  # Password settings
  password_required                          = try(var.android_compliance_settings.password_required, false)
  password_minimum_length                    = try(var.android_compliance_settings.password_minimum_length, null)
  password_required_type                     = try(var.android_compliance_settings.password_required_type, "deviceDefault")
  password_minutes_of_inactivity_before_lock = try(var.android_compliance_settings.password_minutes_of_inactivity_before_lock, null)
  password_expiration_days                   = try(var.android_compliance_settings.password_expiration_days, null)
  password_previous_password_block_count     = try(var.android_compliance_settings.password_previous_password_block_count, null)

  # Security settings
  security_prevent_install_apps_from_unknown_sources = try(var.android_compliance_settings.security_prevent_install_apps_from_unknown_sources, false)
  security_disable_usb_debugging                     = try(var.android_compliance_settings.security_disable_usb_debugging, false)
  security_require_verify_apps                       = try(var.android_compliance_settings.security_require_verify_apps, false)
  security_block_jailbroken_devices                  = try(var.android_compliance_settings.security_block_jailbroken_devices, false)

  # Device threat protection
  device_threat_protection_enabled                = try(var.android_compliance_settings.device_threat_protection_enabled, false)
  device_threat_protection_required_security_level = try(var.android_compliance_settings.device_threat_protection_required_security_level, null)

  # OS version settings
  os_minimum_version               = try(var.android_compliance_settings.os_minimum_version, null)
  os_maximum_version               = try(var.android_compliance_settings.os_maximum_version, null)
  min_android_security_patch_level = try(var.android_compliance_settings.min_android_security_patch_level, null)

  # Encryption
  storage_require_encryption = try(var.android_compliance_settings.storage_require_encryption, false)

  # Google Play settings
  security_require_safety_net_attestation_basic_integrity    = try(var.android_compliance_settings.security_require_safety_net_attestation_basic_integrity, false)
  security_require_safety_net_attestation_certified_device   = try(var.android_compliance_settings.security_require_safety_net_attestation_certified_device, false)
  security_require_google_play_services                      = try(var.android_compliance_settings.security_require_google_play_services, false)
  security_require_up_to_date_security_providers             = try(var.android_compliance_settings.security_require_up_to_date_security_providers, false)
  security_require_company_portal_app_integrity              = try(var.android_compliance_settings.security_require_company_portal_app_integrity, false)

  # Scheduled actions for non-compliance
  dynamic "scheduled_actions_for_rule" {
    for_each = var.scheduled_actions_for_rule
    content {
      rule_name = scheduled_actions_for_rule.value.rule_name

      dynamic "scheduled_action_configurations" {
        for_each = scheduled_actions_for_rule.value.scheduled_action_configurations
        content {
          action_type          = scheduled_action_configurations.value.action_type
          grace_period_hours   = scheduled_action_configurations.value.grace_period_hours
          notification_template_id = scheduled_action_configurations.value.notification_template_id
          notification_message_cc_list = scheduled_action_configurations.value.notification_message_cc_list
        }
      }
    }
  }

  # Assignments
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
# Microsoft Intune Device Compliance Policy - macOS
################################################################################

resource "microsoft365_device_compliance_policy_macos" "this" {
  count = var.create && var.platform == "macOS" ? 1 : 0

  display_name = var.display_name
  description  = var.description

  # Password settings
  password_required                          = try(var.macos_compliance_settings.password_required, false)
  password_block_simple                      = try(var.macos_compliance_settings.password_block_simple, false)
  password_minimum_length                    = try(var.macos_compliance_settings.password_minimum_length, null)
  password_required_type                     = try(var.macos_compliance_settings.password_required_type, "deviceDefault")
  password_minutes_of_inactivity_before_lock = try(var.macos_compliance_settings.password_minutes_of_inactivity_before_lock, null)
  password_expiration_days                   = try(var.macos_compliance_settings.password_expiration_days, null)
  password_previous_password_block_count     = try(var.macos_compliance_settings.password_previous_password_block_count, null)

  # OS version settings
  os_minimum_version       = try(var.macos_compliance_settings.os_minimum_version, null)
  os_maximum_version       = try(var.macos_compliance_settings.os_maximum_version, null)
  os_minimum_build_version = try(var.macos_compliance_settings.os_minimum_build_version, null)
  os_maximum_build_version = try(var.macos_compliance_settings.os_maximum_build_version, null)

  # Security settings
  system_integrity_protection_enabled = try(var.macos_compliance_settings.system_integrity_protection_enabled, false)
  storage_require_encryption          = try(var.macos_compliance_settings.storage_require_encryption, false)

  # Firewall settings
  firewall_enabled             = try(var.macos_compliance_settings.firewall_enabled, false)
  firewall_block_all_incoming  = try(var.macos_compliance_settings.firewall_block_all_incoming, false)
  firewall_enable_stealth_mode = try(var.macos_compliance_settings.firewall_enable_stealth_mode, false)

  # Gatekeeper
  gatekeeper_allowed_app_source = try(var.macos_compliance_settings.gatekeeper_allowed_app_source, null)

  # Device threat protection
  device_threat_protection_enabled                = try(var.macos_compliance_settings.device_threat_protection_enabled, false)
  device_threat_protection_required_security_level = try(var.macos_compliance_settings.device_threat_protection_required_security_level, null)

  # Scheduled actions for non-compliance
  dynamic "scheduled_actions_for_rule" {
    for_each = var.scheduled_actions_for_rule
    content {
      rule_name = scheduled_actions_for_rule.value.rule_name

      dynamic "scheduled_action_configurations" {
        for_each = scheduled_actions_for_rule.value.scheduled_action_configurations
        content {
          action_type          = scheduled_action_configurations.value.action_type
          grace_period_hours   = scheduled_action_configurations.value.grace_period_hours
          notification_template_id = scheduled_action_configurations.value.notification_template_id
          notification_message_cc_list = scheduled_action_configurations.value.notification_message_cc_list
        }
      }
    }
  }

  # Assignments
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
