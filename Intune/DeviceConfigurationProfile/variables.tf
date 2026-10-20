################################################################################
# Required Variables
################################################################################

variable "display_name" {
  description = "The display name of the device configuration profile."
  type        = string
}

variable "platform" {
  description = "The platform for the configuration profile. Possible values are windows10, iOS, android, macOS."
  type        = string

  validation {
    condition     = contains(["windows10", "iOS", "android", "macOS"], var.platform)
    error_message = "The platform must be one of: windows10, iOS, android, macOS."
  }
}

variable "profile_type" {
  description = "The type of configuration profile."
  type        = string
}

################################################################################
# Optional - Creation Control
################################################################################

variable "create" {
  description = "Whether to create the device configuration profile resource."
  type        = bool
  default     = true
}

################################################################################
# Optional - Configuration
################################################################################

variable "description" {
  description = "The description of the device configuration profile."
  type        = string
  default     = null
}

################################################################################
# Optional - Windows 10 Device Restrictions
################################################################################

variable "windows_device_restrictions" {
  description = "Windows 10 device restrictions configuration."
  type = object({
    # Account settings
    accounts_block_adding_non_microsoft_account_email = optional(bool, false)
    accounts_block_microsoft_account_connection       = optional(bool, false)

    # App settings
    apps_allow_trusted_apps_sideloading     = optional(string, "notConfigured")
    apps_block_windows_store_originated_apps = optional(bool, false)

    # Bluetooth
    bluetooth_blocked                      = optional(bool, false)
    bluetooth_block_discoverable_mode      = optional(bool, false)
    bluetooth_block_pre_pairing            = optional(bool, false)
    bluetooth_block_advertising            = optional(bool, false)

    # Camera
    camera_blocked = optional(bool, false)

    # Cellular and connectivity
    cellular_block_data_when_roaming   = optional(bool, false)
    cellular_block_vpn                 = optional(bool, false)
    cellular_block_vpn_when_roaming    = optional(bool, false)
    connected_devices_service_blocked  = optional(bool, false)

    # Copy/Paste
    copy_paste_blocked = optional(bool, false)

    # Cortana
    cortana_blocked = optional(bool, false)

    # Device lock
    device_management_block_factory_reset_on_mobile = optional(bool, false)
    device_management_block_manual_unenroll         = optional(bool, false)

    # Edge browser
    edge_blocked                              = optional(bool, false)
    edge_block_address_bar_dropdown           = optional(bool, false)
    edge_block_autofill                       = optional(bool, false)
    edge_block_compatibility_list             = optional(bool, false)
    edge_block_developer_tools                = optional(bool, false)
    edge_block_extensions                     = optional(bool, false)
    edge_block_inprivate_browsing             = optional(bool, false)
    edge_block_java_script                    = optional(bool, false)
    edge_block_password_manager               = optional(bool, false)
    edge_block_popups                         = optional(bool, false)
    edge_block_search_suggestions             = optional(bool, false)
    edge_block_sending_do_not_track_header    = optional(bool, false)
    edge_block_sending_intranet_traffic_to_ie = optional(bool, false)
    edge_clear_browsing_data_on_exit          = optional(bool, false)
    edge_cookies_policy                       = optional(string, "userDefined")
    edge_disable_first_run_page               = optional(bool, false)
    edge_enterprise_mode_site_list_location   = optional(string)
    edge_require_smart_screen                 = optional(bool, false)
    edge_search_engine                        = optional(string)
    edge_sync_favorites_with_ie               = optional(bool, false)

    # General
    games_block_windows_store_optimized_apps = optional(bool, false)
    internet_sharing_blocked                 = optional(bool, false)
    location_services_blocked                = optional(bool, false)
    lock_screen_block_action_center_notifications = optional(bool, false)
    lock_screen_allow_timeout_configuration  = optional(bool, true)
    lock_screen_block_cortana                = optional(bool, false)
    lock_screen_block_toast_notifications    = optional(bool, false)
    logon_block_fast_user_switching          = optional(bool, false)

    # Microsoft account
    microsoft_account_blocked                         = optional(bool, false)
    microsoft_account_block_settings_sync             = optional(bool, false)
    microsoft_account_sign_in_assistant_settings      = optional(string, "notConfigured")

    # Network
    network_proxy_apply_settings_device_wide          = optional(bool, false)
    network_proxy_automatic_configuration_url         = optional(string)
    network_proxy_disable_auto_detect                 = optional(bool, false)

    # NFC
    nfc_blocked = optional(bool, false)

    # Password
    password_block_simple                    = optional(bool, false)
    password_expiration_days                 = optional(number)
    password_minimum_age_in_days             = optional(number)
    password_minimum_character_set_count     = optional(number)
    password_minimum_length                  = optional(number)
    password_minutes_of_inactivity_before_screen_timeout = optional(number)
    password_previous_password_block_count   = optional(number)
    password_require_when_resume_from_idle_state = optional(bool, false)
    password_required                        = optional(bool, false)
    password_required_type                   = optional(string, "deviceDefault")
    password_sign_in_failure_count_before_factory_reset = optional(number)

    # Personalization
    personalization_desktop_image_url = optional(string)
    personalization_lock_screen_image_url = optional(string)

    # Privacy
    privacy_advertising_id                          = optional(string, "notConfigured")
    privacy_auto_accept_pairing_and_consent_prompts = optional(bool, false)
    privacy_block_activity_feed                     = optional(bool, false)
    privacy_block_input_personalization             = optional(bool, false)
    privacy_block_publish_user_activities           = optional(bool, false)

    # Reset protection
    reset_protection_mode_blocked = optional(bool, false)

    # Safe search
    safe_search_filter = optional(string, "userDefined")

    # Screen capture
    screen_capture_blocked = optional(bool, false)

    # Search
    search_block_diacritics                = optional(bool, false)
    search_block_web_results               = optional(bool, false)
    search_disable_auto_language_detection = optional(bool, false)
    search_disable_indexer_backoff         = optional(bool, false)
    search_disable_indexing_encrypted_items = optional(bool, false)
    search_disable_indexing_removable_drive = optional(bool, false)
    search_disable_location                 = optional(bool, false)
    search_disable_use_location             = optional(bool, false)
    search_enable_automatic_index_size_management = optional(bool, false)
    search_enable_remote_queries            = optional(bool, false)

    # Settings
    settings_block_accounts_page       = optional(bool, false)
    settings_block_apps_page           = optional(bool, false)
    settings_block_change_language     = optional(bool, false)
    settings_block_change_power_sleep  = optional(bool, false)
    settings_block_change_region       = optional(bool, false)
    settings_block_change_system_time  = optional(bool, false)
    settings_block_devices_page        = optional(bool, false)
    settings_block_ease_of_access_page = optional(bool, false)
    settings_block_edit_device_name    = optional(bool, false)
    settings_block_gaming_page         = optional(bool, false)
    settings_block_network_internet_page = optional(bool, false)
    settings_block_personalization_page  = optional(bool, false)
    settings_block_privacy_page        = optional(bool, false)
    settings_block_remove_provisioning_package = optional(bool, false)
    settings_block_system_page         = optional(bool, false)
    settings_block_time_language_page  = optional(bool, false)
    settings_block_update_security_page = optional(bool, false)

    # Shared user experience
    shared_user_app_data_allowed = optional(bool, false)

    # SmartScreen
    smart_screen_block_prompt_override          = optional(bool, false)
    smart_screen_block_prompt_override_for_files = optional(bool, false)
    smart_screen_enable_app_install_control     = optional(bool, false)

    # Start menu
    start_block_unpinning_apps_from_taskbar          = optional(bool, false)
    start_menu_app_list_visibility                   = optional(string, "userDefined")
    start_menu_hide_change_account_settings          = optional(bool, false)
    start_menu_hide_frequently_used_apps             = optional(bool, false)
    start_menu_hide_hibernate                        = optional(bool, false)
    start_menu_hide_lock                             = optional(bool, false)
    start_menu_hide_power_button                     = optional(bool, false)
    start_menu_hide_recent_jump_lists                = optional(bool, false)
    start_menu_hide_recently_added_apps              = optional(bool, false)
    start_menu_hide_restart_options                  = optional(bool, false)
    start_menu_hide_shut_down                        = optional(bool, false)
    start_menu_hide_sign_out                         = optional(bool, false)
    start_menu_hide_sleep                            = optional(bool, false)
    start_menu_hide_switch_account                   = optional(bool, false)
    start_menu_hide_user_tile                        = optional(bool, false)
    start_menu_layout_edge_assets_xml                = optional(string)
    start_menu_layout_xml                            = optional(string)
    start_menu_mode                                  = optional(string, "userDefined")
    start_menu_pinned_folder_documents_visibility    = optional(string, "notConfigured")
    start_menu_pinned_folder_downloads_visibility    = optional(string, "notConfigured")
    start_menu_pinned_folder_file_explorer_visibility = optional(string, "notConfigured")
    start_menu_pinned_folder_home_group_visibility   = optional(string, "notConfigured")
    start_menu_pinned_folder_music_visibility        = optional(string, "notConfigured")
    start_menu_pinned_folder_network_visibility      = optional(string, "notConfigured")
    start_menu_pinned_folder_personal_folder_visibility = optional(string, "notConfigured")
    start_menu_pinned_folder_pictures_visibility     = optional(string, "notConfigured")
    start_menu_pinned_folder_settings_visibility     = optional(string, "notConfigured")
    start_menu_pinned_folder_videos_visibility       = optional(string, "notConfigured")

    # Storage
    storage_block_removable_storage         = optional(bool, false)
    storage_require_mobile_device_encryption = optional(bool, false)
    storage_require_removable_storage_encryption = optional(bool, false)

    # Telemetry
    telemetry_block_data_submission = optional(bool, false)

    # USB
    usb_blocked = optional(bool, false)

    # Voice recording
    voice_recording_blocked = optional(bool, false)

    # WiFi
    wifi_block_automatic_connect_hotspots = optional(bool, false)
    wifi_blocked                          = optional(bool, false)
    wifi_block_manual_configuration       = optional(bool, false)
    wifi_scan_interval                    = optional(number)

    # Windows Hello
    windows_spotlight_block_consumer_specific_features    = optional(bool, false)
    windows_spotlight_block_on_action_center              = optional(bool, false)
    windows_spotlight_block_tailored_experiences          = optional(bool, false)
    windows_spotlight_block_third_party_notifications     = optional(bool, false)
    windows_spotlight_block_welcome_experience            = optional(bool, false)
    windows_spotlight_block_windows_tips                  = optional(bool, false)
    windows_spotlight_blocked                             = optional(bool, false)
    windows_spotlight_configure_on_lock_screen            = optional(string, "notConfigured")
    windows_store_block_auto_update                       = optional(bool, false)
    windows_store_blocked                                 = optional(bool, false)
    windows_store_enable_private_store_only               = optional(bool, false)
    wireless_display_block_projection_to_this_device      = optional(bool, false)
    wireless_display_block_user_input_from_receiver       = optional(bool, false)
    wireless_display_require_pin_for_pairing              = optional(bool, false)
  })
  default = null
}

################################################################################
# Optional - Windows 10 Custom Configuration
################################################################################

variable "windows_custom_settings" {
  description = "Windows 10 custom OMA-URI settings."
  type = list(object({
    name        = string
    description = optional(string)
    oma_uri     = string
    data_type   = string
    value       = string
  }))
  default = []
}

################################################################################
# Optional - iOS Device Restrictions
################################################################################

variable "ios_device_restrictions" {
  description = "iOS device restrictions configuration."
  type = object({
    # App Store, Doc viewing, Gaming
    app_store_block_automatic_downloads        = optional(bool, false)
    app_store_block_in_app_purchases           = optional(bool, false)
    app_store_block_ui_app_installation        = optional(bool, false)
    app_store_blocked                          = optional(bool, false)
    app_store_require_password                 = optional(bool, false)
    apps_visibility_list                       = optional(list(object({
      name       = string
      app_id     = string
      publisher  = optional(string)
    })), [])
    apps_visibility_list_type                  = optional(string, "none")

    # Built-in apps
    camera_blocked                             = optional(bool, false)
    face_time_blocked                          = optional(bool, false)
    find_my_friends_blocked                    = optional(bool, false)
    game_center_blocked                        = optional(bool, false)
    itunes_block_explicit_content              = optional(bool, false)
    itunes_block_music_service                 = optional(bool, false)
    itunes_block_radio                         = optional(bool, false)
    messages_blocked                           = optional(bool, false)
    news_blocked                               = optional(bool, false)
    podcasts_blocked                           = optional(bool, false)
    safari_blocked                             = optional(bool, false)
    safari_block_autofill                      = optional(bool, false)
    safari_block_java_script                   = optional(bool, false)
    safari_block_popups                        = optional(bool, false)
    safari_cookie_settings                     = optional(string, "browserDefault")
    safari_require_fraud_warning               = optional(bool, false)
    siri_blocked                               = optional(bool, false)
    siri_blocked_when_locked                   = optional(bool, false)
    siri_block_explicit_content                = optional(bool, false)
    siri_require_profanity_filter              = optional(bool, false)
    spotlight_block_internet_results           = optional(bool, false)

    # Cloud and storage
    icloud_block_activity_continuation         = optional(bool, false)
    icloud_block_backup                        = optional(bool, false)
    icloud_block_document_sync                 = optional(bool, false)
    icloud_block_managed_apps_sync             = optional(bool, false)
    icloud_block_photo_library                 = optional(bool, false)
    icloud_block_photo_stream_sync             = optional(bool, false)
    icloud_block_shared_photo_stream           = optional(bool, false)
    icloud_require_encrypted_backup            = optional(bool, false)

    # Connected devices
    airprint_blocked                           = optional(bool, false)
    air_drop_blocked                           = optional(bool, false)
    air_drop_force_unmanaged_drop_target       = optional(bool, false)
    apple_watch_block_pairing                  = optional(bool, false)
    bluetooth_block_modification               = optional(bool, false)

    # General
    cell_data_block_data_roaming               = optional(bool, false)
    cell_data_block_global_background_fetch    = optional(bool, false)
    certificates_block_untrusted_tls_certificates = optional(bool, false)
    classroom_app_block_remote_screen_observation = optional(bool, false)
    definition_lookup_blocked                  = optional(bool, false)
    device_block_enable_restrictions           = optional(bool, false)
    device_block_erase_content_and_settings    = optional(bool, false)
    device_block_name_modification             = optional(bool, false)
    diagnostic_data_block_submission           = optional(bool, false)
    diagnostic_data_block_submission_modification = optional(bool, false)
    enterprise_app_block_trust                 = optional(bool, false)
    enterprise_app_block_trust_modification    = optional(bool, false)
    host_pairing_blocked                       = optional(bool, false)
    keyboard_block_auto_correct                = optional(bool, false)
    keyboard_block_dictation                   = optional(bool, false)
    keyboard_block_predictive                  = optional(bool, false)
    keyboard_block_shortcuts                   = optional(bool, false)
    keyboard_block_spell_check                 = optional(bool, false)
    lock_screen_block_control_center           = optional(bool, false)
    lock_screen_block_notification_view        = optional(bool, false)
    lock_screen_block_passbook                 = optional(bool, false)
    lock_screen_block_today_view               = optional(bool, false)
    notification_alert_type                    = optional(string, "none")
    notifications_block_settings_modification  = optional(bool, false)
    passcode_block_fingerprint_modification    = optional(bool, false)
    passcode_block_fingerprint_unlock          = optional(bool, false)
    passcode_block_modification                = optional(bool, false)
    passcode_block_simple                      = optional(bool, false)
    passcode_expiration_days                   = optional(number)
    passcode_minimum_character_set_count       = optional(number)
    passcode_minimum_length                    = optional(number)
    passcode_minutes_of_inactivity_before_lock = optional(number)
    passcode_minutes_of_inactivity_before_screen_timeout = optional(number)
    passcode_previous_passcode_block_count     = optional(number)
    passcode_required                          = optional(bool, false)
    passcode_required_type                     = optional(string, "deviceDefault")
    passcode_sign_in_failure_count_before_wipe = optional(number)
    screen_capture_blocked                     = optional(bool, false)
    voice_dialing_blocked                      = optional(bool, false)
    wallpaper_block_modification               = optional(bool, false)
  })
  default = null
}

################################################################################
# Optional - Assignments
################################################################################

variable "assignments" {
  description = "Profile assignments to groups."
  type = list(object({
    target_type = string
    group_id    = optional(string)
    filter_id   = optional(string)
    filter_type = optional(string)
  }))
  default = []
}

################################################################################
# Optional - Tags
################################################################################

variable "tags" {
  description = "A map of tags (for module consistency, not applied to resource)."
  type        = map(string)
  default     = {}
}
