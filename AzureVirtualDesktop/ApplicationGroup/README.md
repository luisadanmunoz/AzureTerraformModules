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
| [azurerm_virtual_desktop_application_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_application_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the AVD Application Group. | `bool` | `true` | no |
| <a name="input_default_desktop_display_name"></a> [default\_desktop\_display\_name](#input\_default\_desktop\_display\_name) | (Optional) The display name for the default desktop. Only for Desktop type. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description for the Application Group. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_friendly_name"></a> [friendly\_name](#input\_friendly\_name) | (Optional) A friendly name for the Application Group. | `string` | `null` | no |
| <a name="input_host_pool_id"></a> [host\_pool\_id](#input\_host\_pool\_id) | (Required) The ID of the Host Pool. DEPENDENCY: Host Pool must exist. | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Application Group should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Application Group. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'vdag'. | `string` | `"vdag"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | (Required) The type of the Application Group. Values: Desktop, RemoteApp. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"avd"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_host_pool_id"></a> [host\_pool\_id](#output\_host\_pool\_id) | The Host Pool ID associated with this Application Group. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the AVD Application Group. |
| <a name="output_name"></a> [name](#output\_name) | The name of the AVD Application Group. |
| <a name="output_type"></a> [type](#output\_type) | The type of the Application Group (Desktop or RemoteApp). |
<!-- END_TF_DOCS -->