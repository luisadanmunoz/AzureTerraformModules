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
