# MaintenanceConfiguration

Terraform module for creating Azure Maintenance Configurations for scheduled updates and patching.

## Features

- Multiple scope types (Host, InGuestPatch, Extension, OSImage, SQL)
- Flexible maintenance window scheduling
- In-guest patching for Linux and Windows VMs
- Classification-based patch filtering
- KB number include/exclude for Windows
- Package name filtering for Linux
- Conditional creation with `create` flag

## Usage

### VM In-Guest Patching

```hcl
module "patch_config" {
  source = "./BackupAndUpdate/MaintenanceConfiguration"

  resource_group_name = "rg-maintenance-prod-001"
  location            = "westeurope"
  name                = "maint-patching-prod-001"
  scope               = "InGuestPatch"
  in_guest_user_patch_mode = "Platform"

  window = {
    start_date_time = "2024-01-15 02:00"
    duration        = "03:00"
    time_zone       = "UTC"
    recur_every     = "Week Sunday"
  }

  install_patches = {
    reboot = "IfRequired"
    windows = {
      classifications_to_include = ["Critical", "Security"]
    }
    linux = {
      classifications_to_include = ["Critical", "Security"]
    }
  }
}
```

### Host Maintenance

```hcl
module "host_maintenance" {
  source = "./BackupAndUpdate/MaintenanceConfiguration"

  resource_group_name = "rg-maintenance-prod-001"
  location            = "westeurope"
  name                = "maint-host-prod-001"
  scope               = "Host"

  window = {
    start_date_time = "2024-01-15 03:00"
    duration        = "05:00"
    time_zone       = "UTC"
    recur_every     = "Month Fourth Sunday"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the resource | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | Maintenance Configuration name | `string` | `null` | no |
| scope | Scope type | `string` | n/a | yes |
| visibility | Visibility (Custom/Public) | `string` | `"Custom"` | no |
| in_guest_user_patch_mode | Patch mode for InGuestPatch | `string` | `null` | no |
| window | Maintenance window configuration | `object` | `null` | no |
| install_patches | Patch installation configuration | `object` | `null` | no |
| tags | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Maintenance Configuration |
| name | The name of the Maintenance Configuration |
| scope | The scope of the Maintenance Configuration |
| location | The location of the Maintenance Configuration |

## Scope Types

| Scope | Description |
|-------|-------------|
| `Host` | Azure Dedicated Host maintenance |
| `InGuestPatch` | VM in-guest patching (Windows/Linux) |
| `Extension` | VM extension updates |
| `OSImage` | OS image updates |
| `SQLDB` | SQL Database maintenance |
| `SQLManagedInstance` | SQL Managed Instance maintenance |

## Recurrence Patterns

- `Day` - Every day
- `Week Sunday` - Every Sunday
- `2Weeks Monday` - Every 2 weeks on Monday
- `Month First Sunday` - First Sunday of month
- `Month Fourth Sunday` - Fourth Sunday of month

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_maintenance_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maintenance_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Maintenance Configuration. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_in_guest_user_patch_mode"></a> [in\_guest\_user\_patch\_mode](#input\_in\_guest\_user\_patch\_mode) | (Optional) The in-guest user patch mode. Values: Platform, User. Required when scope is InGuestPatch. | `string` | `null` | no |
| <a name="input_install_patches"></a> [install\_patches](#input\_install\_patches) | (Optional) Install patches configuration for InGuestPatch scope.<br/>- reboot: Reboot behavior. Values: Always, IfRequired, Never.<br/>- linux: Linux patch configuration.<br/>- windows: Windows patch configuration. | <pre>object({<br/>    reboot = optional(string, "IfRequired")<br/>    linux = optional(object({<br/>      classifications_to_include    = optional(list(string), ["Critical", "Security"])<br/>      package_names_mask_to_exclude = optional(list(string), [])<br/>      package_names_mask_to_include = optional(list(string), [])<br/>    }), null)<br/>    windows = optional(object({<br/>      classifications_to_include = optional(list(string), ["Critical", "Security"])<br/>      kb_numbers_to_exclude      = optional(list(string), [])<br/>      kb_numbers_to_include      = optional(list(string), [])<br/>    }), null)<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Maintenance Configuration should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Maintenance Configuration. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'maint'. | `string` | `"maint"` | no |
| <a name="input_properties"></a> [properties](#input\_properties) | (Optional) A map of properties for the Maintenance Configuration. | `map(string)` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | (Required) The scope of the Maintenance Configuration. Values: Extension, Host, InGuestPatch, OSImage, SQLDB, SQLManagedInstance. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | (Optional) The visibility of the Maintenance Configuration. Values: Custom, Public. Default: Custom. | `string` | `"Custom"` | no |
| <a name="input_window"></a> [window](#input\_window) | (Optional) Maintenance window configuration.<br/>- start\_date\_time: Start date/time in format 'yyyy-MM-dd HH:mm'.<br/>- expiration\_date\_time: (Optional) Expiration date/time.<br/>- duration: Duration in HH:mm format (e.g., '02:00' for 2 hours).<br/>- time\_zone: Time zone (e.g., 'UTC', 'Pacific Standard Time').<br/>- recur\_every: Recurrence pattern (e.g., 'Day', 'Week', '2Weeks', 'Month'). | <pre>object({<br/>    start_date_time      = string<br/>    expiration_date_time = optional(string, null)<br/>    duration             = optional(string, "02:00")<br/>    time_zone            = optional(string, "UTC")<br/>    recur_every          = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"config"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Maintenance Configuration. |
| <a name="output_location"></a> [location](#output\_location) | The location of the Maintenance Configuration. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Maintenance Configuration. |
| <a name="output_scope"></a> [scope](#output\_scope) | The scope of the Maintenance Configuration. |
<!-- END_TF_DOCS -->