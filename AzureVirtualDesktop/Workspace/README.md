# Azure Virtual Desktop Workspace Module

Terraform module for creating and managing Azure Virtual Desktop Workspaces.

## Description

This module creates an AVD Workspace with support for:

- **Friendly Names**: User-friendly display names shown in AVD clients
- **Application Group Association**: Associate multiple application groups
- **Public Network Access**: Control public access to the workspace
- **Automatic Association**: Associate application groups during creation

## Usage

### Basic Workspace

```hcl
module "workspace" {
  source = "./AzureVirtualDesktop/Workspace"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"
  name                = "vdws-corporate-prod-001"

  friendly_name = "Corporate Virtual Desktops"
  description   = "Virtual desktop environment for corporate users"

  tags = {
    Environment = "Production"
  }
}
```

### With Application Group Associations

```hcl
module "workspace" {
  source = "./AzureVirtualDesktop/Workspace"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"
  name                = "vdws-corporate-prod-001"

  friendly_name = "Corporate Virtual Desktops"
  description   = "Virtual desktop environment for corporate users"

  # Associate application groups
  application_group_ids = [
    module.app_group_desktop.id,
    module.app_group_office.id,
    module.app_group_custom.id,
  ]

  tags = {
    Environment = "Production"
  }
}
```

### Restricted Access Workspace

```hcl
module "workspace_private" {
  source = "./AzureVirtualDesktop/Workspace"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"

  workload    = "secure"
  environment = "prod"

  friendly_name                 = "Secure Desktop Environment"
  public_network_access_enabled = false

  application_group_ids = [
    module.secure_desktop_group.id,
  ]

  tags = {
    Environment  = "Production"
    SecurityTier = "High"
  }
}
```

### Multiple Workspaces for Different Teams

```hcl
# Engineering workspace
module "workspace_engineering" {
  source = "./AzureVirtualDesktop/Workspace"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"

  workload    = "engineering"
  environment = "prod"

  friendly_name = "Engineering Workspaces"

  application_group_ids = [
    module.app_group_dev_desktop.id,
    module.app_group_dev_tools.id,
  ]
}

# Finance workspace
module "workspace_finance" {
  source = "./AzureVirtualDesktop/Workspace"

  resource_group_name = "rg-avd-prod-001"
  location            = "westeurope"

  workload    = "finance"
  environment = "prod"

  friendly_name = "Finance Workspaces"

  application_group_ids = [
    module.app_group_finance_desktop.id,
    module.app_group_finance_apps.id,
  ]
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
| name | The name of the Workspace | `string` | `null` | no |
| friendly_name | Friendly display name for users | `string` | `null` | no |
| description | Description of the Workspace | `string` | `null` | no |
| public_network_access_enabled | Enable public network access | `bool` | `true` | no |
| application_group_ids | Application Group IDs to associate | `list(string)` | `[]` | no |
| tags | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Workspace |
| name | The name of the Workspace |
| friendly_name | The friendly name of the Workspace |
| associated_application_group_ids | Associated Application Group IDs |

## Dependencies

- Resource Group must exist
- Application Groups must exist (if associating)

## Related Modules

- [HostPool](../HostPool) - Create host pools for session hosts
- [ApplicationGroup](../ApplicationGroup) - Create application groups to associate

## Notes

- Workspaces are what users see in the AVD clients (Windows, Web, macOS, iOS, Android)
- Each Application Group can only be associated with one Workspace
- Users need appropriate RBAC permissions to access the Workspace
