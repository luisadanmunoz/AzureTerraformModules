# SQLElasticPool (Azure SQL Elastic Pool)

Terraform module for Azure SQL Elastic Pool.

## Features

- Multiple SKU tiers (Basic, Standard, Premium, GP, BC, Hyperscale)
- Zone redundancy for high availability
- Per-database min/max resource configuration
- Maintenance window configuration
- Azure Hybrid Benefit support (BasePrice license)

## Usage

### Basic Elastic Pool

```hcl
module "elastic_pool" {
  source = "./Database/SQLElasticPool"

  server_id           = module.sql_server.id
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "saas"
  environment = "dev"

  sku = {
    name     = "GP_Gen5"
    tier     = "GeneralPurpose"
    family   = "Gen5"
    capacity = 2
  }

  per_database_settings = {
    min_capacity = 0
    max_capacity = 2
  }
}
```

### Production Elastic Pool (Zone Redundant)

```hcl
module "elastic_pool" {
  source = "./Database/SQLElasticPool"

  server_id           = module.sql_server.id
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "saas"
  environment = "prod"

  # Business Critical for mission-critical workloads
  sku = {
    name     = "BC_Gen5"
    tier     = "BusinessCritical"
    family   = "Gen5"
    capacity = 4
  }

  max_size_gb    = 500
  zone_redundant = true

  per_database_settings = {
    min_capacity = 0.5
    max_capacity = 4
  }

  # Azure Hybrid Benefit
  license_type = "BasePrice"
}
```

### Multi-Tenant SaaS Pool

```hcl
module "elastic_pool" {
  source = "./Database/SQLElasticPool"

  server_id           = module.sql_server.id
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "tenants"
  environment = "prod"

  sku = {
    name     = "GP_Gen5"
    tier     = "GeneralPurpose"
    family   = "Gen5"
    capacity = 8
  }

  max_size_gb = 1024

  # Allow burst but limit per-tenant resources
  per_database_settings = {
    min_capacity = 0
    max_capacity = 2
  }
}

# Then create databases in the pool
module "tenant_db" {
  source = "./Database/SQLDatabase"

  for_each = toset(["tenant1", "tenant2", "tenant3"])

  server_id       = module.sql_server.id
  elastic_pool_id = module.elastic_pool.id

  name        = "db-${each.key}"
  max_size_gb = 50
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
| server_id | SQL Server ID | `string` | n/a | yes |
| resource_group_name | Resource group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | Pool name | `string` | `null` | no |
| workload | Workload name | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| sku | SKU configuration | `object` | GP_Gen5, 2 vCores | no |
| max_size_gb | Maximum pool size | `number` | `null` | no |
| zone_redundant | Enable zone redundancy | `bool` | `false` | no |
| per_database_settings | Per-database min/max | `object` | 0-2 | no |
| license_type | License type | `string` | `"LicenseIncluded"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Elastic pool ID |
| name | Elastic pool name |
| sku_name | SKU name |
| max_size_gb | Maximum size in GB |
| zone_redundant | Zone redundancy status |
| per_database_settings | Per-database settings |

## SKU Reference

| Tier | SKU Name | Use Case |
|------|----------|----------|
| Basic | BasicPool | Development |
| Standard | StandardPool | Standard workloads |
| Premium | PremiumPool | IO-intensive, HA |
| General Purpose | GP_Gen5, GP_Fsv2 | Most workloads |
| Business Critical | BC_Gen5 | Mission-critical |
| Hyperscale | HS_Gen5 | Large scale |

## Notes

- Elastic pools are ideal for SaaS multi-tenant scenarios
- Per-database settings control resource allocation per DB
- Zone redundancy requires Premium or Business Critical
- Use Azure Hybrid Benefit (BasePrice) to reduce costs with existing SQL licenses
- Consider Hyperscale for very large databases
