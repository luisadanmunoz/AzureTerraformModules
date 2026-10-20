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
| [microsoft365_app_protection_policy_android.this](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/app_protection_policy_android) | resource |
| [microsoft365_app_protection_policy_ios.this](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/app_protection_policy_ios) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_access_requirements"></a> [access\_requirements](#input\_access\_requirements) | Access requirements settings. | <pre>object({<br/>    # PIN settings<br/>    pin_required                          = optional(bool, true)<br/>    pin_type                              = optional(string, "numeric")<br/>    simple_pin_blocked                    = optional(bool, false)<br/>    minimum_pin_length                    = optional(number, 4)<br/>    pin_character_set                     = optional(string, "numeric")<br/>    pin_maximum_retry_count               = optional(number, 5)<br/>    fingerprint_blocked                   = optional(bool, false)<br/>    disable_pin_after_retry               = optional(bool, false)<br/><br/>    # Period settings<br/>    period_before_pin_reset               = optional(string, "PT0S")<br/>    period_offline_before_access_check    = optional(string, "PT720M")<br/>    period_offline_before_wipe            = optional(string, "P90D")<br/>    period_online_before_access_check     = optional(string, "PT30M")<br/><br/>    # Block after settings<br/>    allowed_inbound_data_transfer_sources = optional(string, "allApps")<br/>    allowed_outbound_clipboard_sharing_level = optional(string, "allApps")<br/>    allowed_outbound_data_transfer_destinations = optional(string, "allApps")<br/><br/>    # Biometric<br/>    biometric_authentication_blocked      = optional(bool, false)<br/>    touch_id_blocked                      = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_apps"></a> [apps](#input\_apps) | List of apps to target with this policy. | <pre>list(object({<br/>    app_id    = string<br/>    name      = optional(string)<br/>    publisher = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_assignments"></a> [assignments](#input\_assignments) | Policy assignments to groups. | <pre>list(object({<br/>    target_type = string<br/>    group_id    = optional(string)<br/>    filter_id   = optional(string)<br/>    filter_type = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_conditional_launch"></a> [conditional\_launch](#input\_conditional\_launch) | Conditional launch settings. | <pre>object({<br/>    # App conditions<br/>    max_pin_retry_count                   = optional(number)<br/>    offline_grace_period_block            = optional(string)<br/>    offline_grace_period_wipe             = optional(string)<br/>    min_app_version                       = optional(string)<br/>    max_app_version                       = optional(string)<br/>    min_sdk_version                       = optional(string)<br/><br/>    # Device conditions<br/>    min_os_version                        = optional(string)<br/>    max_os_version                        = optional(string)<br/>    jailbroken_device_blocked             = optional(bool, true)<br/>    rooted_device_blocked                 = optional(bool, true)<br/>    device_threat_level                   = optional(string)<br/>    max_allowed_device_threat_level       = optional(string)<br/>    disabled_account                      = optional(string, "block")<br/>  })</pre> | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the app protection policy resource. | `bool` | `true` | no |
| <a name="input_data_protection"></a> [data\_protection](#input\_data\_protection) | Data protection settings. | <pre>object({<br/>    # Data transfer<br/>    allow_backup                         = optional(bool, true)<br/>    allow_save_to_other_apps             = optional(string, "allApps")<br/>    receive_data_from_other_apps         = optional(string, "allApps")<br/>    send_org_data_to_other_apps          = optional(string, "allApps")<br/>    prevent_backup                       = optional(bool, false)<br/>    disable_app_encryption_if_device_encryption_is_enabled = optional(bool, false)<br/><br/>    # Cut, copy, paste<br/>    restrict_cut_copy_paste              = optional(string, "allApps")<br/>    cut_copy_paste_blocked               = optional(bool, false)<br/><br/>    # Printing<br/>    printing_blocked                     = optional(bool, false)<br/>    print_org_data                       = optional(string, "allowed")<br/><br/>    # Data storage<br/>    save_as_blocked                      = optional(bool, false)<br/>    contact_sync_blocked                 = optional(bool, false)<br/>    data_backup_blocked                  = optional(bool, false)<br/>    device_compliance_required           = optional(bool, false)<br/>    managed_browser_to_open_links_required = optional(bool, false)<br/><br/>    # Encryption<br/>    encrypt_app_data                     = optional(bool, true)<br/>    organizational_credentials_required  = optional(bool, false)<br/><br/>    # Screen capture (Android only)<br/>    screen_capture_blocked               = optional(bool, false)<br/><br/>    # Third party keyboards (iOS only)<br/>    third_party_keyboards_blocked        = optional(bool, false)<br/><br/>    # Face ID (iOS only)<br/>    face_id_blocked                      = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the app protection policy. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the app protection policy. | `string` | n/a | yes |
| <a name="input_exempted_apps"></a> [exempted\_apps](#input\_exempted\_apps) | List of apps exempted from this policy. | <pre>list(object({<br/>    app_id    = string<br/>    name      = optional(string)<br/>    publisher = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_platform"></a> [platform](#input\_platform) | The platform for the app protection policy. Possible values are iOS, android. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags (for module consistency, not applied to resource). | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_android_policy_id"></a> [android\_policy\_id](#output\_android\_policy\_id) | The ID of the Android app protection policy. |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the App Protection Policy. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the App Protection Policy. |
| <a name="output_ios_policy_id"></a> [ios\_policy\_id](#output\_ios\_policy\_id) | The ID of the iOS app protection policy. |
| <a name="output_platform"></a> [platform](#output\_platform) | The platform of the App Protection Policy. |
<!-- END_TF_DOCS -->