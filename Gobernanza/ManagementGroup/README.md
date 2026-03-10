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
