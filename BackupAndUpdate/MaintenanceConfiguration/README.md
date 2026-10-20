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
