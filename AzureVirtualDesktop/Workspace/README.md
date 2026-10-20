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
| [azurerm_virtual_desktop_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_workspace) | resource |
| [azurerm_virtual_desktop_workspace_application_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_workspace_application_group_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_application_group_ids"></a> [application\_group\_ids](#input\_application\_group\_ids) | (Optional) List of Application Group IDs to associate. DEPENDENCY: Application Groups must exist. | `list(string)` | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the AVD Workspace. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description for the Workspace. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_friendly_name"></a> [friendly\_name](#input\_friendly\_name) | (Optional) A friendly name for the Workspace displayed to users. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Workspace should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Workspace. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'vdws'. | `string` | `"vdws"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether public network access is enabled. Default: true. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"avd"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_associated_application_group_ids"></a> [associated\_application\_group\_ids](#output\_associated\_application\_group\_ids) | The list of Application Group IDs associated with this Workspace. |
| <a name="output_friendly_name"></a> [friendly\_name](#output\_friendly\_name) | The friendly name of the Workspace. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the AVD Workspace. |
| <a name="output_name"></a> [name](#output\_name) | The name of the AVD Workspace. |
<!-- END_TF_DOCS -->