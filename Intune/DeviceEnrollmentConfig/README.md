# Microsoft Intune Device Enrollment Configuration

Terraform module for creating and managing Microsoft Intune Device Enrollment Configurations.

## Features

- Device enrollment limit configuration
- Platform restrictions (Android, iOS, macOS, Windows)
- Windows Hello for Business configuration
- Personal device enrollment blocking
- OS version restrictions
- Group assignments with filters

## Usage

### Device Enrollment Limit

```hcl
module "enrollment_limit" {
  source = "path/to/Intune/DeviceEnrollmentConfig"

  display_name = "Corporate Device Limit"
  description  = "Limit devices per user to 5"
  config_type  = "deviceEnrollmentLimitConfiguration"

  device_limit = 5

  assignments = [
    {
      target_type = "allUsers"
    }
  ]
}
```

### Platform Restrictions

```hcl
module "platform_restrictions" {
  source = "path/to/Intune/DeviceEnrollmentConfig"

  display_name = "Corporate Platform Restrictions"
  description  = "Platform restrictions for corporate enrollment"
  config_type  = "deviceEnrollmentPlatformRestrictionsConfiguration"

  platform_restrictions = {
    android_restriction = {
      platform_blocked                   = false
      personal_device_enrollment_blocked = true
      os_minimum_version                 = "11.0"
    }
    android_for_work_restriction = {
      platform_blocked                   = false
      personal_device_enrollment_blocked = false
      os_minimum_version                 = "11.0"
    }
    ios_restriction = {
      platform_blocked                   = false
      personal_device_enrollment_blocked = true
      os_minimum_version                 = "15.0"
    }
    mac_os_restriction = {
      platform_blocked                   = false
      personal_device_enrollment_blocked = true
      os_minimum_version                 = "12.0"
    }
    windows_restriction = {
      platform_blocked                   = false
      personal_device_enrollment_blocked = true
      os_minimum_version                 = "10.0.19041"
    }
    windows_mobile_restriction = {
      platform_blocked = true
    }
  }

  assignments = [
    {
      target_type = "allUsers"
    }
  ]
}
```

### Windows Hello for Business

```hcl
module "windows_hello" {
  source = "path/to/Intune/DeviceEnrollmentConfig"

  display_name = "Windows Hello for Business"
  description  = "Configure Windows Hello for Business"
  config_type  = "deviceEnrollmentWindowsHelloForBusinessConfiguration"

  windows_hello_for_business = {
    state                          = "enabled"
    pin_minimum_length             = 6
    pin_maximum_length             = 127
    pin_uppercase_characters_usage = "required"
    pin_lowercase_characters_usage = "required"
    pin_special_characters_usage   = "allowed"
    security_device_required       = true
    unlock_with_biometrics_enabled = true
    remote_passport_enabled        = true
    pin_recovery_enabled           = true
    pin_expiration_in_days         = 90
    pin_previous_block_count       = 5
  }

  assignments = [
    {
      target_type = "allUsers"
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
| display_name | The display name | `string` | n/a | yes |
| config_type | The configuration type | `string` | n/a | yes |
| create | Whether to create the resource | `bool` | `true` | no |
| description | The description | `string` | `null` | no |
| priority | The priority | `number` | `null` | no |
| device_limit | Device enrollment limit | `number` | `5` | no |
| platform_restrictions | Platform restrictions config | `object` | `null` | no |
| windows_hello_for_business | Windows Hello config | `object` | `null` | no |
| assignments | Configuration assignments | `list(object)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the configuration |
| display_name | The display name |
| config_type | The configuration type |
| enrollment_limit_config_id | Enrollment limit config ID |
| platform_restrictions_config_id | Platform restrictions config ID |
| windows_hello_config_id | Windows Hello config ID |
