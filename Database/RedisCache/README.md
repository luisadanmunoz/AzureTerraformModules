# Redis Cache

Terraform module for Azure Cache for Redis.

## Features

- Basic, Standard, and Premium SKU tiers
- Redis 4 and 6 versions supported
- VNet integration (Premium SKU)
- Clustering with sharding (Premium SKU)
- Zone redundancy (Premium SKU)
- RDB and AOF persistence (Premium SKU)
- Firewall rules
- Managed identity support
- Patch scheduling

## Usage

### Basic Cache (Development)

```hcl
module "redis" {
  source = "./Database/RedisCache"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "myapp"
  environment = "dev"

  sku_name = "Basic"
  family   = "C"
  capacity = 0
}
```

### Standard Cache (Production - Single Region)

```hcl
module "redis" {
  source = "./Database/RedisCache"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "myapp"
  environment = "prod"

  sku_name            = "Standard"
  family              = "C"
  capacity            = 2
  minimum_tls_version = "1.2"
  enable_non_ssl_port = false

  redis_configuration = {
    maxmemory_policy = "allkeys-lru"
  }
}
```

### Premium Cache with VNet and Clustering

```hcl
module "redis" {
  source = "./Database/RedisCache"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "enterprise"
  environment = "prod"

  sku_name            = "Premium"
  family              = "P"
  capacity            = 3
  shard_count         = 3
  replicas_per_master = 1

  # VNet integration
  subnet_id = azurerm_subnet.redis.id

  # Zone redundancy
  zones = ["1", "2", "3"]

  # Persistence
  redis_configuration = {
    rdb_backup_enabled            = true
    rdb_backup_frequency          = 60
    rdb_backup_max_snapshot_count = 1
    rdb_storage_connection_string = azurerm_storage_account.backup.primary_blob_connection_string
    maxmemory_policy              = "volatile-lru"
  }

  # Maintenance
  patch_schedules = [
    {
      day_of_week    = "Sunday"
      start_hour_utc = 2
    }
  ]

  identity = {
    type = "SystemAssigned"
  }
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
| resource_group_name | Resource group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | Cache name (overrides generated) | `string` | `null` | no |
| workload | Workload name for naming | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| sku_name | SKU name (Basic/Standard/Premium) | `string` | `"Standard"` | no |
| family | SKU family (C/P) | `string` | `"C"` | no |
| capacity | Cache size (0-6 for C, 1-5 for P) | `number` | `1` | no |
| redis_version | Redis version (4 or 6) | `string` | `"6"` | no |
| minimum_tls_version | Minimum TLS version | `string` | `"1.2"` | no |
| enable_non_ssl_port | Enable non-SSL port | `bool` | `false` | no |
| subnet_id | Subnet ID (Premium only) | `string` | `null` | no |
| shard_count | Number of shards (Premium only) | `number` | `null` | no |
| zones | Availability zones (Premium only) | `list(string)` | `null` | no |
| redis_configuration | Redis configuration | `object` | `null` | no |
| firewall_rules | Firewall rules list | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Redis Cache ID |
| name | Cache name |
| hostname | Cache hostname |
| ssl_port | SSL port (6380) |
| primary_access_key | Primary access key |
| secondary_access_key | Secondary access key |
| primary_connection_string | Primary connection string |
| secondary_connection_string | Secondary connection string |
| principal_id | System assigned identity principal ID |

## SKU Comparison

| Feature | Basic | Standard | Premium |
|---------|-------|----------|---------|
| SLA | No | 99.9% | 99.9% |
| Replication | No | Yes | Yes |
| VNet | No | No | Yes |
| Clustering | No | No | Yes |
| Persistence | No | No | Yes |
| Zone Redundancy | No | No | Yes |
| Geo-Replication | No | No | Yes |

## Cache Sizes

| Family | Capacity | Memory |
|--------|----------|--------|
| C (Basic/Standard) | 0 | 250 MB |
| C (Basic/Standard) | 1 | 1 GB |
| C (Basic/Standard) | 2 | 2.5 GB |
| C (Basic/Standard) | 3 | 6 GB |
| C (Basic/Standard) | 4 | 13 GB |
| C (Basic/Standard) | 5 | 26 GB |
| C (Basic/Standard) | 6 | 53 GB |
| P (Premium) | 1 | 6 GB |
| P (Premium) | 2 | 13 GB |
| P (Premium) | 3 | 26 GB |
| P (Premium) | 4 | 53 GB |
| P (Premium) | 5 | 120 GB |

## Notes

- TLS 1.2 is recommended for production
- Non-SSL port should be disabled for production
- Premium SKU required for VNet, clustering, and persistence
- Consider using Private Endpoints instead of VNet injection for new deployments

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
| [azurerm_redis_cache.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |
| [azurerm_redis_firewall_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_firewall_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_capacity"></a> [capacity](#input\_capacity) | The size of the Redis cache. Valid values for Basic/Standard are 0-6, for Premium are 1-5. | `number` | `1` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_enable_non_ssl_port"></a> [enable\_non\_ssl\_port](#input\_enable\_non\_ssl\_port) | Enable the non-SSL port (6379). Not recommended for production. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (dev, staging, prod) for naming convention. | `string` | `""` | no |
| <a name="input_family"></a> [family](#input\_family) | The SKU family/pricing group. Valid values are C (Basic/Standard) and P (Premium). | `string` | `"C"` | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | List of firewall rules for the Redis Cache. | <pre>list(object({<br/>    name     = string<br/>    start_ip = string<br/>    end_ip   = string<br/>  }))</pre> | `[]` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Managed identity configuration for the Redis Cache. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Redis Cache will be created. | `string` | n/a | yes |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | The minimum TLS version. Possible values are 1.0, 1.1, 1.2. | `string` | `"1.2"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Redis Cache. If not provided, will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the Redis Cache name. | `string` | `"redis"` | no |
| <a name="input_patch_schedules"></a> [patch\_schedules](#input\_patch\_schedules) | List of patch schedules for the Redis Cache (Premium SKU only). | <pre>list(object({<br/>    day_of_week        = string<br/>    start_hour_utc     = optional(number)<br/>    maintenance_window = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_private_static_ip_address"></a> [private\_static\_ip\_address](#input\_private\_static\_ip\_address) | The static IP address to assign to the Redis Cache (Premium SKU only). | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is enabled for the Redis Cache. | `bool` | `true` | no |
| <a name="input_redis_configuration"></a> [redis\_configuration](#input\_redis\_configuration) | Redis configuration settings. | <pre>object({<br/>    aof_backup_enabled                      = optional(bool)<br/>    aof_storage_connection_string_0         = optional(string)<br/>    aof_storage_connection_string_1         = optional(string)<br/>    enable_authentication                   = optional(bool, true)<br/>    active_directory_authentication_enabled = optional(bool)<br/>    maxmemory_reserved                      = optional(number)<br/>    maxmemory_delta                         = optional(number)<br/>    maxmemory_policy                        = optional(string)<br/>    maxfragmentationmemory_reserved         = optional(number)<br/>    rdb_backup_enabled                      = optional(bool)<br/>    rdb_backup_frequency                    = optional(number)<br/>    rdb_backup_max_snapshot_count           = optional(number)<br/>    rdb_storage_connection_string           = optional(string)<br/>    notify_keyspace_events                  = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | The Redis version. Possible values are 4 and 6. | `string` | `"6"` | no |
| <a name="input_replicas_per_master"></a> [replicas\_per\_master](#input\_replicas\_per\_master) | Number of replicas per master for the Redis Cache. | `number` | `null` | no |
| <a name="input_replicas_per_primary"></a> [replicas\_per\_primary](#input\_replicas\_per\_primary) | Number of replicas per primary for the Redis Cache. | `number` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the Redis Cache will be created. | `string` | n/a | yes |
| <a name="input_shard_count"></a> [shard\_count](#input\_shard\_count) | The number of shards to create on a Premium Cluster Cache (1-10). | `number` | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name for the Redis Cache. Possible values are Basic, Standard, Premium, Enterprise\_E10, Enterprise\_E20, Enterprise\_E50, Enterprise\_E100, EnterpriseFlash\_F300, EnterpriseFlash\_F700, EnterpriseFlash\_F1500. | `string` | `"Standard"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet where the Redis Cache should be deployed (Premium SKU only). | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name for naming convention. | `string` | `""` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | List of availability zones for the Redis Cache (Premium SKU only). | `list(string)` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_firewall_rule_ids"></a> [firewall\_rule\_ids](#output\_firewall\_rule\_ids) | Map of firewall rule names to their IDs. |
| <a name="output_hostname"></a> [hostname](#output\_hostname) | The hostname of the Redis Cache. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Redis Cache. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity configuration of the Redis Cache. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Redis Cache. |
| <a name="output_port"></a> [port](#output\_port) | The non-SSL port of the Redis Cache (if enabled). |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for the Redis Cache. |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The primary connection string for the Redis Cache. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID of the System Assigned Managed Identity. |
| <a name="output_redis_configuration"></a> [redis\_configuration](#output\_redis\_configuration) | The Redis configuration of the cache. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The secondary access key for the Redis Cache. |
| <a name="output_secondary_connection_string"></a> [secondary\_connection\_string](#output\_secondary\_connection\_string) | The secondary connection string for the Redis Cache. |
| <a name="output_ssl_port"></a> [ssl\_port](#output\_ssl\_port) | The SSL port of the Redis Cache. |
<!-- END_TF_DOCS -->