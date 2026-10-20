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
