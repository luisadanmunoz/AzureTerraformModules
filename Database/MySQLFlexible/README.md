# MySQL Flexible Server

Terraform module for Azure Database for MySQL - Flexible Server.

## Features

- Flexible Server with various SKU tiers (Burstable, General Purpose, Business Critical)
- High availability with same-zone or zone-redundant configuration
- VNet integration with private access
- Customer-managed key encryption
- Automated backups with geo-redundancy option
- Database and firewall rule management
- Server configuration parameters

## Usage

### Basic MySQL Server

```hcl
module "mysql" {
  source = "./Database/MySQLFlexible"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "myapp"
  environment = "dev"

  administrator_login    = "mysqladmin"
  administrator_password = var.mysql_password

  storage = {
    size_gb           = 32
    auto_grow_enabled = true
  }
}
```

### Production with HA and VNet

```hcl
module "mysql" {
  source = "./Database/MySQLFlexible"

  resource_group_name = azurerm_resource_group.main.name
  location            = "westeurope"

  workload    = "ecommerce"
  environment = "prod"

  version   = "8.0.21"
  sku_name  = "GP_Standard_D4ds_v4"

  administrator_login    = "mysqladmin"
  administrator_password = var.mysql_password

  # VNet integration
  delegated_subnet_id           = azurerm_subnet.mysql.id
  private_dns_zone_id           = azurerm_private_dns_zone.mysql.id
  public_network_access_enabled = false

  # High availability
  zone = "1"
  high_availability = {
    mode                      = "ZoneRedundant"
    standby_availability_zone = "2"
  }

  # Storage
  storage = {
    size_gb           = 256
    auto_grow_enabled = true
    iops              = 2000
  }

  # Backup
  backup_retention_days        = 35
  geo_redundant_backup_enabled = true

  # Maintenance window
  maintenance_window = {
    day_of_week  = 0  # Sunday
    start_hour   = 3
    start_minute = 0
  }

  # Databases
  databases = [
    {
      name      = "appdb"
      charset   = "utf8mb4"
      collation = "utf8mb4_unicode_ci"
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
| administrator_password | Admin password | `string` | n/a | yes |
| name | Server name (overrides generated) | `string` | `null` | no |
| workload | Workload name for naming | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| version | MySQL version | `string` | `"8.0.21"` | no |
| sku_name | SKU name | `string` | `"GP_Standard_D2ds_v4"` | no |
| administrator_login | Admin username | `string` | `"mysqladmin"` | no |
| storage | Storage configuration | `object` | See variables.tf | no |
| high_availability | HA configuration | `object` | `null` | no |
| delegated_subnet_id | Subnet ID for VNet integration | `string` | `null` | no |
| private_dns_zone_id | Private DNS zone ID | `string` | `null` | no |
| backup_retention_days | Backup retention (1-35) | `number` | `7` | no |
| geo_redundant_backup_enabled | Enable geo-redundant backup | `bool` | `false` | no |
| databases | List of databases to create | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | MySQL Flexible Server ID |
| name | Server name |
| fqdn | Fully qualified domain name |
| principal_id | System assigned identity principal ID |
| database_ids | Map of database IDs |

## SKU Tiers

| Tier | Use Case | vCores | Memory |
|------|----------|--------|--------|
| Burstable | Dev/Test | 1-20 | 1-80 GB |
| General Purpose | Production | 2-64 | 8-256 GB |
| Business Critical | Mission-critical | 2-64 | 16-256 GB |

## Notes

- VNet integration requires a dedicated subnet with proper delegation
- Geo-redundant backup requires General Purpose or Business Critical SKU
- Zone-redundant HA requires General Purpose or Business Critical SKU

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
| [azurerm_mysql_flexible_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_database) | resource |
| [azurerm_mysql_flexible_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server) | resource |
| [azurerm_mysql_flexible_server_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_configuration) | resource |
| [azurerm_mysql_flexible_server_firewall_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_firewall_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | The administrator login name for the MySQL Flexible Server. | `string` | `"mysqladmin"` | no |
| <a name="input_administrator_password"></a> [administrator\_password](#input\_administrator\_password) | The administrator password for the MySQL Flexible Server. | `string` | n/a | yes |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | The backup retention days for the MySQL Flexible Server (1-35 days). | `number` | `7` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | Customer managed key configuration for the MySQL Flexible Server. | <pre>object({<br/>    key_vault_key_id                     = string<br/>    primary_user_assigned_identity_id    = optional(string)<br/>    geo_backup_key_vault_key_id          = optional(string)<br/>    geo_backup_user_assigned_identity_id = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | List of databases to create on the MySQL Flexible Server. | <pre>list(object({<br/>    name      = string<br/>    charset   = optional(string, "utf8mb4")<br/>    collation = optional(string, "utf8mb4_unicode_ci")<br/>  }))</pre> | `[]` | no |
| <a name="input_delegated_subnet_id"></a> [delegated\_subnet\_id](#input\_delegated\_subnet\_id) | The ID of the subnet to which the MySQL Flexible Server should be connected. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (dev, staging, prod) for naming convention. | `string` | `""` | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | List of firewall rules for the MySQL Flexible Server. | <pre>list(object({<br/>    name             = string<br/>    start_ip_address = string<br/>    end_ip_address   = string<br/>  }))</pre> | `[]` | no |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled) | Enable geo-redundant backup for the MySQL Flexible Server. | `bool` | `false` | no |
| <a name="input_high_availability"></a> [high\_availability](#input\_high\_availability) | High availability configuration for the MySQL Flexible Server. | <pre>object({<br/>    mode                      = string<br/>    standby_availability_zone = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Managed identity configuration for the MySQL Flexible Server. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the MySQL Flexible Server will be created. | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Maintenance window configuration for the MySQL Flexible Server. | <pre>object({<br/>    day_of_week  = number<br/>    start_hour   = number<br/>    start_minute = number<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the MySQL Flexible Server. If not provided, will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the MySQL Flexible Server name. | `string` | `"mysql"` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | The ID of the Private DNS Zone to create DNS records. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is enabled for the MySQL Flexible Server. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the MySQL Flexible Server will be created. | `string` | n/a | yes |
| <a name="input_server_configurations"></a> [server\_configurations](#input\_server\_configurations) | Map of server configuration parameters. | `map(string)` | `{}` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name for the MySQL Flexible Server. | `string` | `"GP_Standard_D2ds_v4"` | no |
| <a name="input_storage"></a> [storage](#input\_storage) | Storage configuration for the MySQL Flexible Server. | <pre>object({<br/>    auto_grow_enabled  = optional(bool, true)<br/>    io_scaling_enabled = optional(bool, false)<br/>    iops               = optional(number)<br/>    size_gb            = optional(number, 20)<br/>  })</pre> | <pre>{<br/>  "auto_grow_enabled": true,<br/>  "size_gb": 20<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_version"></a> [version](#input\_version) | The version of MySQL to use. Possible values are 5.7 and 8.0.21. | `string` | `"8.0.21"` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name for naming convention. | `string` | `""` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The availability zone for the MySQL Flexible Server. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_database_ids"></a> [database\_ids](#output\_database\_ids) | Map of database names to their IDs. |
| <a name="output_firewall_rule_ids"></a> [firewall\_rule\_ids](#output\_firewall\_rule\_ids) | Map of firewall rule names to their IDs. |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The FQDN of the MySQL Flexible Server. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the MySQL Flexible Server. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity configuration of the MySQL Flexible Server. |
| <a name="output_name"></a> [name](#output\_name) | The name of the MySQL Flexible Server. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID of the System Assigned Managed Identity. |
| <a name="output_public_network_access_enabled"></a> [public\_network\_access\_enabled](#output\_public\_network\_access\_enabled) | Whether public network access is enabled. |
| <a name="output_replica_capacity"></a> [replica\_capacity](#output\_replica\_capacity) | The maximum number of replicas that a primary MySQL Flexible Server can have. |
<!-- END_TF_DOCS -->