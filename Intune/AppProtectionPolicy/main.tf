################################################################################
# Microsoft Intune App Protection Policy - iOS
################################################################################

resource "microsoft365_app_protection_policy_ios" "this" {
  count = var.create && var.platform == "iOS" ? 1 : 0

  display_name = var.display_name
  description  = var.description

  # Data protection settings
  allow_backup               = try(var.data_protection.allow_backup, true)
  data_backup_blocked        = try(var.data_protection.data_backup_blocked, false)
  device_compliance_required = try(var.data_protection.device_compliance_required, false)
  encrypt_app_data           = try(var.data_protection.encrypt_app_data, true)
  contact_sync_blocked       = try(var.data_protection.contact_sync_blocked, false)
  printing_blocked           = try(var.data_protection.printing_blocked, false)
  save_as_blocked            = try(var.data_protection.save_as_blocked, false)
  third_party_keyboards_blocked = try(var.data_protection.third_party_keyboards_blocked, false)
  face_id_blocked            = try(var.data_protection.face_id_blocked, false)

  # Data transfer
  allowed_inbound_data_transfer_sources         = try(var.access_requirements.allowed_inbound_data_transfer_sources, "allApps")
  allowed_outbound_clipboard_sharing_level      = try(var.access_requirements.allowed_outbound_clipboard_sharing_level, "allApps")
  allowed_outbound_data_transfer_destinations   = try(var.access_requirements.allowed_outbound_data_transfer_destinations, "allApps")
  managed_browser_to_open_links_required        = try(var.data_protection.managed_browser_to_open_links_required, false)
  organizational_credentials_required           = try(var.data_protection.organizational_credentials_required, false)

  # Access requirements
  pin_required                       = try(var.access_requirements.pin_required, true)
  simple_pin_blocked                 = try(var.access_requirements.simple_pin_blocked, false)
  minimum_pin_length                 = try(var.access_requirements.minimum_pin_length, 4)
  pin_character_set                  = try(var.access_requirements.pin_character_set, "numeric")
  fingerprint_blocked                = try(var.access_requirements.fingerprint_blocked, false)
  touch_id_blocked                   = try(var.access_requirements.touch_id_blocked, false)

  # Period settings
  period_before_pin_reset            = try(var.access_requirements.period_before_pin_reset, "PT0S")
  period_offline_before_access_check = try(var.access_requirements.period_offline_before_access_check, "PT720M")
  period_offline_before_wipe         = try(var.access_requirements.period_offline_before_wipe, "P90D")
  period_online_before_access_check  = try(var.access_requirements.period_online_before_access_check, "PT30M")

  # Conditional launch
  minimum_required_os_version        = try(var.conditional_launch.min_os_version, null)
  maximum_required_os_version        = try(var.conditional_launch.max_os_version, null)
  minimum_required_app_version       = try(var.conditional_launch.min_app_version, null)
  maximum_required_app_version       = try(var.conditional_launch.max_app_version, null)
  minimum_required_sdk_version       = try(var.conditional_launch.min_sdk_version, null)

  # Apps
  dynamic "apps" {
    for_each = var.apps
    content {
      app_id    = apps.value.app_id
      name      = apps.value.name
      publisher = apps.value.publisher
    }
  }

  # Exempted apps
  dynamic "exempted_apps" {
    for_each = var.exempted_apps
    content {
      app_id    = exempted_apps.value.app_id
      name      = exempted_apps.value.name
      publisher = exempted_apps.value.publisher
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
# Microsoft Intune App Protection Policy - Android
################################################################################

resource "microsoft365_app_protection_policy_android" "this" {
  count = var.create && var.platform == "android" ? 1 : 0

  display_name = var.display_name
  description  = var.description

  # Data protection settings
  data_backup_blocked        = try(var.data_protection.data_backup_blocked, false)
  device_compliance_required = try(var.data_protection.device_compliance_required, false)
  encrypt_app_data           = try(var.data_protection.encrypt_app_data, true)
  contact_sync_blocked       = try(var.data_protection.contact_sync_blocked, false)
  printing_blocked           = try(var.data_protection.printing_blocked, false)
  save_as_blocked            = try(var.data_protection.save_as_blocked, false)
  screen_capture_blocked     = try(var.data_protection.screen_capture_blocked, false)
  disable_app_encryption_if_device_encryption_is_enabled = try(var.data_protection.disable_app_encryption_if_device_encryption_is_enabled, false)

  # Data transfer
  allowed_inbound_data_transfer_sources       = try(var.access_requirements.allowed_inbound_data_transfer_sources, "allApps")
  allowed_outbound_clipboard_sharing_level    = try(var.access_requirements.allowed_outbound_clipboard_sharing_level, "allApps")
  allowed_outbound_data_transfer_destinations = try(var.access_requirements.allowed_outbound_data_transfer_destinations, "allApps")
  managed_browser_to_open_links_required      = try(var.data_protection.managed_browser_to_open_links_required, false)
  organizational_credentials_required         = try(var.data_protection.organizational_credentials_required, false)

  # Access requirements
  pin_required                       = try(var.access_requirements.pin_required, true)
  simple_pin_blocked                 = try(var.access_requirements.simple_pin_blocked, false)
  minimum_pin_length                 = try(var.access_requirements.minimum_pin_length, 4)
  pin_character_set                  = try(var.access_requirements.pin_character_set, "numeric")
  fingerprint_blocked                = try(var.access_requirements.fingerprint_blocked, false)
  biometric_authentication_blocked   = try(var.access_requirements.biometric_authentication_blocked, false)

  # Period settings
  period_before_pin_reset            = try(var.access_requirements.period_before_pin_reset, "PT0S")
  period_offline_before_access_check = try(var.access_requirements.period_offline_before_access_check, "PT720M")
  period_offline_before_wipe         = try(var.access_requirements.period_offline_before_wipe, "P90D")
  period_online_before_access_check  = try(var.access_requirements.period_online_before_access_check, "PT30M")

  # Conditional launch
  minimum_required_os_version  = try(var.conditional_launch.min_os_version, null)
  maximum_required_os_version  = try(var.conditional_launch.max_os_version, null)
  minimum_required_app_version = try(var.conditional_launch.min_app_version, null)
  maximum_required_app_version = try(var.conditional_launch.max_app_version, null)

  # Device conditions
  block_after_company_portal_update_deferral_in_days = try(var.conditional_launch.block_after_company_portal_update_deferral_in_days, null)

  # Apps
  dynamic "apps" {
    for_each = var.apps
    content {
      app_id    = apps.value.app_id
      name      = apps.value.name
      publisher = apps.value.publisher
    }
  }

  # Exempted apps
  dynamic "exempted_apps" {
    for_each = var.exempted_apps
    content {
      app_id    = exempted_apps.value.app_id
      name      = exempted_apps.value.name
      publisher = exempted_apps.value.publisher
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
