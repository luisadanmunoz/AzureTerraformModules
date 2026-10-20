# Microsoft Intune App Protection Policy

Terraform module for creating and managing Microsoft Intune App Protection Policies (MAM).

## Features

- iOS and Android app protection policies
- Data protection settings (encryption, backup, clipboard)
- Access requirements (PIN, biometric, timeout)
- Conditional launch settings (OS version, jailbreak detection)
- Target specific apps
- Group assignments with filters

## Usage

### iOS App Protection Policy

```hcl
module "ios_app_protection" {
  source = "path/to/Intune/AppProtectionPolicy"

  display_name = "iOS Corporate App Protection"
  description  = "App protection policy for corporate iOS apps"
  platform     = "iOS"

  data_protection = {
    encrypt_app_data      = true
    data_backup_blocked   = true
    printing_blocked      = true
    contact_sync_blocked  = false
    save_as_blocked       = true
    third_party_keyboards_blocked = true
  }

  access_requirements = {
    pin_required              = true
    minimum_pin_length        = 6
    simple_pin_blocked        = true
    touch_id_blocked          = false
    period_offline_before_wipe = "P30D"
  }

  conditional_launch = {
    min_os_version           = "15.0"
    jailbroken_device_blocked = true
  }

  apps = [
    {
      app_id    = "com.microsoft.Office.Outlook"
      name      = "Microsoft Outlook"
      publisher = "Microsoft Corporation"
    },
    {
      app_id    = "com.microsoft.Office.Word"
      name      = "Microsoft Word"
      publisher = "Microsoft Corporation"
    }
  ]

  assignments = [
    {
      target_type = "groupAssignmentTarget"
      group_id    = "00000000-0000-0000-0000-000000000000"
    }
  ]
}
```

### Android App Protection Policy

```hcl
module "android_app_protection" {
  source = "path/to/Intune/AppProtectionPolicy"

  display_name = "Android Corporate App Protection"
  platform     = "android"

  data_protection = {
    encrypt_app_data       = true
    screen_capture_blocked = true
    data_backup_blocked    = true
    save_as_blocked        = true
  }

  access_requirements = {
    pin_required                     = true
    minimum_pin_length               = 6
    simple_pin_blocked               = true
    biometric_authentication_blocked = false
  }

  conditional_launch = {
    min_os_version        = "11"
    rooted_device_blocked = true
  }

  apps = [
    {
      app_id = "com.microsoft.office.outlook"
      name   = "Microsoft Outlook"
    }
  ]
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
| display_name | The display name of the policy | `string` | n/a | yes |
| platform | The platform (iOS, android) | `string` | n/a | yes |
| create | Whether to create the resource | `bool` | `true` | no |
| description | The description of the policy | `string` | `null` | no |
| data_protection | Data protection settings | `object` | `{}` | no |
| access_requirements | Access requirements settings | `object` | `{}` | no |
| conditional_launch | Conditional launch settings | `object` | `{}` | no |
| apps | List of apps to target | `list(object)` | `[]` | no |
| exempted_apps | List of exempted apps | `list(object)` | `[]` | no |
| assignments | Policy assignments | `list(object)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the policy |
| display_name | The display name |
| platform | The platform |
| ios_policy_id | iOS policy ID |
| android_policy_id | Android policy ID |
