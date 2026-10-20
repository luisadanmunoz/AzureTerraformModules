# PostgreSQLFlexible (Azure Database for PostgreSQL - Flexible Server)

Terraform module for Azure Database for PostgreSQL - Flexible Server.

## Features

- PostgreSQL versions 11-16
- Burstable, General Purpose, and Memory Optimized SKUs
- VNet integration with private access
- Zone-redundant high availability
- Automatic and geo-redundant backups
- Customer-managed key encryption
- Azure AD authentication
- Automatic storage growth
- Multiple database support
- Server parameter configuration
- Firewall rules

## Usage

### Basic Server (Development)

```hcl
module "postgresql" {
  source = "./Database/PostgreSQLFlexible"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "myapp"
  environment = "dev"

  # Burstable SKU for dev (cost-effective)
  sku_name   = "B_Standard_B1ms"
  storage_mb = 32768
  version    = "16"

  administrator_login    = "pgadmin"
  administrator_password = var.pg_admin_password

  # Public access for development
  public_network_access_enabled = true

  firewall_rules = [
    {
      name             = "AllowMyIP"
      start_ip_address = "203.0.113.5"
      end_ip_address   = "203.0.113.5"
    }
  ]

  databases = [
    { name = "appdb" }
  ]
}
```

### Production Server (VNet Integration + HA)

```hcl
module "postgresql" {
  source = "./Database/PostgreSQLFlexible"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "enterprise"
  environment = "prod"

  # General Purpose for production
  sku_name   = "GP_Standard_D4s_v3"
  storage_mb = 131072  # 128 GB
  version    = "16"

  administrator_login    = "pgadmin"
  administrator_password = var.pg_admin_password

  # Azure AD authentication
  authentication = {
    active_directory_auth_enabled = true
    password_auth_enabled         = true
    tenant_id                     = data.azurerm_client_config.current.tenant_id
  }

  # VNet integration (private access)
  delegated_subnet_id           = azurerm_subnet.postgresql.id
  private_dns_zone_id           = azurerm_private_dns_zone.postgresql.id
  public_network_access_enabled = false

  # Zone-redundant high availability
  high_availability = {
    mode                      = "ZoneRedundant"
    standby_availability_zone = "2"
  }
  zone = "1"

  # Backup configuration
  backup_retention_days        = 35
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  # Maintenance window (Sunday 2:00 AM)
  maintenance_window = {
    day_of_week  = 0
    start_hour   = 2
    start_minute = 0
  }

  databases = [
    { name = "appdb", charset = "UTF8", collation = "en_US.utf8" },
    { name = "analyticsdb" }
  ]

  # Performance tuning
  server_configurations = {
    "shared_buffers"             = "262144"
    "work_mem"                   = "32768"
    "maintenance_work_mem"       = "131072"
    "effective_cache_size"       = "786432"
    "log_min_duration_statement" = "1000"
  }

  identity = {
    type = "SystemAssigned"
  }
}
```

### With Customer-Managed Key

```hcl
module "postgresql" {
  source = "./Database/PostgreSQLFlexible"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "secure"
  environment = "prod"

  sku_name   = "GP_Standard_D4s_v3"
  storage_mb = 131072
  version    = "16"

  administrator_login    = "pgadmin"
  administrator_password = var.pg_admin_password

  delegated_subnet_id           = azurerm_subnet.postgresql.id
  private_dns_zone_id           = azurerm_private_dns_zone.postgresql.id
  public_network_access_enabled = false

  # CMK encryption
  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.postgresql.id]
  }

  customer_managed_key = {
    key_vault_key_id                  = azurerm_key_vault_key.postgresql.id
    primary_user_assigned_identity_id = azurerm_user_assigned_identity.postgresql.id
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
| name | Server name | `string` | `null` | no |
| workload | Workload name | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| version | PostgreSQL version | `string` | `"16"` | no |
| sku_name | SKU name | `string` | `"GP_Standard_D2s_v3"` | no |
| storage_mb | Storage in MB | `number` | `32768` | no |
| administrator_login | Admin username | `string` | `null` | no |
| administrator_password | Admin password | `string` | `null` | no |
| authentication | Auth configuration | `object` | `{}` | no |
| delegated_subnet_id | Subnet for VNet | `string` | `null` | no |
| private_dns_zone_id | Private DNS zone | `string` | `null` | no |
| high_availability | HA configuration | `object` | `null` | no |
| backup_retention_days | Backup retention | `number` | `7` | no |
| databases | Databases to create | `list(object)` | `[]` | no |
| server_configurations | Server parameters | `map(string)` | `{}` | no |
| firewall_rules | Firewall rules | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Server ID |
| name | Server name |
| fqdn | Server FQDN |
| administrator_login | Admin username |
| database_ids | Map of database IDs |
| firewall_rule_ids | Map of firewall rule IDs |

## SKU Reference

| Tier | SKU Examples | Use Case |
|------|--------------|----------|
| Burstable | B_Standard_B1ms, B_Standard_B2s | Dev/Test |
| General Purpose | GP_Standard_D2s_v3, GP_Standard_D4s_v3 | Most workloads |
| Memory Optimized | MO_Standard_E2s_v3, MO_Standard_E4s_v3 | High memory |

## Best Practices

1. **Use VNet integration** for production (private access)
2. **Enable zone-redundant HA** for mission-critical workloads
3. **Configure geo-redundant backup** for disaster recovery
4. **Use Azure AD authentication** where possible
5. **Tune server parameters** for your workload
6. **Set appropriate maintenance windows** to avoid business hours

## Notes

- VNet integration requires subnet delegation to Microsoft.DBforPostgreSQL/flexibleServers
- Private DNS zone must be linked to the VNet
- Zone-redundant HA requires General Purpose or Memory Optimized SKUs
- Storage cannot be decreased once increased

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
| [azurerm_postgresql_flexible_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_postgresql_flexible_server_firewall_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | The administrator login name. Required unless using Azure AD only authentication. | `string` | `null` | no |
| <a name="input_administrator_password"></a> [administrator\_password](#input\_administrator\_password) | The administrator password. Required unless using Azure AD only authentication. | `string` | `null` | no |
| <a name="input_authentication"></a> [authentication](#input\_authentication) | Authentication configuration for the PostgreSQL Flexible Server. | <pre>object({<br/>    active_directory_auth_enabled = optional(bool, false)<br/>    password_auth_enabled         = optional(bool, true)<br/>    tenant_id                     = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_auto_grow_enabled"></a> [auto\_grow\_enabled](#input\_auto\_grow\_enabled) | Whether storage auto-grow is enabled. | `bool` | `true` | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | The backup retention days for the PostgreSQL Flexible Server (7-35 days). | `number` | `7` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | Customer managed key configuration for the PostgreSQL Flexible Server. | <pre>object({<br/>    key_vault_key_id                     = string<br/>    primary_user_assigned_identity_id    = optional(string)<br/>    geo_backup_key_vault_key_id          = optional(string)<br/>    geo_backup_user_assigned_identity_id = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | List of databases to create on the PostgreSQL Flexible Server. | <pre>list(object({<br/>    name      = string<br/>    charset   = optional(string, "UTF8")<br/>    collation = optional(string, "en_US.utf8")<br/>  }))</pre> | `[]` | no |
| <a name="input_delegated_subnet_id"></a> [delegated\_subnet\_id](#input\_delegated\_subnet\_id) | The ID of the subnet for VNet integration. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (dev, staging, prod) for naming convention. | `string` | `""` | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | List of firewall rules for the PostgreSQL Flexible Server. | <pre>list(object({<br/>    name             = string<br/>    start_ip_address = string<br/>    end_ip_address   = string<br/>  }))</pre> | `[]` | no |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled) | Whether geo-redundant backup is enabled. | `bool` | `false` | no |
| <a name="input_high_availability"></a> [high\_availability](#input\_high\_availability) | High availability configuration for the PostgreSQL Flexible Server. | <pre>object({<br/>    mode                      = string<br/>    standby_availability_zone = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Managed identity configuration for the PostgreSQL Flexible Server. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the PostgreSQL Flexible Server will be created. | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Maintenance window configuration for the PostgreSQL Flexible Server. | <pre>object({<br/>    day_of_week  = optional(number, 0)<br/>    start_hour   = optional(number, 0)<br/>    start_minute = optional(number, 0)<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the PostgreSQL Flexible Server. If not provided, will be generated from naming variables. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the PostgreSQL Flexible Server name. | `string` | `"psql"` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | The ID of the private DNS zone for VNet integration. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is enabled. Cannot be true if delegated\_subnet\_id is set. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the PostgreSQL Flexible Server will be created. | `string` | n/a | yes |
| <a name="input_server_configurations"></a> [server\_configurations](#input\_server\_configurations) | Map of server configuration parameters. | `map(string)` | `{}` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name for the PostgreSQL Flexible Server. Examples: B\_Standard\_B1ms, GP\_Standard\_D2s\_v3, MO\_Standard\_E4s\_v3. | `string` | `"GP_Standard_D2s_v3"` | no |
| <a name="input_storage_mb"></a> [storage\_mb](#input\_storage\_mb) | The storage size in MB for the PostgreSQL Flexible Server. | `number` | `32768` | no |
| <a name="input_storage_tier"></a> [storage\_tier](#input\_storage\_tier) | The storage tier. Possible values are P4, P6, P10, P15, P20, P30, P40, P50, P60, P70, P80. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_version"></a> [version](#input\_version) | The version of PostgreSQL. Valid values are 11, 12, 13, 14, 15, and 16. | `string` | `"16"` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name for naming convention. | `string` | `""` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The availability zone for the server. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_administrator_login"></a> [administrator\_login](#output\_administrator\_login) | The administrator login name. |
| <a name="output_database_ids"></a> [database\_ids](#output\_database\_ids) | Map of database names to their IDs. |
| <a name="output_firewall_rule_ids"></a> [firewall\_rule\_ids](#output\_firewall\_rule\_ids) | Map of firewall rule names to their IDs. |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The fully qualified domain name of the PostgreSQL Flexible Server. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the PostgreSQL Flexible Server. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity configuration of the server. |
| <a name="output_name"></a> [name](#output\_name) | The name of the PostgreSQL Flexible Server. |
| <a name="output_public_network_access_enabled"></a> [public\_network\_access\_enabled](#output\_public\_network\_access\_enabled) | Whether public network access is enabled. |
<!-- END_TF_DOCS -->