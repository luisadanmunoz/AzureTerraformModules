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
| [azurerm_mssql_elasticpool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_elasticpool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_enclave_type"></a> [enclave\_type](#input\_enclave\_type) | The type of enclave for the elastic pool. Valid values are Default or VBS. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (dev, staging, prod) for naming convention. | `string` | `""` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | The license type for the elastic pool. Valid values are LicenseIncluded or BasePrice. | `string` | `"LicenseIncluded"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the elastic pool will be created. | `string` | n/a | yes |
| <a name="input_maintenance_configuration_name"></a> [maintenance\_configuration\_name](#input\_maintenance\_configuration\_name) | The name of the maintenance configuration. Examples: SQL\_Default, SQL\_WestEurope\_DB\_1. | `string` | `"SQL_Default"` | no |
| <a name="input_max_size_gb"></a> [max\_size\_gb](#input\_max\_size\_gb) | The maximum size of the elastic pool in gigabytes. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the elastic pool. If not provided, will be generated from naming variables. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the elastic pool name. | `string` | `"sqlep"` | no |
| <a name="input_per_database_settings"></a> [per\_database\_settings](#input\_per\_database\_settings) | Per-database settings for the elastic pool. | <pre>object({<br/>    min_capacity = number<br/>    max_capacity = number<br/>  })</pre> | <pre>{<br/>  "max_capacity": 2,<br/>  "min_capacity": 0<br/>}</pre> | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_server_id"></a> [server\_id](#input\_server\_id) | The ID of the SQL Server on which to create the elastic pool. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | SKU configuration for the elastic pool. | <pre>object({<br/>    name     = string<br/>    tier     = string<br/>    family   = optional(string)<br/>    capacity = number<br/>  })</pre> | <pre>{<br/>  "capacity": 2,<br/>  "family": "Gen5",<br/>  "name": "GP_Gen5",<br/>  "tier": "GeneralPurpose"<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name for naming convention. | `string` | `""` | no |
| <a name="input_zone_redundant"></a> [zone\_redundant](#input\_zone\_redundant) | Whether the elastic pool is zone redundant. Only for Premium and Business Critical tiers. | `bool` | `false` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the elastic pool. |
| <a name="output_max_size_gb"></a> [max\_size\_gb](#output\_max\_size\_gb) | The maximum size of the elastic pool in GB. |
| <a name="output_name"></a> [name](#output\_name) | The name of the elastic pool. |
| <a name="output_per_database_settings"></a> [per\_database\_settings](#output\_per\_database\_settings) | The per-database settings of the elastic pool. |
| <a name="output_sku_name"></a> [sku\_name](#output\_sku\_name) | The SKU name of the elastic pool. |
| <a name="output_zone_redundant"></a> [zone\_redundant](#output\_zone\_redundant) | Whether the elastic pool is zone redundant. |
<!-- END_TF_DOCS -->