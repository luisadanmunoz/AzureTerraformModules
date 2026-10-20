# Microsoft Intune Device Configuration Profile

Terraform module for creating and managing Microsoft Intune Device Configuration Profiles.

## Features

- Windows 10 device restrictions
- Windows 10 custom OMA-URI settings
- iOS device restrictions
- Comprehensive configuration options per platform
- Group assignments with filters

## Usage

### Windows 10 Device Restrictions

```hcl
module "windows_device_restrictions" {
  source = "path/to/Intune/DeviceConfigurationProfile"

  display_name = "Windows 10 Device Restrictions"
  description  = "Corporate device restrictions for Windows 10"
  platform     = "windows10"
  profile_type = "deviceRestrictions"

  windows_device_restrictions = {
    camera_blocked                        = false
    cortana_blocked                       = true
    screen_capture_blocked                = false
    copy_paste_blocked                    = false
    usb_blocked                           = false
    bluetooth_blocked                     = false
    wifi_blocked                          = false
    windows_store_blocked                 = true
    windows_store_enable_private_store_only = true
    password_required                     = true
    password_minimum_length               = 8
    password_required_type                = "alphanumeric"
    edge_block_inprivate_browsing         = true
    edge_require_smart_screen             = true
    smart_screen_block_prompt_override    = true
    storage_block_removable_storage       = true
    device_management_block_manual_unenroll = true
  }

  assignments = [
    {
      target_type = "groupAssignmentTarget"
      group_id    = "00000000-0000-0000-0000-000000000000"
    }
  ]
}
```

### Windows 10 Custom OMA-URI Settings

```hcl
module "windows_custom_settings" {
  source = "path/to/Intune/DeviceConfigurationProfile"

  display_name = "Windows 10 Custom Settings"
  platform     = "windows10"
  profile_type = "custom"

  windows_custom_settings = [
    {
      name      = "Disable Telemetry"
      oma_uri   = "./Device/Vendor/MSFT/Policy/Config/System/AllowTelemetry"
      data_type = "Integer"
      value     = "0"
    },
    {
      name      = "Disable Location"
      oma_uri   = "./Device/Vendor/MSFT/Policy/Config/System/AllowLocation"
      data_type = "Integer"
      value     = "0"
    }
  ]
}
```

### iOS Device Restrictions

```hcl
module "ios_device_restrictions" {
  source = "path/to/Intune/DeviceConfigurationProfile"

  display_name = "iOS Device Restrictions"
  description  = "Corporate device restrictions for iOS"
  platform     = "iOS"
  profile_type = "deviceRestrictions"

  ios_device_restrictions = {
    app_store_blocked                = false
    app_store_require_password       = true
    camera_blocked                   = false
    safari_blocked                   = false
    safari_block_autofill            = true
    safari_block_popups              = true
    icloud_block_backup              = false
    icloud_require_encrypted_backup  = true
    air_drop_blocked                 = true
    passcode_required                = true
    passcode_minimum_length          = 6
    passcode_block_simple            = true
    screen_capture_blocked           = false
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| microsoft365 | >= 0.1.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| display_name | The display name of the profile | `string` | n/a | yes |
| platform | The platform (windows10, iOS, android, macOS) | `string` | n/a | yes |
| profile_type | The type of configuration profile | `string` | n/a | yes |
| create | Whether to create the resource | `bool` | `true` | no |
| description | The description of the profile | `string` | `null` | no |
| windows_device_restrictions | Windows device restrictions config | `object` | `null` | no |
| windows_custom_settings | Windows custom OMA-URI settings | `list(object)` | `[]` | no |
| ios_device_restrictions | iOS device restrictions config | `object` | `null` | no |
| assignments | Profile assignments | `list(object)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the profile |
| display_name | The display name of the profile |
| platform | The platform of the profile |
| profile_type | The type of the profile |
| windows10_device_restrictions_id | Windows 10 device restrictions ID |
| windows10_custom_id | Windows 10 custom profile ID |
| ios_device_restrictions_id | iOS device restrictions ID |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |
| <a name="requirement_microsoft365"></a> [microsoft365](#requirement\_microsoft365) | >= 0.1.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_microsoft365"></a> [microsoft365](#provider\_microsoft365) | >= 0.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [microsoft365_device_configuration_custom_windows10.this](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/device_configuration_custom_windows10) | resource |
| [microsoft365_device_configuration_ios.device_restrictions](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/device_configuration_ios) | resource |
| [microsoft365_device_configuration_windows10.device_restrictions](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/device_configuration_windows10) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_assignments"></a> [assignments](#input\_assignments) | Profile assignments to groups. | <pre>list(object({<br/>    target_type = string<br/>    group_id    = optional(string)<br/>    filter_id   = optional(string)<br/>    filter_type = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the device configuration profile resource. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the device configuration profile. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the device configuration profile. | `string` | n/a | yes |
| <a name="input_ios_device_restrictions"></a> [ios\_device\_restrictions](#input\_ios\_device\_restrictions) | iOS device restrictions configuration. | <pre>object({<br/>    # App Store, Doc viewing, Gaming<br/>    app_store_block_automatic_downloads        = optional(bool, false)<br/>    app_store_block_in_app_purchases           = optional(bool, false)<br/>    app_store_block_ui_app_installation        = optional(bool, false)<br/>    app_store_blocked                          = optional(bool, false)<br/>    app_store_require_password                 = optional(bool, false)<br/>    apps_visibility_list                       = optional(list(object({<br/>      name       = string<br/>      app_id     = string<br/>      publisher  = optional(string)<br/>    })), [])<br/>    apps_visibility_list_type                  = optional(string, "none")<br/><br/>    # Built-in apps<br/>    camera_blocked                             = optional(bool, false)<br/>    face_time_blocked                          = optional(bool, false)<br/>    find_my_friends_blocked                    = optional(bool, false)<br/>    game_center_blocked                        = optional(bool, false)<br/>    itunes_block_explicit_content              = optional(bool, false)<br/>    itunes_block_music_service                 = optional(bool, false)<br/>    itunes_block_radio                         = optional(bool, false)<br/>    messages_blocked                           = optional(bool, false)<br/>    news_blocked                               = optional(bool, false)<br/>    podcasts_blocked                           = optional(bool, false)<br/>    safari_blocked                             = optional(bool, false)<br/>    safari_block_autofill                      = optional(bool, false)<br/>    safari_block_java_script                   = optional(bool, false)<br/>    safari_block_popups                        = optional(bool, false)<br/>    safari_cookie_settings                     = optional(string, "browserDefault")<br/>    safari_require_fraud_warning               = optional(bool, false)<br/>    siri_blocked                               = optional(bool, false)<br/>    siri_blocked_when_locked                   = optional(bool, false)<br/>    siri_block_explicit_content                = optional(bool, false)<br/>    siri_require_profanity_filter              = optional(bool, false)<br/>    spotlight_block_internet_results           = optional(bool, false)<br/><br/>    # Cloud and storage<br/>    icloud_block_activity_continuation         = optional(bool, false)<br/>    icloud_block_backup                        = optional(bool, false)<br/>    icloud_block_document_sync                 = optional(bool, false)<br/>    icloud_block_managed_apps_sync             = optional(bool, false)<br/>    icloud_block_photo_library                 = optional(bool, false)<br/>    icloud_block_photo_stream_sync             = optional(bool, false)<br/>    icloud_block_shared_photo_stream           = optional(bool, false)<br/>    icloud_require_encrypted_backup            = optional(bool, false)<br/><br/>    # Connected devices<br/>    airprint_blocked                           = optional(bool, false)<br/>    air_drop_blocked                           = optional(bool, false)<br/>    air_drop_force_unmanaged_drop_target       = optional(bool, false)<br/>    apple_watch_block_pairing                  = optional(bool, false)<br/>    bluetooth_block_modification               = optional(bool, false)<br/><br/>    # General<br/>    cell_data_block_data_roaming               = optional(bool, false)<br/>    cell_data_block_global_background_fetch    = optional(bool, false)<br/>    certificates_block_untrusted_tls_certificates = optional(bool, false)<br/>    classroom_app_block_remote_screen_observation = optional(bool, false)<br/>    definition_lookup_blocked                  = optional(bool, false)<br/>    device_block_enable_restrictions           = optional(bool, false)<br/>    device_block_erase_content_and_settings    = optional(bool, false)<br/>    device_block_name_modification             = optional(bool, false)<br/>    diagnostic_data_block_submission           = optional(bool, false)<br/>    diagnostic_data_block_submission_modification = optional(bool, false)<br/>    enterprise_app_block_trust                 = optional(bool, false)<br/>    enterprise_app_block_trust_modification    = optional(bool, false)<br/>    host_pairing_blocked                       = optional(bool, false)<br/>    keyboard_block_auto_correct                = optional(bool, false)<br/>    keyboard_block_dictation                   = optional(bool, false)<br/>    keyboard_block_predictive                  = optional(bool, false)<br/>    keyboard_block_shortcuts                   = optional(bool, false)<br/>    keyboard_block_spell_check                 = optional(bool, false)<br/>    lock_screen_block_control_center           = optional(bool, false)<br/>    lock_screen_block_notification_view        = optional(bool, false)<br/>    lock_screen_block_passbook                 = optional(bool, false)<br/>    lock_screen_block_today_view               = optional(bool, false)<br/>    notification_alert_type                    = optional(string, "none")<br/>    notifications_block_settings_modification  = optional(bool, false)<br/>    passcode_block_fingerprint_modification    = optional(bool, false)<br/>    passcode_block_fingerprint_unlock          = optional(bool, false)<br/>    passcode_block_modification                = optional(bool, false)<br/>    passcode_block_simple                      = optional(bool, false)<br/>    passcode_expiration_days                   = optional(number)<br/>    passcode_minimum_character_set_count       = optional(number)<br/>    passcode_minimum_length                    = optional(number)<br/>    passcode_minutes_of_inactivity_before_lock = optional(number)<br/>    passcode_minutes_of_inactivity_before_screen_timeout = optional(number)<br/>    passcode_previous_passcode_block_count     = optional(number)<br/>    passcode_required                          = optional(bool, false)<br/>    passcode_required_type                     = optional(string, "deviceDefault")<br/>    passcode_sign_in_failure_count_before_wipe = optional(number)<br/>    screen_capture_blocked                     = optional(bool, false)<br/>    voice_dialing_blocked                      = optional(bool, false)<br/>    wallpaper_block_modification               = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_platform"></a> [platform](#input\_platform) | The platform for the configuration profile. Possible values are windows10, iOS, android, macOS. | `string` | n/a | yes |
| <a name="input_profile_type"></a> [profile\_type](#input\_profile\_type) | The type of configuration profile. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags (for module consistency, not applied to resource). | `map(string)` | `{}` | no |
| <a name="input_windows_custom_settings"></a> [windows\_custom\_settings](#input\_windows\_custom\_settings) | Windows 10 custom OMA-URI settings. | <pre>list(object({<br/>    name        = string<br/>    description = optional(string)<br/>    oma_uri     = string<br/>    data_type   = string<br/>    value       = string<br/>  }))</pre> | `[]` | no |
| <a name="input_windows_device_restrictions"></a> [windows\_device\_restrictions](#input\_windows\_device\_restrictions) | Windows 10 device restrictions configuration. | <pre>object({<br/>    # Account settings<br/>    accounts_block_adding_non_microsoft_account_email = optional(bool, false)<br/>    accounts_block_microsoft_account_connection       = optional(bool, false)<br/><br/>    # App settings<br/>    apps_allow_trusted_apps_sideloading     = optional(string, "notConfigured")<br/>    apps_block_windows_store_originated_apps = optional(bool, false)<br/><br/>    # Bluetooth<br/>    bluetooth_blocked                      = optional(bool, false)<br/>    bluetooth_block_discoverable_mode      = optional(bool, false)<br/>    bluetooth_block_pre_pairing            = optional(bool, false)<br/>    bluetooth_block_advertising            = optional(bool, false)<br/><br/>    # Camera<br/>    camera_blocked = optional(bool, false)<br/><br/>    # Cellular and connectivity<br/>    cellular_block_data_when_roaming   = optional(bool, false)<br/>    cellular_block_vpn                 = optional(bool, false)<br/>    cellular_block_vpn_when_roaming    = optional(bool, false)<br/>    connected_devices_service_blocked  = optional(bool, false)<br/><br/>    # Copy/Paste<br/>    copy_paste_blocked = optional(bool, false)<br/><br/>    # Cortana<br/>    cortana_blocked = optional(bool, false)<br/><br/>    # Device lock<br/>    device_management_block_factory_reset_on_mobile = optional(bool, false)<br/>    device_management_block_manual_unenroll         = optional(bool, false)<br/><br/>    # Edge browser<br/>    edge_blocked                              = optional(bool, false)<br/>    edge_block_address_bar_dropdown           = optional(bool, false)<br/>    edge_block_autofill                       = optional(bool, false)<br/>    edge_block_compatibility_list             = optional(bool, false)<br/>    edge_block_developer_tools                = optional(bool, false)<br/>    edge_block_extensions                     = optional(bool, false)<br/>    edge_block_inprivate_browsing             = optional(bool, false)<br/>    edge_block_java_script                    = optional(bool, false)<br/>    edge_block_password_manager               = optional(bool, false)<br/>    edge_block_popups                         = optional(bool, false)<br/>    edge_block_search_suggestions             = optional(bool, false)<br/>    edge_block_sending_do_not_track_header    = optional(bool, false)<br/>    edge_block_sending_intranet_traffic_to_ie = optional(bool, false)<br/>    edge_clear_browsing_data_on_exit          = optional(bool, false)<br/>    edge_cookies_policy                       = optional(string, "userDefined")<br/>    edge_disable_first_run_page               = optional(bool, false)<br/>    edge_enterprise_mode_site_list_location   = optional(string)<br/>    edge_require_smart_screen                 = optional(bool, false)<br/>    edge_search_engine                        = optional(string)<br/>    edge_sync_favorites_with_ie               = optional(bool, false)<br/><br/>    # General<br/>    games_block_windows_store_optimized_apps = optional(bool, false)<br/>    internet_sharing_blocked                 = optional(bool, false)<br/>    location_services_blocked                = optional(bool, false)<br/>    lock_screen_block_action_center_notifications = optional(bool, false)<br/>    lock_screen_allow_timeout_configuration  = optional(bool, true)<br/>    lock_screen_block_cortana                = optional(bool, false)<br/>    lock_screen_block_toast_notifications    = optional(bool, false)<br/>    logon_block_fast_user_switching          = optional(bool, false)<br/><br/>    # Microsoft account<br/>    microsoft_account_blocked                         = optional(bool, false)<br/>    microsoft_account_block_settings_sync             = optional(bool, false)<br/>    microsoft_account_sign_in_assistant_settings      = optional(string, "notConfigured")<br/><br/>    # Network<br/>    network_proxy_apply_settings_device_wide          = optional(bool, false)<br/>    network_proxy_automatic_configuration_url         = optional(string)<br/>    network_proxy_disable_auto_detect                 = optional(bool, false)<br/><br/>    # NFC<br/>    nfc_blocked = optional(bool, false)<br/><br/>    # Password<br/>    password_block_simple                    = optional(bool, false)<br/>    password_expiration_days                 = optional(number)<br/>    password_minimum_age_in_days             = optional(number)<br/>    password_minimum_character_set_count     = optional(number)<br/>    password_minimum_length                  = optional(number)<br/>    password_minutes_of_inactivity_before_screen_timeout = optional(number)<br/>    password_previous_password_block_count   = optional(number)<br/>    password_require_when_resume_from_idle_state = optional(bool, false)<br/>    password_required                        = optional(bool, false)<br/>    password_required_type                   = optional(string, "deviceDefault")<br/>    password_sign_in_failure_count_before_factory_reset = optional(number)<br/><br/>    # Personalization<br/>    personalization_desktop_image_url = optional(string)<br/>    personalization_lock_screen_image_url = optional(string)<br/><br/>    # Privacy<br/>    privacy_advertising_id                          = optional(string, "notConfigured")<br/>    privacy_auto_accept_pairing_and_consent_prompts = optional(bool, false)<br/>    privacy_block_activity_feed                     = optional(bool, false)<br/>    privacy_block_input_personalization             = optional(bool, false)<br/>    privacy_block_publish_user_activities           = optional(bool, false)<br/><br/>    # Reset protection<br/>    reset_protection_mode_blocked = optional(bool, false)<br/><br/>    # Safe search<br/>    safe_search_filter = optional(string, "userDefined")<br/><br/>    # Screen capture<br/>    screen_capture_blocked = optional(bool, false)<br/><br/>    # Search<br/>    search_block_diacritics                = optional(bool, false)<br/>    search_block_web_results               = optional(bool, false)<br/>    search_disable_auto_language_detection = optional(bool, false)<br/>    search_disable_indexer_backoff         = optional(bool, false)<br/>    search_disable_indexing_encrypted_items = optional(bool, false)<br/>    search_disable_indexing_removable_drive = optional(bool, false)<br/>    search_disable_location                 = optional(bool, false)<br/>    search_disable_use_location             = optional(bool, false)<br/>    search_enable_automatic_index_size_management = optional(bool, false)<br/>    search_enable_remote_queries            = optional(bool, false)<br/><br/>    # Settings<br/>    settings_block_accounts_page       = optional(bool, false)<br/>    settings_block_apps_page           = optional(bool, false)<br/>    settings_block_change_language     = optional(bool, false)<br/>    settings_block_change_power_sleep  = optional(bool, false)<br/>    settings_block_change_region       = optional(bool, false)<br/>    settings_block_change_system_time  = optional(bool, false)<br/>    settings_block_devices_page        = optional(bool, false)<br/>    settings_block_ease_of_access_page = optional(bool, false)<br/>    settings_block_edit_device_name    = optional(bool, false)<br/>    settings_block_gaming_page         = optional(bool, false)<br/>    settings_block_network_internet_page = optional(bool, false)<br/>    settings_block_personalization_page  = optional(bool, false)<br/>    settings_block_privacy_page        = optional(bool, false)<br/>    settings_block_remove_provisioning_package = optional(bool, false)<br/>    settings_block_system_page         = optional(bool, false)<br/>    settings_block_time_language_page  = optional(bool, false)<br/>    settings_block_update_security_page = optional(bool, false)<br/><br/>    # Shared user experience<br/>    shared_user_app_data_allowed = optional(bool, false)<br/><br/>    # SmartScreen<br/>    smart_screen_block_prompt_override          = optional(bool, false)<br/>    smart_screen_block_prompt_override_for_files = optional(bool, false)<br/>    smart_screen_enable_app_install_control     = optional(bool, false)<br/><br/>    # Start menu<br/>    start_block_unpinning_apps_from_taskbar          = optional(bool, false)<br/>    start_menu_app_list_visibility                   = optional(string, "userDefined")<br/>    start_menu_hide_change_account_settings          = optional(bool, false)<br/>    start_menu_hide_frequently_used_apps             = optional(bool, false)<br/>    start_menu_hide_hibernate                        = optional(bool, false)<br/>    start_menu_hide_lock                             = optional(bool, false)<br/>    start_menu_hide_power_button                     = optional(bool, false)<br/>    start_menu_hide_recent_jump_lists                = optional(bool, false)<br/>    start_menu_hide_recently_added_apps              = optional(bool, false)<br/>    start_menu_hide_restart_options                  = optional(bool, false)<br/>    start_menu_hide_shut_down                        = optional(bool, false)<br/>    start_menu_hide_sign_out                         = optional(bool, false)<br/>    start_menu_hide_sleep                            = optional(bool, false)<br/>    start_menu_hide_switch_account                   = optional(bool, false)<br/>    start_menu_hide_user_tile                        = optional(bool, false)<br/>    start_menu_layout_edge_assets_xml                = optional(string)<br/>    start_menu_layout_xml                            = optional(string)<br/>    start_menu_mode                                  = optional(string, "userDefined")<br/>    start_menu_pinned_folder_documents_visibility    = optional(string, "notConfigured")<br/>    start_menu_pinned_folder_downloads_visibility    = optional(string, "notConfigured")<br/>    start_menu_pinned_folder_file_explorer_visibility = optional(string, "notConfigured")<br/>    start_menu_pinned_folder_home_group_visibility   = optional(string, "notConfigured")<br/>    start_menu_pinned_folder_music_visibility        = optional(string, "notConfigured")<br/>    start_menu_pinned_folder_network_visibility      = optional(string, "notConfigured")<br/>    start_menu_pinned_folder_personal_folder_visibility = optional(string, "notConfigured")<br/>    start_menu_pinned_folder_pictures_visibility     = optional(string, "notConfigured")<br/>    start_menu_pinned_folder_settings_visibility     = optional(string, "notConfigured")<br/>    start_menu_pinned_folder_videos_visibility       = optional(string, "notConfigured")<br/><br/>    # Storage<br/>    storage_block_removable_storage         = optional(bool, false)<br/>    storage_require_mobile_device_encryption = optional(bool, false)<br/>    storage_require_removable_storage_encryption = optional(bool, false)<br/><br/>    # Telemetry<br/>    telemetry_block_data_submission = optional(bool, false)<br/><br/>    # USB<br/>    usb_blocked = optional(bool, false)<br/><br/>    # Voice recording<br/>    voice_recording_blocked = optional(bool, false)<br/><br/>    # WiFi<br/>    wifi_block_automatic_connect_hotspots = optional(bool, false)<br/>    wifi_blocked                          = optional(bool, false)<br/>    wifi_block_manual_configuration       = optional(bool, false)<br/>    wifi_scan_interval                    = optional(number)<br/><br/>    # Windows Hello<br/>    windows_spotlight_block_consumer_specific_features    = optional(bool, false)<br/>    windows_spotlight_block_on_action_center              = optional(bool, false)<br/>    windows_spotlight_block_tailored_experiences          = optional(bool, false)<br/>    windows_spotlight_block_third_party_notifications     = optional(bool, false)<br/>    windows_spotlight_block_welcome_experience            = optional(bool, false)<br/>    windows_spotlight_block_windows_tips                  = optional(bool, false)<br/>    windows_spotlight_blocked                             = optional(bool, false)<br/>    windows_spotlight_configure_on_lock_screen            = optional(string, "notConfigured")<br/>    windows_store_block_auto_update                       = optional(bool, false)<br/>    windows_store_blocked                                 = optional(bool, false)<br/>    windows_store_enable_private_store_only               = optional(bool, false)<br/>    wireless_display_block_projection_to_this_device      = optional(bool, false)<br/>    wireless_display_block_user_input_from_receiver       = optional(bool, false)<br/>    wireless_display_require_pin_for_pairing              = optional(bool, false)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the Device Configuration Profile. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Device Configuration Profile. |
| <a name="output_ios_device_restrictions_id"></a> [ios\_device\_restrictions\_id](#output\_ios\_device\_restrictions\_id) | The ID of the iOS device restrictions profile. |
| <a name="output_platform"></a> [platform](#output\_platform) | The platform of the Device Configuration Profile. |
| <a name="output_profile_type"></a> [profile\_type](#output\_profile\_type) | The type of the Device Configuration Profile. |
| <a name="output_windows10_custom_id"></a> [windows10\_custom\_id](#output\_windows10\_custom\_id) | The ID of the Windows 10 custom profile. |
| <a name="output_windows10_device_restrictions_id"></a> [windows10\_device\_restrictions\_id](#output\_windows10\_device\_restrictions\_id) | The ID of the Windows 10 device restrictions profile. |
<!-- END_TF_DOCS -->