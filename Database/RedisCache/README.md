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
