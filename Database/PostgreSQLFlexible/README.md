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
