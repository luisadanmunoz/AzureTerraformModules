################################################################################
# Microsoft Intune Device Configuration Profile - Windows 10 Device Restrictions
################################################################################

resource "microsoft365_device_configuration_windows10" "device_restrictions" {
  count = var.create && var.platform == "windows10" && var.profile_type == "deviceRestrictions" ? 1 : 0

  display_name = var.display_name
  description  = var.description

  # Account settings
  accounts_block_adding_non_microsoft_account_email = try(var.windows_device_restrictions.accounts_block_adding_non_microsoft_account_email, false)
  accounts_block_microsoft_account_connection       = try(var.windows_device_restrictions.accounts_block_microsoft_account_connection, false)

  # App settings
  apps_allow_trusted_apps_sideloading      = try(var.windows_device_restrictions.apps_allow_trusted_apps_sideloading, "notConfigured")
  apps_block_windows_store_originated_apps = try(var.windows_device_restrictions.apps_block_windows_store_originated_apps, false)

  # Bluetooth
  bluetooth_blocked                 = try(var.windows_device_restrictions.bluetooth_blocked, false)
  bluetooth_block_discoverable_mode = try(var.windows_device_restrictions.bluetooth_block_discoverable_mode, false)
  bluetooth_block_pre_pairing       = try(var.windows_device_restrictions.bluetooth_block_pre_pairing, false)
  bluetooth_block_advertising       = try(var.windows_device_restrictions.bluetooth_block_advertising, false)

  # Camera
  camera_blocked = try(var.windows_device_restrictions.camera_blocked, false)

  # Cellular
  cellular_block_data_when_roaming = try(var.windows_device_restrictions.cellular_block_data_when_roaming, false)
  cellular_block_vpn               = try(var.windows_device_restrictions.cellular_block_vpn, false)
  cellular_block_vpn_when_roaming  = try(var.windows_device_restrictions.cellular_block_vpn_when_roaming, false)

  # Copy/Paste
  copy_paste_blocked = try(var.windows_device_restrictions.copy_paste_blocked, false)

  # Cortana
  cortana_blocked = try(var.windows_device_restrictions.cortana_blocked, false)

  # Device management
  device_management_block_factory_reset_on_mobile = try(var.windows_device_restrictions.device_management_block_factory_reset_on_mobile, false)
  device_management_block_manual_unenroll         = try(var.windows_device_restrictions.device_management_block_manual_unenroll, false)

  # Edge browser
  edge_blocked                           = try(var.windows_device_restrictions.edge_blocked, false)
  edge_block_autofill                    = try(var.windows_device_restrictions.edge_block_autofill, false)
  edge_block_developer_tools             = try(var.windows_device_restrictions.edge_block_developer_tools, false)
  edge_block_extensions                  = try(var.windows_device_restrictions.edge_block_extensions, false)
  edge_block_inprivate_browsing          = try(var.windows_device_restrictions.edge_block_inprivate_browsing, false)
  edge_block_java_script                 = try(var.windows_device_restrictions.edge_block_java_script, false)
  edge_block_password_manager            = try(var.windows_device_restrictions.edge_block_password_manager, false)
  edge_block_popups                      = try(var.windows_device_restrictions.edge_block_popups, false)
  edge_clear_browsing_data_on_exit       = try(var.windows_device_restrictions.edge_clear_browsing_data_on_exit, false)
  edge_cookies_policy                    = try(var.windows_device_restrictions.edge_cookies_policy, "userDefined")
  edge_disable_first_run_page            = try(var.windows_device_restrictions.edge_disable_first_run_page, false)
  edge_require_smart_screen              = try(var.windows_device_restrictions.edge_require_smart_screen, false)

  # General
  location_services_blocked                      = try(var.windows_device_restrictions.location_services_blocked, false)
  lock_screen_allow_timeout_configuration        = try(var.windows_device_restrictions.lock_screen_allow_timeout_configuration, true)
  lock_screen_block_action_center_notifications  = try(var.windows_device_restrictions.lock_screen_block_action_center_notifications, false)
  lock_screen_block_cortana                      = try(var.windows_device_restrictions.lock_screen_block_cortana, false)
  lock_screen_block_toast_notifications          = try(var.windows_device_restrictions.lock_screen_block_toast_notifications, false)

  # Microsoft account
  microsoft_account_blocked              = try(var.windows_device_restrictions.microsoft_account_blocked, false)
  microsoft_account_block_settings_sync  = try(var.windows_device_restrictions.microsoft_account_block_settings_sync, false)

  # NFC
  nfc_blocked = try(var.windows_device_restrictions.nfc_blocked, false)

  # Password
  password_block_simple                              = try(var.windows_device_restrictions.password_block_simple, false)
  password_expiration_days                           = try(var.windows_device_restrictions.password_expiration_days, null)
  password_minimum_character_set_count               = try(var.windows_device_restrictions.password_minimum_character_set_count, null)
  password_minimum_length                            = try(var.windows_device_restrictions.password_minimum_length, null)
  password_minutes_of_inactivity_before_screen_timeout = try(var.windows_device_restrictions.password_minutes_of_inactivity_before_screen_timeout, null)
  password_previous_password_block_count             = try(var.windows_device_restrictions.password_previous_password_block_count, null)
  password_require_when_resume_from_idle_state       = try(var.windows_device_restrictions.password_require_when_resume_from_idle_state, false)
  password_required                                  = try(var.windows_device_restrictions.password_required, false)
  password_required_type                             = try(var.windows_device_restrictions.password_required_type, "deviceDefault")

  # Privacy
  privacy_advertising_id                          = try(var.windows_device_restrictions.privacy_advertising_id, "notConfigured")
  privacy_auto_accept_pairing_and_consent_prompts = try(var.windows_device_restrictions.privacy_auto_accept_pairing_and_consent_prompts, false)
  privacy_block_input_personalization             = try(var.windows_device_restrictions.privacy_block_input_personalization, false)

  # Screen capture
  screen_capture_blocked = try(var.windows_device_restrictions.screen_capture_blocked, false)

  # Search
  search_block_diacritics         = try(var.windows_device_restrictions.search_block_diacritics, false)
  search_block_web_results        = try(var.windows_device_restrictions.search_block_web_results, false)
  search_disable_auto_language_detection = try(var.windows_device_restrictions.search_disable_auto_language_detection, false)

  # Settings
  settings_block_accounts_page     = try(var.windows_device_restrictions.settings_block_accounts_page, false)
  settings_block_apps_page         = try(var.windows_device_restrictions.settings_block_apps_page, false)
  settings_block_devices_page      = try(var.windows_device_restrictions.settings_block_devices_page, false)
  settings_block_gaming_page       = try(var.windows_device_restrictions.settings_block_gaming_page, false)
  settings_block_privacy_page      = try(var.windows_device_restrictions.settings_block_privacy_page, false)
  settings_block_system_page       = try(var.windows_device_restrictions.settings_block_system_page, false)

  # SmartScreen
  smart_screen_block_prompt_override           = try(var.windows_device_restrictions.smart_screen_block_prompt_override, false)
  smart_screen_block_prompt_override_for_files = try(var.windows_device_restrictions.smart_screen_block_prompt_override_for_files, false)
  smart_screen_enable_app_install_control      = try(var.windows_device_restrictions.smart_screen_enable_app_install_control, false)

  # Storage
  storage_block_removable_storage            = try(var.windows_device_restrictions.storage_block_removable_storage, false)
  storage_require_mobile_device_encryption   = try(var.windows_device_restrictions.storage_require_mobile_device_encryption, false)
  storage_require_removable_storage_encryption = try(var.windows_device_restrictions.storage_require_removable_storage_encryption, false)

  # USB
  usb_blocked = try(var.windows_device_restrictions.usb_blocked, false)

  # Voice recording
  voice_recording_blocked = try(var.windows_device_restrictions.voice_recording_blocked, false)

  # WiFi
  wifi_block_automatic_connect_hotspots = try(var.windows_device_restrictions.wifi_block_automatic_connect_hotspots, false)
  wifi_blocked                          = try(var.windows_device_restrictions.wifi_blocked, false)
  wifi_block_manual_configuration       = try(var.windows_device_restrictions.wifi_block_manual_configuration, false)

  # Windows Store
  windows_store_block_auto_update       = try(var.windows_device_restrictions.windows_store_block_auto_update, false)
  windows_store_blocked                 = try(var.windows_device_restrictions.windows_store_blocked, false)
  windows_store_enable_private_store_only = try(var.windows_device_restrictions.windows_store_enable_private_store_only, false)

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
# Microsoft Intune Device Configuration Profile - Windows 10 Custom
################################################################################

resource "microsoft365_device_configuration_custom_windows10" "this" {
  count = var.create && var.platform == "windows10" && var.profile_type == "custom" ? 1 : 0

  display_name = var.display_name
  description  = var.description

  dynamic "oma_setting" {
    for_each = var.windows_custom_settings
    content {
      name        = oma_setting.value.name
      description = oma_setting.value.description
      oma_uri     = oma_setting.value.oma_uri
      data_type   = oma_setting.value.data_type
      value       = oma_setting.value.value
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
# Microsoft Intune Device Configuration Profile - iOS Device Restrictions
################################################################################

resource "microsoft365_device_configuration_ios" "device_restrictions" {
  count = var.create && var.platform == "iOS" && var.profile_type == "deviceRestrictions" ? 1 : 0

  display_name = var.display_name
  description  = var.description

  # App Store
  app_store_block_automatic_downloads = try(var.ios_device_restrictions.app_store_block_automatic_downloads, false)
  app_store_block_in_app_purchases    = try(var.ios_device_restrictions.app_store_block_in_app_purchases, false)
  app_store_blocked                   = try(var.ios_device_restrictions.app_store_blocked, false)
  app_store_require_password          = try(var.ios_device_restrictions.app_store_require_password, false)

  # Built-in apps
  camera_blocked         = try(var.ios_device_restrictions.camera_blocked, false)
  face_time_blocked      = try(var.ios_device_restrictions.face_time_blocked, false)
  game_center_blocked    = try(var.ios_device_restrictions.game_center_blocked, false)
  messages_blocked       = try(var.ios_device_restrictions.messages_blocked, false)
  safari_blocked         = try(var.ios_device_restrictions.safari_blocked, false)
  safari_block_autofill  = try(var.ios_device_restrictions.safari_block_autofill, false)
  safari_block_popups    = try(var.ios_device_restrictions.safari_block_popups, false)
  siri_blocked           = try(var.ios_device_restrictions.siri_blocked, false)
  siri_blocked_when_locked = try(var.ios_device_restrictions.siri_blocked_when_locked, false)

  # Cloud and storage
  icloud_block_backup         = try(var.ios_device_restrictions.icloud_block_backup, false)
  icloud_block_document_sync  = try(var.ios_device_restrictions.icloud_block_document_sync, false)
  icloud_block_photo_library  = try(var.ios_device_restrictions.icloud_block_photo_library, false)
  icloud_require_encrypted_backup = try(var.ios_device_restrictions.icloud_require_encrypted_backup, false)

  # Connected devices
  air_drop_blocked               = try(var.ios_device_restrictions.air_drop_blocked, false)
  apple_watch_block_pairing      = try(var.ios_device_restrictions.apple_watch_block_pairing, false)
  bluetooth_block_modification   = try(var.ios_device_restrictions.bluetooth_block_modification, false)

  # General
  device_block_erase_content_and_settings = try(var.ios_device_restrictions.device_block_erase_content_and_settings, false)
  device_block_name_modification          = try(var.ios_device_restrictions.device_block_name_modification, false)
  diagnostic_data_block_submission        = try(var.ios_device_restrictions.diagnostic_data_block_submission, false)
  host_pairing_blocked                    = try(var.ios_device_restrictions.host_pairing_blocked, false)

  # Keyboard
  keyboard_block_auto_correct  = try(var.ios_device_restrictions.keyboard_block_auto_correct, false)
  keyboard_block_dictation     = try(var.ios_device_restrictions.keyboard_block_dictation, false)
  keyboard_block_predictive    = try(var.ios_device_restrictions.keyboard_block_predictive, false)
  keyboard_block_spell_check   = try(var.ios_device_restrictions.keyboard_block_spell_check, false)

  # Lock screen
  lock_screen_block_control_center     = try(var.ios_device_restrictions.lock_screen_block_control_center, false)
  lock_screen_block_notification_view  = try(var.ios_device_restrictions.lock_screen_block_notification_view, false)
  lock_screen_block_passbook           = try(var.ios_device_restrictions.lock_screen_block_passbook, false)
  lock_screen_block_today_view         = try(var.ios_device_restrictions.lock_screen_block_today_view, false)

  # Passcode
  passcode_block_simple                              = try(var.ios_device_restrictions.passcode_block_simple, false)
  passcode_expiration_days                           = try(var.ios_device_restrictions.passcode_expiration_days, null)
  passcode_minimum_length                            = try(var.ios_device_restrictions.passcode_minimum_length, null)
  passcode_minutes_of_inactivity_before_lock         = try(var.ios_device_restrictions.passcode_minutes_of_inactivity_before_lock, null)
  passcode_minutes_of_inactivity_before_screen_timeout = try(var.ios_device_restrictions.passcode_minutes_of_inactivity_before_screen_timeout, null)
  passcode_previous_passcode_block_count             = try(var.ios_device_restrictions.passcode_previous_passcode_block_count, null)
  passcode_required                                  = try(var.ios_device_restrictions.passcode_required, false)
  passcode_required_type                             = try(var.ios_device_restrictions.passcode_required_type, "deviceDefault")

  # Screen capture
  screen_capture_blocked = try(var.ios_device_restrictions.screen_capture_blocked, false)

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
