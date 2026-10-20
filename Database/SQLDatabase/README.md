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
| [azurerm_mssql_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_auto_pause_delay_in_minutes"></a> [auto\_pause\_delay\_in\_minutes](#input\_auto\_pause\_delay\_in\_minutes) | Time in minutes after which database is automatically paused. Only for Serverless tier. -1 means disabled. | `number` | `null` | no |
| <a name="input_collation"></a> [collation](#input\_collation) | The collation of the database. | `string` | `"SQL_Latin1_General_CP1_CI_AS"` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_create_mode"></a> [create\_mode](#input\_create\_mode) | The creation mode. Valid values are Default, Copy, PointInTimeRestore, Recovery, Restore, RestoreExternalBackup, etc. | `string` | `"Default"` | no |
| <a name="input_creation_source_database_id"></a> [creation\_source\_database\_id](#input\_creation\_source\_database\_id) | The ID of the source database for Copy, PointInTimeRestore, etc. | `string` | `null` | no |
| <a name="input_elastic_pool_id"></a> [elastic\_pool\_id](#input\_elastic\_pool\_id) | The ID of the elastic pool containing this database. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (dev, staging, prod) for naming convention. | `string` | `""` | no |
| <a name="input_geo_backup_enabled"></a> [geo\_backup\_enabled](#input\_geo\_backup\_enabled) | Whether geo-redundant backup is enabled. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Managed identity configuration for the database. | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_ledger_enabled"></a> [ledger\_enabled](#input\_ledger\_enabled) | Whether to enable ledger on the database. | `bool` | `false` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | The license type for the database. Valid values are LicenseIncluded or BasePrice. | `string` | `"LicenseIncluded"` | no |
| <a name="input_long_term_retention_policy"></a> [long\_term\_retention\_policy](#input\_long\_term\_retention\_policy) | Long-term backup retention policy configuration. | <pre>object({<br/>    weekly_retention  = optional(string)<br/>    monthly_retention = optional(string)<br/>    yearly_retention  = optional(string)<br/>    week_of_year      = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_max_size_gb"></a> [max\_size\_gb](#input\_max\_size\_gb) | The maximum size of the database in gigabytes. | `number` | `null` | no |
| <a name="input_min_capacity"></a> [min\_capacity](#input\_min\_capacity) | Minimum capacity for serverless database. Only for Serverless tier. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the SQL Database. If not provided, will be generated from naming variables. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the SQL Database name. | `string` | `"sqldb"` | no |
| <a name="input_read_scale"></a> [read\_scale](#input\_read\_scale) | Whether read-only connections are allowed. Only applicable for Premium and Business Critical SKUs. | `bool` | `false` | no |
| <a name="input_recover_database_id"></a> [recover\_database\_id](#input\_recover\_database\_id) | The ID of the database to recover. Required when create\_mode is Recovery. | `string` | `null` | no |
| <a name="input_restore_dropped_database_id"></a> [restore\_dropped\_database\_id](#input\_restore\_dropped\_database\_id) | The ID of the dropped database to restore. Required when create\_mode is Restore. | `string` | `null` | no |
| <a name="input_restore_point_in_time"></a> [restore\_point\_in\_time](#input\_restore\_point\_in\_time) | The point in time for restore. Required when create\_mode is PointInTimeRestore. | `string` | `null` | no |
| <a name="input_server_id"></a> [server\_id](#input\_server\_id) | The ID of the SQL Server on which to create the database. | `string` | n/a | yes |
| <a name="input_short_term_retention_policy"></a> [short\_term\_retention\_policy](#input\_short\_term\_retention\_policy) | Short-term backup retention policy configuration. | <pre>object({<br/>    retention_days           = number<br/>    backup_interval_in_hours = optional(number, 12)<br/>  })</pre> | <pre>{<br/>  "backup_interval_in_hours": 12,<br/>  "retention_days": 7<br/>}</pre> | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name for the database. Examples: Basic, S0, S1, P1, GP\_S\_Gen5\_2, GP\_Gen5\_2, BC\_Gen5\_2. | `string` | `"GP_S_Gen5_2"` | no |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | The storage account type for the database backups. Valid values are Geo, Local, or Zone. | `string` | `"Geo"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_threat_detection_policy"></a> [threat\_detection\_policy](#input\_threat\_detection\_policy) | Threat detection policy configuration for the database. | <pre>object({<br/>    state                      = optional(string, "Enabled")<br/>    disabled_alerts            = optional(list(string), [])<br/>    email_account_admins       = optional(string, "Enabled")<br/>    email_addresses            = optional(list(string), [])<br/>    retention_days             = optional(number, 30)<br/>    storage_endpoint           = optional(string)<br/>    storage_account_access_key = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_transparent_data_encryption_enabled"></a> [transparent\_data\_encryption\_enabled](#input\_transparent\_data\_encryption\_enabled) | Whether Transparent Data Encryption is enabled. | `bool` | `true` | no |
| <a name="input_transparent_data_encryption_key_automatic_rotation_enabled"></a> [transparent\_data\_encryption\_key\_automatic\_rotation\_enabled](#input\_transparent\_data\_encryption\_key\_automatic\_rotation\_enabled) | Whether automatic rotation is enabled for the TDE key. | `bool` | `false` | no |
| <a name="input_transparent_data_encryption_key_vault_key_id"></a> [transparent\_data\_encryption\_key\_vault\_key\_id](#input\_transparent\_data\_encryption\_key\_vault\_key\_id) | The Key Vault Key ID for TDE with customer-managed key. | `string` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name for naming convention. | `string` | `""` | no |
| <a name="input_zone_redundant"></a> [zone\_redundant](#input\_zone\_redundant) | Whether the database is zone redundant. Only applicable for Premium and Business Critical SKUs. | `bool` | `false` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the SQL Database. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity configuration of the database. |
| <a name="output_max_size_gb"></a> [max\_size\_gb](#output\_max\_size\_gb) | The maximum size of the database in GB. |
| <a name="output_name"></a> [name](#output\_name) | The name of the SQL Database. |
| <a name="output_server_id"></a> [server\_id](#output\_server\_id) | The ID of the SQL Server hosting this database. |
| <a name="output_sku_name"></a> [sku\_name](#output\_sku\_name) | The SKU name of the database. |
| <a name="output_zone_redundant"></a> [zone\_redundant](#output\_zone\_redundant) | Whether the database is zone redundant. |
<!-- END_TF_DOCS -->