# Microsoft Intune Device Compliance Policy

Terraform module for creating and managing Microsoft Intune Device Compliance Policies.

## Features

- Support for multiple platforms (Windows 10, iOS, Android, macOS)
- Comprehensive compliance settings per platform
- Password/passcode requirements
- OS version requirements
- Device encryption requirements
- Device threat protection integration
- Firewall and antivirus requirements
- Scheduled actions for non-compliance
- Group assignments with filters

## Usage

### Windows 10 Compliance Policy

```hcl
module "windows_compliance" {
  source = "path/to/Intune/DeviceCompliancePolicy"

  display_name = "Windows 10 Corporate Compliance"
  description  = "Compliance policy for corporate Windows 10 devices"
  platform     = "windows10"

  windows_compliance_settings = {
    password_required              = true
    password_minimum_length        = 8
    password_required_type         = "alphanumeric"
    bit_locker_enabled             = true
    secure_boot_enabled            = true
    code_integrity_enabled         = true
    active_firewall_required       = true
    defender_enabled               = true
    antivirus_required             = true
    anti_spyware_required          = true
    os_minimum_version             = "10.0.19041"
    storage_require_encryption     = true
    tpm_required                   = true
  }

  scheduled_actions_for_rule = [
    {
      rule_name = "DeviceNonCompliant"
      scheduled_action_configurations = [
        {
          action_type        = "block"
          grace_period_hours = 24
        }
      ]
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

### iOS Compliance Policy

```hcl
module "ios_compliance" {
  source = "path/to/Intune/DeviceCompliancePolicy"

  display_name = "iOS Corporate Compliance"
  platform     = "iOS"

  ios_compliance_settings = {
    passcode_required                  = true
    passcode_minimum_length            = 6
    passcode_block_simple              = true
    security_block_jailbroken_devices  = true
    os_minimum_version                 = "15.0"
  }
}
```

### Android Compliance Policy

```hcl
module "android_compliance" {
  source = "path/to/Intune/DeviceCompliancePolicy"

  display_name = "Android Corporate Compliance"
  platform     = "android"

  android_compliance_settings = {
    password_required                                      = true
    password_minimum_length                                = 6
    security_block_jailbroken_devices                      = true
    security_prevent_install_apps_from_unknown_sources     = true
    security_require_google_play_services                  = true
    storage_require_encryption                             = true
    os_minimum_version                                     = "11"
  }
}
```

### macOS Compliance Policy

```hcl
module "macos_compliance" {
  source = "path/to/Intune/DeviceCompliancePolicy"

  display_name = "macOS Corporate Compliance"
  platform     = "macOS"

  macos_compliance_settings = {
    password_required                   = true
    password_minimum_length             = 8
    system_integrity_protection_enabled = true
    storage_require_encryption          = true
    firewall_enabled                    = true
    os_minimum_version                  = "12.0"
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
| display_name | The display name of the policy | `string` | n/a | yes |
| platform | The platform (windows10, iOS, android, macOS) | `string` | n/a | yes |
| create | Whether to create the resource | `bool` | `true` | no |
| description | The description of the policy | `string` | `null` | no |
| windows_compliance_settings | Windows 10 compliance settings | `object` | `null` | no |
| ios_compliance_settings | iOS compliance settings | `object` | `null` | no |
| android_compliance_settings | Android compliance settings | `object` | `null` | no |
| macos_compliance_settings | macOS compliance settings | `object` | `null` | no |
| scheduled_actions_for_rule | Actions for non-compliance | `list(object)` | `[]` | no |
| assignments | Policy assignments | `list(object)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the policy |
| display_name | The display name of the policy |
| platform | The platform of the policy |
| windows10_policy_id | The ID of Windows 10 policy |
| ios_policy_id | The ID of iOS policy |
| android_policy_id | The ID of Android policy |
| macos_policy_id | The ID of macOS policy |
