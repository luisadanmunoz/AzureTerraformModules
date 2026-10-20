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
| [microsoft365_device_compliance_policy_android.this](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/device_compliance_policy_android) | resource |
| [microsoft365_device_compliance_policy_ios.this](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/device_compliance_policy_ios) | resource |
| [microsoft365_device_compliance_policy_macos.this](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/device_compliance_policy_macos) | resource |
| [microsoft365_device_compliance_policy_windows10.this](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/device_compliance_policy_windows10) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_android_compliance_settings"></a> [android\_compliance\_settings](#input\_android\_compliance\_settings) | Android compliance settings. | <pre>object({<br/>    password_required                      = optional(bool, false)<br/>    password_minimum_length                = optional(number)<br/>    password_required_type                 = optional(string, "deviceDefault")<br/>    password_minutes_of_inactivity_before_lock = optional(number)<br/>    password_expiration_days               = optional(number)<br/>    password_previous_password_block_count = optional(number)<br/>    security_prevent_install_apps_from_unknown_sources = optional(bool, false)<br/>    security_disable_usb_debugging         = optional(bool, false)<br/>    security_require_verify_apps           = optional(bool, false)<br/>    device_threat_protection_enabled       = optional(bool, false)<br/>    device_threat_protection_required_security_level = optional(string)<br/>    security_block_jailbroken_devices      = optional(bool, false)<br/>    os_minimum_version                     = optional(string)<br/>    os_maximum_version                     = optional(string)<br/>    min_android_security_patch_level       = optional(string)<br/>    storage_require_encryption             = optional(bool, false)<br/>    security_require_safety_net_attestation_basic_integrity = optional(bool, false)<br/>    security_require_safety_net_attestation_certified_device = optional(bool, false)<br/>    security_require_google_play_services  = optional(bool, false)<br/>    security_require_up_to_date_security_providers = optional(bool, false)<br/>    security_require_company_portal_app_integrity = optional(bool, false)<br/>    restricted_apps                        = optional(list(object({<br/>      name       = string<br/>      app_id     = string<br/>      publisher  = optional(string)<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_assignments"></a> [assignments](#input\_assignments) | Policy assignments to groups. | <pre>list(object({<br/>    target_type      = string<br/>    group_id         = optional(string)<br/>    filter_id        = optional(string)<br/>    filter_type      = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the device compliance policy resource. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the device compliance policy. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the device compliance policy. | `string` | n/a | yes |
| <a name="input_ios_compliance_settings"></a> [ios\_compliance\_settings](#input\_ios\_compliance\_settings) | iOS compliance settings. | <pre>object({<br/>    passcode_required                      = optional(bool, false)<br/>    passcode_block_simple                  = optional(bool, false)<br/>    passcode_minimum_length                = optional(number)<br/>    passcode_required_type                 = optional(string, "deviceDefault")<br/>    passcode_minutes_of_inactivity_before_lock = optional(number)<br/>    passcode_expiration_days               = optional(number)<br/>    passcode_previous_passcode_block_count = optional(number)<br/>    os_minimum_version                     = optional(string)<br/>    os_maximum_version                     = optional(string)<br/>    os_minimum_build_version               = optional(string)<br/>    os_maximum_build_version               = optional(string)<br/>    security_block_jailbroken_devices      = optional(bool, false)<br/>    device_threat_protection_enabled       = optional(bool, false)<br/>    device_threat_protection_required_security_level = optional(string)<br/>    managed_email_profile_required         = optional(bool, false)<br/>    restricted_apps                        = optional(list(object({<br/>      name       = string<br/>      app_id     = string<br/>      publisher  = optional(string)<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_macos_compliance_settings"></a> [macos\_compliance\_settings](#input\_macos\_compliance\_settings) | macOS compliance settings. | <pre>object({<br/>    password_required                      = optional(bool, false)<br/>    password_block_simple                  = optional(bool, false)<br/>    password_minimum_length                = optional(number)<br/>    password_required_type                 = optional(string, "deviceDefault")<br/>    password_minutes_of_inactivity_before_lock = optional(number)<br/>    password_expiration_days               = optional(number)<br/>    password_previous_password_block_count = optional(number)<br/>    os_minimum_version                     = optional(string)<br/>    os_maximum_version                     = optional(string)<br/>    os_minimum_build_version               = optional(string)<br/>    os_maximum_build_version               = optional(string)<br/>    system_integrity_protection_enabled    = optional(bool, false)<br/>    device_threat_protection_enabled       = optional(bool, false)<br/>    device_threat_protection_required_security_level = optional(string)<br/>    storage_require_encryption             = optional(bool, false)<br/>    firewall_enabled                       = optional(bool, false)<br/>    firewall_block_all_incoming            = optional(bool, false)<br/>    firewall_enable_stealth_mode           = optional(bool, false)<br/>    gatekeeper_allowed_app_source          = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_platform"></a> [platform](#input\_platform) | The platform for the compliance policy. Possible values are windows10, iOS, android, macOS, androidForWork. | `string` | n/a | yes |
| <a name="input_scheduled_actions_for_rule"></a> [scheduled\_actions\_for\_rule](#input\_scheduled\_actions\_for\_rule) | Scheduled actions for non-compliance. | <pre>list(object({<br/>    rule_name = optional(string, "DeviceNonCompliant")<br/>    scheduled_action_configurations = list(object({<br/>      action_type                    = string<br/>      grace_period_hours             = optional(number, 0)<br/>      notification_template_id       = optional(string)<br/>      notification_message_cc_list   = optional(list(string), [])<br/>      notification_additional_recipients = optional(list(string), [])<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags (for module consistency, not applied to resource). | `map(string)` | `{}` | no |
| <a name="input_windows_compliance_settings"></a> [windows\_compliance\_settings](#input\_windows\_compliance\_settings) | Windows 10 compliance settings. | <pre>object({<br/>    password_required                      = optional(bool, false)<br/>    password_required_type                 = optional(string, "deviceDefault")<br/>    password_minimum_length                = optional(number)<br/>    password_minutes_of_inactivity_before_lock = optional(number)<br/>    password_expiration_days               = optional(number)<br/>    password_previous_password_block_count = optional(number)<br/>    require_healthy_device_report          = optional(bool, false)<br/>    os_minimum_version                     = optional(string)<br/>    os_maximum_version                     = optional(string)<br/>    mobile_os_minimum_version              = optional(string)<br/>    mobile_os_maximum_version              = optional(string)<br/>    early_launch_anti_malware_driver_enabled = optional(bool)<br/>    bit_locker_enabled                     = optional(bool, false)<br/>    secure_boot_enabled                    = optional(bool, false)<br/>    code_integrity_enabled                 = optional(bool, false)<br/>    storage_require_encryption             = optional(bool, false)<br/>    active_firewall_required               = optional(bool, false)<br/>    defender_enabled                       = optional(bool, false)<br/>    defender_version                       = optional(string)<br/>    signature_out_of_date                  = optional(bool)<br/>    rtp_enabled                            = optional(bool)<br/>    antivirus_required                     = optional(bool, false)<br/>    anti_spyware_required                  = optional(bool, false)<br/>    device_threat_protection_enabled       = optional(bool, false)<br/>    device_threat_protection_required_security_level = optional(string)<br/>    configuration_manager_compliance_required = optional(bool, false)<br/>    tpm_required                           = optional(bool, false)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_android_policy_id"></a> [android\_policy\_id](#output\_android\_policy\_id) | The ID of the Android compliance policy. |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the Device Compliance Policy. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Device Compliance Policy. |
| <a name="output_ios_policy_id"></a> [ios\_policy\_id](#output\_ios\_policy\_id) | The ID of the iOS compliance policy. |
| <a name="output_macos_policy_id"></a> [macos\_policy\_id](#output\_macos\_policy\_id) | The ID of the macOS compliance policy. |
| <a name="output_platform"></a> [platform](#output\_platform) | The platform of the Device Compliance Policy. |
| <a name="output_windows10_policy_id"></a> [windows10\_policy\_id](#output\_windows10\_policy\_id) | The ID of the Windows 10 compliance policy. |
<!-- END_TF_DOCS -->