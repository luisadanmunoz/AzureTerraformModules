# Microsoft Intune Windows Autopilot Deployment Profile

Terraform module for creating and managing Windows Autopilot Deployment Profiles.

## Features

- User-driven and self-deploying deployment modes
- White glove (pre-provisioning) support
- Custom device naming templates
- Out-of-Box Experience (OOBE) customization
- Enrollment Status Page (ESP) configuration
- Hybrid Azure AD Join support
- Language and keyboard customization
- Group assignments with filters

## Usage

### Basic Autopilot Profile

```hcl
module "autopilot_profile" {
  source = "path/to/Intune/WindowsAutopilotProfile"

  display_name         = "Standard Autopilot Profile"
  description          = "Standard deployment profile for corporate devices"
  device_name_template = "CORP-%SERIAL%"

  oobe_settings = {
    hide_eula                   = true
    hide_privacy_settings       = true
    hide_change_account_options = true
    user_type                   = "standard"
    device_usage_type           = "singleUser"
  }

  enrollment_status_page = {
    show_progress                           = true
    block_device_use_until_profile_complete = true
    allow_device_use_on_error               = false
    install_progress_timeout_in_minutes     = 60
  }

  assignments = [
    {
      target_type = "groupAssignmentTarget"
      group_id    = "00000000-0000-0000-0000-000000000000"
    }
  ]
}
```

### White Glove (Pre-Provisioning) Profile

```hcl
module "autopilot_white_glove" {
  source = "path/to/Intune/WindowsAutopilotProfile"

  display_name         = "White Glove Autopilot Profile"
  description          = "Pre-provisioning profile for IT deployment"
  device_name_template = "WG-%SERIAL%"
  enable_white_glove   = true

  oobe_settings = {
    hide_eula             = true
    hide_privacy_settings = true
    user_type             = "standard"
    device_usage_type     = "singleUser"
    hide_escape_link      = true
  }

  enrollment_status_page = {
    show_progress                           = true
    block_device_use_until_profile_complete = true
    allow_log_collection_on_error           = true
    install_progress_timeout_in_minutes     = 120
  }
}
```

### Hybrid Azure AD Join Profile

```hcl
module "autopilot_hybrid" {
  source = "path/to/Intune/WindowsAutopilotProfile"

  display_name         = "Hybrid AADJ Autopilot Profile"
  description          = "Autopilot profile for Hybrid Azure AD Join"
  device_name_template = "HYB-%SERIAL%"

  oobe_settings = {
    hide_eula             = true
    hide_privacy_settings = true
    user_type             = "standard"
  }

  hybrid_azure_ad_join = {
    enabled               = true
    domain_join_connector = "connector-id"
    ou_path               = "OU=Computers,DC=contoso,DC=com"
  }
}
```

### Kiosk/Shared Device Profile

```hcl
module "autopilot_kiosk" {
  source = "path/to/Intune/WindowsAutopilotProfile"

  display_name         = "Kiosk Autopilot Profile"
  description          = "Self-deploying profile for kiosk devices"
  device_name_template = "KIOSK-%SERIAL%"

  oobe_settings = {
    hide_eula                   = true
    hide_privacy_settings       = true
    hide_change_account_options = true
    device_usage_type           = "shared"
    skip_keyboard_selection_page = true
  }

  enrollment_status_page = {
    show_progress                           = true
    block_device_use_until_profile_complete = true
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
| create | Whether to create the resource | `bool` | `true` | no |
| description | The description of the profile | `string` | `null` | no |
| device_name_template | Device name template | `string` | `null` | no |
| device_type | Device type (windowsPc, surfaceHub2) | `string` | `"windowsPc"` | no |
| enable_white_glove | Enable pre-provisioning | `bool` | `false` | no |
| oobe_settings | OOBE settings | `object` | `{}` | no |
| enrollment_status_page | ESP settings | `object` | `{}` | no |
| hybrid_azure_ad_join | Hybrid AADJ settings | `object` | `{}` | no |
| language | OOBE language | `string` | `null` | no |
| keyboard_identifier | Keyboard layout | `string` | `null` | no |
| assignments | Profile assignments | `list(object)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the profile |
| display_name | The display name |
| device_type | The device type |
| enable_white_glove | White glove status |
| device_name_template | Device name template |

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
| [microsoft365_windows_autopilot_deployment_profile.this](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/windows_autopilot_deployment_profile) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_assignments"></a> [assignments](#input\_assignments) | Profile assignments to groups. | <pre>list(object({<br/>    target_type = string<br/>    group_id    = optional(string)<br/>    filter_id   = optional(string)<br/>    filter_type = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Windows Autopilot deployment profile resource. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the Windows Autopilot deployment profile. | `string` | `null` | no |
| <a name="input_device_name_template"></a> [device\_name\_template](#input\_device\_name\_template) | The template for the device name. Use %SERIAL% for serial number. | `string` | `null` | no |
| <a name="input_device_type"></a> [device\_type](#input\_device\_type) | The type of Windows Autopilot profile. Possible values are windowsPc, surfaceHub2. | `string` | `"windowsPc"` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the Windows Autopilot deployment profile. | `string` | n/a | yes |
| <a name="input_enable_white_glove"></a> [enable\_white\_glove](#input\_enable\_white\_glove) | Whether to enable white glove (pre-provisioning) mode. | `bool` | `false` | no |
| <a name="input_enrollment_status_page"></a> [enrollment\_status\_page](#input\_enrollment\_status\_page) | Enrollment Status Page (ESP) settings. | <pre>object({<br/>    show_progress                           = optional(bool, true)<br/>    block_device_use_until_profile_complete = optional(bool, true)<br/>    allow_device_use_on_error               = optional(bool, false)<br/>    allow_log_collection_on_error           = optional(bool, true)<br/>    allow_device_reset_on_error             = optional(bool, false)<br/>    allow_retry                             = optional(bool, true)<br/>    custom_error_message                    = optional(string)<br/>    show_installation_progress              = optional(bool, true)<br/>    install_progress_timeout_in_minutes     = optional(number, 60)<br/>    selected_mobile_app_ids                 = optional(list(string), [])<br/>    track_install_progress_for_autpilot_only = optional(bool, true)<br/>    disable_user_status_tracking_after_first_user = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_enrollment_status_page_timeout_in_minutes"></a> [enrollment\_status\_page\_timeout\_in\_minutes](#input\_enrollment\_status\_page\_timeout\_in\_minutes) | Timeout in minutes for the enrollment status page. | `number` | `60` | no |
| <a name="input_hybrid_azure_ad_join"></a> [hybrid\_azure\_ad\_join](#input\_hybrid\_azure\_ad\_join) | Hybrid Azure AD Join settings. | <pre>object({<br/>    enabled                = optional(bool, false)<br/>    domain_join_connector = optional(string)<br/>    ou_path               = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_keyboard_identifier"></a> [keyboard\_identifier](#input\_keyboard\_identifier) | The keyboard layout identifier. | `string` | `null` | no |
| <a name="input_language"></a> [language](#input\_language) | The language to use during OOBE (e.g., 'en-US', 'es-ES'). | `string` | `null` | no |
| <a name="input_oobe_settings"></a> [oobe\_settings](#input\_oobe\_settings) | Out-of-Box Experience (OOBE) settings. | <pre>object({<br/>    hide_eula                           = optional(bool, true)<br/>    hide_privacy_settings               = optional(bool, true)<br/>    hide_change_account_options         = optional(bool, true)<br/>    user_type                           = optional(string, "standard")<br/>    device_usage_type                   = optional(string, "singleUser")<br/>    skip_keyboard_selection_page        = optional(bool, true)<br/>    hide_escape_link                    = optional(bool, true)<br/>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags (for module consistency, not applied to resource). | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_device_name_template"></a> [device\_name\_template](#output\_device\_name\_template) | The device name template. |
| <a name="output_device_type"></a> [device\_type](#output\_device\_type) | The device type of the Windows Autopilot Deployment Profile. |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the Windows Autopilot Deployment Profile. |
| <a name="output_enable_white_glove"></a> [enable\_white\_glove](#output\_enable\_white\_glove) | Whether white glove mode is enabled. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Windows Autopilot Deployment Profile. |
<!-- END_TF_DOCS -->