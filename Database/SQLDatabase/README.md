# SQLDatabase (Azure SQL Database)

Terraform module for Azure SQL Database.

## Features

- Multiple SKU tiers (Basic, Standard, Premium, General Purpose, Business Critical)
- Serverless tier support with auto-pause
- Elastic pool integration
- Zone redundancy for high availability
- Read replicas for Premium/Business Critical
- Short-term and long-term backup retention
- Point-in-time restore and geo-restore
- Threat detection policy
- TDE with customer-managed key support
- Ledger database support

## Usage

### Basic Database

```hcl
module "sql_database" {
  source = "./Database/SQLDatabase"

  server_id = module.sql_server.id

  workload    = "myapp"
  environment = "dev"

  sku_name   = "Basic"
  max_size_gb = 2
}
```

### Serverless Database (Cost-Effective for Dev/Test)

```hcl
module "sql_database" {
  source = "./Database/SQLDatabase"

  server_id = module.sql_server.id

  workload    = "myapp"
  environment = "dev"

  # Serverless tier
  sku_name                    = "GP_S_Gen5_2"
  auto_pause_delay_in_minutes = 60  # Auto-pause after 1 hour of inactivity
  min_capacity                = 0.5

  max_size_gb = 32

  # Cost-effective backup for dev
  storage_account_type = "Local"
  geo_backup_enabled   = false
}
```

### Production Database (High Availability)

```hcl
module "sql_database" {
  source = "./Database/SQLDatabase"

  server_id = module.sql_server.id

  workload    = "enterprise"
  environment = "prod"

  # Business Critical for high availability
  sku_name       = "BC_Gen5_4"
  max_size_gb    = 256
  zone_redundant = true
  read_scale     = true

  # Backup retention (compliance)
  short_term_retention_policy = {
    retention_days           = 35
    backup_interval_in_hours = 12
  }

  long_term_retention_policy = {
    weekly_retention  = "P4W"   # 4 weeks
    monthly_retention = "P12M"  # 12 months
    yearly_retention  = "P5Y"   # 5 years
    week_of_year      = 1
  }

  # Threat detection
  threat_detection_policy = {
    state                = "Enabled"
    email_account_admins = "Enabled"
    email_addresses      = ["security@example.com"]
    retention_days       = 90
  }

  # Geo-redundant backup
  storage_account_type = "Geo"
  geo_backup_enabled   = true
}
```

### Database in Elastic Pool

```hcl
module "sql_database" {
  source = "./Database/SQLDatabase"

  server_id       = module.sql_server.id
  elastic_pool_id = module.elastic_pool.id

  workload    = "tenant"
  environment = "prod"
  instance    = "001"

  # SKU is determined by elastic pool
  max_size_gb = 50
}
```

### Point-in-Time Restore

```hcl
module "sql_database_restored" {
  source = "./Database/SQLDatabase"

  server_id = module.sql_server.id

  name = "mydb-restored"

  create_mode                 = "PointInTimeRestore"
  creation_source_database_id = module.original_database.id
  restore_point_in_time       = "2024-01-15T10:30:00Z"

  sku_name    = "GP_Gen5_2"
  max_size_gb = 100
}
```

### With Customer-Managed Key (CMK)

```hcl
module "sql_database" {
  source = "./Database/SQLDatabase"

  server_id = module.sql_server.id

  workload    = "encrypted"
  environment = "prod"

  sku_name    = "BC_Gen5_4"
  max_size_gb = 100

  # CMK for TDE
  transparent_data_encryption_enabled                        = true
  transparent_data_encryption_key_vault_key_id               = azurerm_key_vault_key.sql_tde.id
  transparent_data_encryption_key_automatic_rotation_enabled = true

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.sql.id]
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
| server_id | SQL Server ID | `string` | n/a | yes |
| name | Database name | `string` | `null` | no |
| workload | Workload name | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| sku_name | SKU name | `string` | `"GP_S_Gen5_2"` | no |
| max_size_gb | Max size in GB | `number` | `null` | no |
| elastic_pool_id | Elastic pool ID | `string` | `null` | no |
| zone_redundant | Enable zone redundancy | `bool` | `false` | no |
| read_scale | Enable read replicas | `bool` | `false` | no |
| auto_pause_delay_in_minutes | Auto-pause delay (serverless) | `number` | `null` | no |
| min_capacity | Min capacity (serverless) | `number` | `null` | no |
| short_term_retention_policy | Short-term backup | `object` | 7 days | no |
| long_term_retention_policy | Long-term backup | `object` | `null` | no |
| threat_detection_policy | Threat detection | `object` | `null` | no |
| create_mode | Creation mode | `string` | `"Default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Database ID |
| name | Database name |
| server_id | Server ID |
| sku_name | SKU name |
| max_size_gb | Max size in GB |
| zone_redundant | Zone redundancy status |

## SKU Reference

| Tier | SKU Examples | Use Case |
|------|--------------|----------|
| Basic | Basic | Dev/Test, small workloads |
| Standard | S0, S1, S2, S3 | General purpose |
| Premium | P1, P2, P4, P6, P11, P15 | High performance, HA |
| General Purpose | GP_Gen5_2, GP_S_Gen5_2 | Most workloads |
| Business Critical | BC_Gen5_2, BC_Gen5_4 | Mission-critical, HA |
| Hyperscale | HS_Gen5_2 | Large databases, fast scaling |

## Notes

- TDE is enabled by default for security
- Consider serverless for dev/test to reduce costs
- Use Business Critical for mission-critical workloads
- Long-term retention requires Azure Backup integration
- Zone redundancy requires Premium or Business Critical tier
