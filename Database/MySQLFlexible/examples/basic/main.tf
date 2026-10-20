################################################################################
# Example: Azure Database for MySQL - Flexible Server
# Production Configuration with VNet Integration and HA
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-mysql-prod-001"
  location = "westeurope"
}

################################################################################
# Network Infrastructure (Best Practice: VNet Integration)
################################################################################

resource "azurerm_virtual_network" "example" {
  name                = "vnet-mysql-prod-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "mysql" {
  name                 = "snet-mysql"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]

  # Required delegation for MySQL Flexible Server
  delegation {
    name = "mysql-delegation"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

################################################################################
# Private DNS Zone (Required for VNet Integration)
################################################################################

resource "azurerm_private_dns_zone" "mysql" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysql" {
  name                  = "mysql-vnet-link"
  resource_group_name   = azurerm_resource_group.example.name
  private_dns_zone_name = azurerm_private_dns_zone.mysql.name
  virtual_network_id    = azurerm_virtual_network.example.id
  registration_enabled  = false
}

################################################################################
# Secure Admin Password
################################################################################

resource "random_password" "mysql" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

################################################################################
# MySQL Flexible Server - Production
# Best Practices:
# - VNet integration (private access only)
# - Zone-redundant HA for high availability
# - Geo-redundant backup for disaster recovery
# - SSL/TLS enforcement
# - Optimized server configurations
################################################################################

module "mysql" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "ecommerce"
  environment = "prod"

  # MySQL 8.0 with General Purpose SKU
  version  = "8.0.21"
  sku_name = "GP_Standard_D4ds_v4"

  # Authentication
  administrator_login    = "mysqladmin"
  administrator_password = random_password.mysql.result

  # VNet Integration (private access only)
  delegated_subnet_id           = azurerm_subnet.mysql.id
  private_dns_zone_id           = azurerm_private_dns_zone.mysql.id
  public_network_access_enabled = false

  # Storage configuration
  storage = {
    size_gb            = 256
    auto_grow_enabled  = true
    io_scaling_enabled = true
  }

  # High Availability - Zone Redundant
  zone = "1"
  high_availability = {
    mode                      = "ZoneRedundant"
    standby_availability_zone = "2"
  }

  # Backup - Geo-redundant for DR
  backup_retention_days        = 35
  geo_redundant_backup_enabled = true

  # Maintenance Window (Sunday 3:00 AM)
  maintenance_window = {
    day_of_week  = 0
    start_hour   = 3
    start_minute = 0
  }

  # Create application databases
  databases = [
    {
      name      = "shopdb"
      charset   = "utf8mb4"
      collation = "utf8mb4_unicode_ci"
    },
    {
      name      = "analyticsdb"
      charset   = "utf8mb4"
      collation = "utf8mb4_unicode_ci"
    }
  ]

  # Performance tuning for production
  server_configurations = {
    # InnoDB settings (for 4 vCPU / 16 GB RAM)
    "innodb_buffer_pool_size"  = "12884901888"  # ~12GB
    "innodb_log_file_size"     = "536870912"    # 512MB
    "innodb_flush_log_at_trx_commit" = "1"

    # Connection settings
    "max_connections"          = "500"
    "wait_timeout"             = "300"
    "interactive_timeout"      = "300"

    # Query performance
    "slow_query_log"           = "ON"
    "long_query_time"          = "2"

    # Security
    "require_secure_transport" = "ON"
    "tls_version"              = "TLSv1.2,TLSv1.3"
  }

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
    Compliance  = "Required"
    CostCenter  = "Ecommerce"
  }
}

################################################################################
# Outputs
################################################################################

output "mysql_server_id" {
  value = module.mysql.id
}

output "mysql_fqdn" {
  value = module.mysql.fqdn
}

output "mysql_databases" {
  value = module.mysql.database_ids
}

output "connection_string" {
  description = "MySQL connection string template"
  value       = "Server=${module.mysql.fqdn};Port=3306;Database=shopdb;Uid=mysqladmin;Pwd=<password>;SslMode=Required;"
  sensitive   = true
}

output "admin_password" {
  value     = random_password.mysql.result
  sensitive = true
}
