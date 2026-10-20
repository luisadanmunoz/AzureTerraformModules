# Management Group

Terraform module for Azure Management Group.

## Features

- Hierarchical management group structure
- Subscription association
- Parent-child relationships
- Foundation for policy and RBAC inheritance

## Usage

### Basic Management Group

```hcl
module "mg_platform" {
  source = "./Gobernanza/ManagementGroup"

  name         = "mg-platform"
  display_name = "Platform"
}
```

### Hierarchical Structure

```hcl
# Root level
module "mg_organization" {
  source = "./Gobernanza/ManagementGroup"

  name         = "mg-contoso"
  display_name = "Contoso Organization"
}

# Platform management group
module "mg_platform" {
  source = "./Gobernanza/ManagementGroup"

  name                       = "mg-platform"
  display_name               = "Platform"
  parent_management_group_id = module.mg_organization.id
}

# Landing zones
module "mg_landingzones" {
  source = "./Gobernanza/ManagementGroup"

  name                       = "mg-landingzones"
  display_name               = "Landing Zones"
  parent_management_group_id = module.mg_organization.id
}

# Production landing zone
module "mg_prod" {
  source = "./Gobernanza/ManagementGroup"

  name                       = "mg-prod"
  display_name               = "Production"
  parent_management_group_id = module.mg_landingzones.id
  subscription_ids           = [data.azurerm_subscription.prod.subscription_id]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Management group name | `string` | n/a | yes |
| display_name | Display name | `string` | n/a | yes |
| parent_management_group_id | Parent MG ID | `string` | `null` | no |
| subscription_ids | Subscriptions to associate | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Management Group ID |
| name | Management Group name |
| tenant_scoped_id | Tenant-scoped ID |

## Enterprise-Scale Architecture

```
Tenant Root Group
└── Organization (mg-contoso)
    ├── Platform (mg-platform)
    │   ├── Identity (mg-identity)
    │   ├── Management (mg-management)
    │   └── Connectivity (mg-connectivity)
    ├── Landing Zones (mg-landingzones)
    │   ├── Production (mg-prod)
    │   └── Non-Production (mg-nonprod)
    ├── Sandbox (mg-sandbox)
    └── Decommissioned (mg-decommissioned)
```

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
| [azurerm_management_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the management group. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the management group. | `string` | n/a | yes |
| <a name="input_parent_management_group_id"></a> [parent\_management\_group\_id](#input\_parent\_management\_group\_id) | The ID of the parent Management Group. If null, will be created under the tenant root group. | `string` | `null` | no |
| <a name="input_subscription_ids"></a> [subscription\_ids](#input\_subscription\_ids) | List of subscription IDs to associate with this management group. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Management Group. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Management Group. |
| <a name="output_tenant_scoped_id"></a> [tenant\_scoped\_id](#output\_tenant\_scoped\_id) | The tenant-scoped ID of the Management Group. |
<!-- END_TF_DOCS -->