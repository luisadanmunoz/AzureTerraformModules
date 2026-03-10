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
