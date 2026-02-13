# Azure Virtual Desktop Application Group Module

Terraform module for creating and managing Azure Virtual Desktop Application Groups.

## Description

This module creates an AVD Application Group with support for:

- **Desktop Application Groups**: Full desktop experience
- **RemoteApp Application Groups**: Individual published applications
- **Friendly Names**: User-friendly display names
- **Custom Desktop Names**: Custom display name for default desktop

## Usage

### Desktop Application Group

```hcl
module "app_group_desktop" {
  source = "./AzureVirtualDesktop/ApplicationGroup"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"
  name                = "vdag-desktop-prod-001"

  host_pool_id = module.hostpool.id
  type         = "Desktop"

  friendly_name                = "Full Desktop"
  description                  = "Full desktop access for power users"
  default_desktop_display_name = "Virtual Desktop"

  tags = {
    Environment = "Production"
  }
}
```

### RemoteApp Application Group

```hcl
module "app_group_remoteapp" {
  source = "./AzureVirtualDesktop/ApplicationGroup"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"
  name                = "vdag-office-prod-001"

  host_pool_id = module.hostpool.id
  type         = "RemoteApp"

  friendly_name = "Office Applications"
  description   = "Microsoft Office suite applications"

  tags = {
    Environment = "Production"
    Apps        = "Office"
  }
}
```

### Multiple Application Groups

```hcl
# Desktop for admins
module "app_group_admin" {
  source = "./AzureVirtualDesktop/ApplicationGroup"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"

  host_pool_id = module.hostpool.id
  type         = "Desktop"

  workload    = "admin"
  environment = "prod"

  friendly_name                = "Admin Desktop"
  default_desktop_display_name = "Admin Workstation"
}

# RemoteApp for general users
module "app_group_general" {
  source = "./AzureVirtualDesktop/ApplicationGroup"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"

  host_pool_id = module.hostpool.id
  type         = "RemoteApp"

  workload    = "general"
  environment = "prod"

  friendly_name = "Business Applications"
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
| resource_group_name | The name of the Resource Group | `string` | n/a | yes |
| location | The Azure Region | `string` | n/a | yes |
| name | The name of the Application Group | `string` | `null` | no |
| host_pool_id | The ID of the Host Pool | `string` | n/a | yes |
| type | Application Group type: Desktop or RemoteApp | `string` | n/a | yes |
| friendly_name | Friendly display name | `string` | `null` | no |
| description | Description of the Application Group | `string` | `null` | no |
| default_desktop_display_name | Display name for default desktop | `string` | `null` | no |
| tags | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Application Group |
| name | The name of the Application Group |
| type | The type of the Application Group |
| host_pool_id | The associated Host Pool ID |

## Dependencies

- Resource Group must exist
- Host Pool must exist (DEPENDENCY: HostPool module)

## Related Modules

- [HostPool](../HostPool) - Create the host pool for this application group
- [Workspace](../Workspace) - Associate this application group with a workspace

## Notes

- Each Host Pool can have one Desktop Application Group
- Each Host Pool can have multiple RemoteApp Application Groups
- Application Groups must be associated with a Workspace for users to access them
