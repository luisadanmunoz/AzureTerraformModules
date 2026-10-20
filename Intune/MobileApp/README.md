# Microsoft Intune Mobile App

Terraform module for creating and managing Microsoft Intune Mobile Apps.

## Features

- iOS Store apps
- Android Store apps
- Web link apps
- Win32 LOB apps with detection rules
- App assignments with intent (required, available, uninstall)
- Group assignments with filters
- Install and restart settings

## Usage

### iOS Store App

```hcl
module "ios_outlook" {
  source = "path/to/Intune/MobileApp"

  display_name = "Microsoft Outlook"
  description  = "Microsoft Outlook for iOS"
  publisher    = "Microsoft Corporation"
  app_type     = "iosStoreApp"

  ios_store_app = {
    app_store_url = "https://apps.apple.com/app/microsoft-outlook/id951937596"
    bundle_id     = "com.microsoft.Office.Outlook"
    minimum_supported_operating_system = {
      v15_0 = true
    }
  }

  assignments = [
    {
      intent      = "required"
      target_type = "groupAssignmentTarget"
      group_id    = "00000000-0000-0000-0000-000000000000"
    }
  ]
}
```

### Android Store App

```hcl
module "android_outlook" {
  source = "path/to/Intune/MobileApp"

  display_name = "Microsoft Outlook"
  description  = "Microsoft Outlook for Android"
  publisher    = "Microsoft Corporation"
  app_type     = "androidStoreApp"

  android_store_app = {
    app_store_url = "https://play.google.com/store/apps/details?id=com.microsoft.office.outlook"
    package_id    = "com.microsoft.office.outlook"
    minimum_supported_operating_system = {
      v11_0 = true
    }
  }

  assignments = [
    {
      intent      = "required"
      target_type = "groupAssignmentTarget"
      group_id    = "00000000-0000-0000-0000-000000000000"
    }
  ]
}
```

### Web Link App

```hcl
module "intranet_link" {
  source = "path/to/Intune/MobileApp"

  display_name = "Company Intranet"
  description  = "Link to the company intranet"
  publisher    = "Contoso"
  app_type     = "webLink"

  web_link_app = {
    app_url             = "https://intranet.contoso.com"
    use_managed_browser = true
  }

  assignments = [
    {
      intent      = "available"
      target_type = "allUsers"
    }
  ]
}
```

### Win32 LOB App

```hcl
module "custom_app" {
  source = "path/to/Intune/MobileApp"

  display_name = "Custom Corporate App"
  description  = "Custom line-of-business application"
  publisher    = "Contoso IT"
  app_type     = "win32LobApp"

  win32_lob_app = {
    file_name              = "CustomApp.intunewin"
    install_command_line   = "msiexec /i CustomApp.msi /qn"
    uninstall_command_line = "msiexec /x {PRODUCT-CODE} /qn"
    install_experience_type = "system"
    device_restart_behavior = "allow"

    detection_rules = [
      {
        type               = "file"
        path               = "C:\\Program Files\\CustomApp"
        file_or_folder_name = "CustomApp.exe"
        detection_type     = "exists"
      }
    ]

    minimum_supported_operating_system = {
      v10_21h1 = true
    }
  }

  assignments = [
    {
      intent      = "required"
      target_type = "groupAssignmentTarget"
      group_id    = "00000000-0000-0000-0000-000000000000"
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
| display_name | The display name of the app | `string` | n/a | yes |
| app_type | The type of app | `string` | n/a | yes |
| create | Whether to create the resource | `bool` | `true` | no |
| description | The description of the app | `string` | `null` | no |
| publisher | The publisher of the app | `string` | `null` | no |
| is_featured | Featured in Company Portal | `bool` | `false` | no |
| ios_store_app | iOS Store App config | `object` | `null` | no |
| android_store_app | Android Store App config | `object` | `null` | no |
| web_link_app | Web Link App config | `object` | `null` | no |
| win32_lob_app | Win32 LOB App config | `object` | `null` | no |
| assignments | App assignments | `list(object)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the app |
| display_name | The display name |
| app_type | The type of app |
| ios_store_app_id | iOS Store App ID |
| android_store_app_id | Android Store App ID |
| web_link_app_id | Web Link App ID |
| win32_lob_app_id | Win32 LOB App ID |
