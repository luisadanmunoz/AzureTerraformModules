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
| [microsoft365_mobile_app_android_store.this](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/mobile_app_android_store) | resource |
| [microsoft365_mobile_app_ios_store.this](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/mobile_app_ios_store) | resource |
| [microsoft365_mobile_app_web_link.this](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/mobile_app_web_link) | resource |
| [microsoft365_mobile_app_win32_lob.this](https://registry.terraform.io/providers/terraconfigure/microsoft365/latest/docs/resources/mobile_app_win32_lob) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_android_store_app"></a> [android\_store\_app](#input\_android\_store\_app) | Android Store App configuration. | <pre>object({<br/>    app_store_url = string<br/>    package_id    = optional(string)<br/>    minimum_supported_operating_system = optional(object({<br/>      v5_0  = optional(bool, false)<br/>      v5_1  = optional(bool, false)<br/>      v6_0  = optional(bool, false)<br/>      v7_0  = optional(bool, false)<br/>      v7_1  = optional(bool, false)<br/>      v8_0  = optional(bool, false)<br/>      v8_1  = optional(bool, false)<br/>      v9_0  = optional(bool, false)<br/>      v10_0 = optional(bool, false)<br/>      v11_0 = optional(bool, true)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_app_type"></a> [app\_type](#input\_app\_type) | The type of app. Possible values are microsoftStoreForBusiness, webLink, windowsMsi, windowsUniversalAppX, iosStoreApp, androidStoreApp, managedIOSStoreApp, managedAndroidStoreApp, win32LobApp. | `string` | n/a | yes |
| <a name="input_assignments"></a> [assignments](#input\_assignments) | App assignments to groups. | <pre>list(object({<br/>    intent      = string<br/>    target_type = string<br/>    group_id    = optional(string)<br/>    filter_id   = optional(string)<br/>    filter_type = optional(string)<br/>    settings    = optional(object({<br/>      notifications                   = optional(string, "showAll")<br/>      restart_settings                = optional(object({<br/>        grace_period_in_minutes        = optional(number)<br/>        countdown_display_before_restart_in_minutes = optional(number)<br/>        restart_notification_snooze_duration_in_minutes = optional(number)<br/>      }))<br/>      install_time_settings = optional(object({<br/>        use_local_time       = optional(bool, true)<br/>        deadline_date_time   = optional(string)<br/>        start_date_time      = optional(string)<br/>      }))<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the mobile app resource. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the mobile app. | `string` | `null` | no |
| <a name="input_developer"></a> [developer](#input\_developer) | The developer of the app. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the mobile app. | `string` | n/a | yes |
| <a name="input_information_url"></a> [information\_url](#input\_information\_url) | The information URL. | `string` | `null` | no |
| <a name="input_ios_store_app"></a> [ios\_store\_app](#input\_ios\_store\_app) | iOS Store App configuration. | <pre>object({<br/>    app_store_url          = string<br/>    bundle_id              = optional(string)<br/>    applicable_device_type = optional(object({<br/>      ipad        = optional(bool, true)<br/>      iphone_and_ipod = optional(bool, true)<br/>    }))<br/>    minimum_supported_operating_system = optional(object({<br/>      v11_0 = optional(bool, false)<br/>      v12_0 = optional(bool, false)<br/>      v13_0 = optional(bool, false)<br/>      v14_0 = optional(bool, false)<br/>      v15_0 = optional(bool, true)<br/>      v16_0 = optional(bool, false)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_is_featured"></a> [is\_featured](#input\_is\_featured) | Whether the app is featured in the Company Portal. | `bool` | `false` | no |
| <a name="input_large_icon"></a> [large\_icon](#input\_large\_icon) | The large icon for the app (base64 encoded). | <pre>object({<br/>    type  = string<br/>    value = string<br/>  })</pre> | `null` | no |
| <a name="input_notes"></a> [notes](#input\_notes) | Notes for the app. | `string` | `null` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | The owner of the app. | `string` | `null` | no |
| <a name="input_privacy_information_url"></a> [privacy\_information\_url](#input\_privacy\_information\_url) | The privacy information URL. | `string` | `null` | no |
| <a name="input_publisher"></a> [publisher](#input\_publisher) | The publisher of the mobile app. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags (for module consistency, not applied to resource). | `map(string)` | `{}` | no |
| <a name="input_web_link_app"></a> [web\_link\_app](#input\_web\_link\_app) | Web Link App configuration. | <pre>object({<br/>    app_url     = string<br/>    use_managed_browser = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_win32_lob_app"></a> [win32\_lob\_app](#input\_win32\_lob\_app) | Win32 LOB App configuration. | <pre>object({<br/>    file_name                    = string<br/>    install_command_line         = string<br/>    uninstall_command_line       = string<br/>    install_experience_type      = optional(string, "system")<br/>    device_restart_behavior      = optional(string, "allow")<br/>    return_codes                 = optional(list(object({<br/>      return_code = number<br/>      type        = string<br/>    })), [])<br/>    msi_information = optional(object({<br/>      product_code    = string<br/>      product_version = optional(string)<br/>      upgrade_code    = optional(string)<br/>      requires_reboot = optional(bool, false)<br/>      package_type    = optional(string, "perMachine")<br/>    }))<br/>    detection_rules = optional(list(object({<br/>      type                       = string<br/>      path                       = optional(string)<br/>      file_or_folder_name        = optional(string)<br/>      detection_type             = optional(string)<br/>      check_32_bit_on_64_system  = optional(bool, false)<br/>      operator                   = optional(string)<br/>      detection_value            = optional(string)<br/>      registry_key_path          = optional(string)<br/>      registry_value_name        = optional(string)<br/>      script_content             = optional(string)<br/>      enforce_signature_check    = optional(bool, false)<br/>      run_as_32_bit              = optional(bool, false)<br/>    })), [])<br/>    requirement_rules = optional(list(object({<br/>      type                           = string<br/>      operator                       = optional(string)<br/>      detection_value                = optional(string)<br/>      minimum_supported_os_version   = optional(string)<br/>      maximum_supported_os_version   = optional(string)<br/>      disk_space_required_in_mb      = optional(number)<br/>      physical_memory_required_in_mb = optional(number)<br/>      cpu_speed_required_in_mhz      = optional(number)<br/>    })), [])<br/>    minimum_supported_operating_system = optional(object({<br/>      v10_1607 = optional(bool, false)<br/>      v10_1703 = optional(bool, false)<br/>      v10_1709 = optional(bool, false)<br/>      v10_1803 = optional(bool, false)<br/>      v10_1809 = optional(bool, false)<br/>      v10_1903 = optional(bool, false)<br/>      v10_1909 = optional(bool, false)<br/>      v10_2004 = optional(bool, false)<br/>      v10_2h20 = optional(bool, false)<br/>      v10_21h1 = optional(bool, true)<br/>    }))<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_android_store_app_id"></a> [android\_store\_app\_id](#output\_android\_store\_app\_id) | The ID of the Android Store App. |
| <a name="output_app_type"></a> [app\_type](#output\_app\_type) | The type of the Mobile App. |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the Mobile App. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Mobile App. |
| <a name="output_ios_store_app_id"></a> [ios\_store\_app\_id](#output\_ios\_store\_app\_id) | The ID of the iOS Store App. |
| <a name="output_web_link_app_id"></a> [web\_link\_app\_id](#output\_web\_link\_app\_id) | The ID of the Web Link App. |
| <a name="output_win32_lob_app_id"></a> [win32\_lob\_app\_id](#output\_win32\_lob\_app\_id) | The ID of the Win32 LOB App. |
<!-- END_TF_DOCS -->