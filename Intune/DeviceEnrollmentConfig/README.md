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
| [microsoft365_device_enrollment_limit_configuration.this](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/device_enrollment_limit_configuration) | resource |
| [microsoft365_device_enrollment_platform_restrictions_configuration.this](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/device_enrollment_platform_restrictions_configuration) | resource |
| [microsoft365_device_enrollment_windows_hello_for_business_configuration.this](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/device_enrollment_windows_hello_for_business_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_assignments"></a> [assignments](#input\_assignments) | Configuration assignments to groups. | <pre>list(object({<br/>    target_type = string<br/>    group_id    = optional(string)<br/>    filter_id   = optional(string)<br/>    filter_type = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_config_type"></a> [config\_type](#input\_config\_type) | The type of enrollment configuration. Possible values are deviceEnrollmentLimitConfiguration, deviceEnrollmentPlatformRestrictionsConfiguration, deviceEnrollmentWindowsHelloForBusinessConfiguration. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the device enrollment configuration resource. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the device enrollment configuration. | `string` | `null` | no |
| <a name="input_device_limit"></a> [device\_limit](#input\_device\_limit) | The maximum number of devices a user can enroll. | `number` | `5` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the device enrollment configuration. | `string` | n/a | yes |
| <a name="input_platform_restrictions"></a> [platform\_restrictions](#input\_platform\_restrictions) | Platform restrictions configuration. | <pre>object({<br/>    android_restriction = optional(object({<br/>      platform_blocked                   = optional(bool, false)<br/>      personal_device_enrollment_blocked = optional(bool, false)<br/>      os_minimum_version                 = optional(string)<br/>      os_maximum_version                 = optional(string)<br/>      blocked_manufacturers              = optional(list(string), [])<br/>      blocked_skus                       = optional(list(string), [])<br/>    }))<br/>    android_for_work_restriction = optional(object({<br/>      platform_blocked                   = optional(bool, false)<br/>      personal_device_enrollment_blocked = optional(bool, false)<br/>      os_minimum_version                 = optional(string)<br/>      os_maximum_version                 = optional(string)<br/>      blocked_manufacturers              = optional(list(string), [])<br/>      blocked_skus                       = optional(list(string), [])<br/>    }))<br/>    ios_restriction = optional(object({<br/>      platform_blocked                   = optional(bool, false)<br/>      personal_device_enrollment_blocked = optional(bool, false)<br/>      os_minimum_version                 = optional(string)<br/>      os_maximum_version                 = optional(string)<br/>      blocked_manufacturers              = optional(list(string), [])<br/>      blocked_skus                       = optional(list(string), [])<br/>    }))<br/>    mac_os_restriction = optional(object({<br/>      platform_blocked                   = optional(bool, false)<br/>      personal_device_enrollment_blocked = optional(bool, false)<br/>      os_minimum_version                 = optional(string)<br/>      os_maximum_version                 = optional(string)<br/>      blocked_manufacturers              = optional(list(string), [])<br/>      blocked_skus                       = optional(list(string), [])<br/>    }))<br/>    windows_restriction = optional(object({<br/>      platform_blocked                   = optional(bool, false)<br/>      personal_device_enrollment_blocked = optional(bool, false)<br/>      os_minimum_version                 = optional(string)<br/>      os_maximum_version                 = optional(string)<br/>      blocked_manufacturers              = optional(list(string), [])<br/>      blocked_skus                       = optional(list(string), [])<br/>    }))<br/>    windows_mobile_restriction = optional(object({<br/>      platform_blocked                   = optional(bool, true)<br/>      personal_device_enrollment_blocked = optional(bool, false)<br/>      os_minimum_version                 = optional(string)<br/>      os_maximum_version                 = optional(string)<br/>      blocked_manufacturers              = optional(list(string), [])<br/>      blocked_skus                       = optional(list(string), [])<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | The priority of the configuration. | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags (for module consistency, not applied to resource). | `map(string)` | `{}` | no |
| <a name="input_windows_hello_for_business"></a> [windows\_hello\_for\_business](#input\_windows\_hello\_for\_business) | Windows Hello for Business configuration. | <pre>object({<br/>    state                                     = optional(string, "notConfigured")<br/>    pin_minimum_length                        = optional(number, 4)<br/>    pin_maximum_length                        = optional(number, 127)<br/>    pin_uppercase_characters_usage            = optional(string, "allowed")<br/>    pin_lowercase_characters_usage            = optional(string, "allowed")<br/>    pin_special_characters_usage              = optional(string, "allowed")<br/>    security_device_required                  = optional(bool, false)<br/>    unlock_with_biometrics_enabled            = optional(bool, true)<br/>    remote_passport_enabled                   = optional(bool, true)<br/>    pin_recovery_enabled                      = optional(bool, true)<br/>    pin_expiration_in_days                    = optional(number, 0)<br/>    pin_previous_block_count                  = optional(number, 0)<br/>    enhanced_biometrics_state                 = optional(string, "notConfigured")<br/>    security_key_for_sign_in                  = optional(string, "notConfigured")<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_config_type"></a> [config\_type](#output\_config\_type) | The type of the Device Enrollment Configuration. |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the Device Enrollment Configuration. |
| <a name="output_enrollment_limit_config_id"></a> [enrollment\_limit\_config\_id](#output\_enrollment\_limit\_config\_id) | The ID of the enrollment limit configuration. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Device Enrollment Configuration. |
| <a name="output_platform_restrictions_config_id"></a> [platform\_restrictions\_config\_id](#output\_platform\_restrictions\_config\_id) | The ID of the platform restrictions configuration. |
| <a name="output_windows_hello_config_id"></a> [windows\_hello\_config\_id](#output\_windows\_hello\_config\_id) | The ID of the Windows Hello for Business configuration. |
<!-- END_TF_DOCS -->