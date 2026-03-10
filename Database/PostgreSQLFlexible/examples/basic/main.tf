################################################################################
# Example: Azure Database for PostgreSQL - Flexible Server
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

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "rg-postgresql-prod-001"
  location = "westeurope"
}

################################################################################
# Network Infrastructure (Best Practice: VNet Integration)
################################################################################

resource "azurerm_virtual_network" "example" {
  name                = "vnet-postgresql-prod-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "postgresql" {
  name                 = "snet-postgresql"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]

  # Required delegation for PostgreSQL Flexible Server
  delegation {
    name = "postgresql-delegation"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_subnet" "app" {
  name                 = "snet-app"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

################################################################################
# Private DNS Zone (Required for VNet Integration)
################################################################################

resource "azurerm_private_dns_zone" "postgresql" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgresql" {
  name                  = "postgresql-vnet-link"
  resource_group_name   = azurerm_resource_group.example.name
  private_dns_zone_name = azurerm_private_dns_zone.postgresql.name
  virtual_network_id    = azurerm_virtual_network.example.id
  registration_enabled  = false
}

################################################################################
# Secure Admin Password
################################################################################

resource "random_password" "postgresql" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

################################################################################
# PostgreSQL Flexible Server - Production
# Best Practices:
# - VNet integration (private access only)
# - Zone-redundant HA
# - Geo-redundant backup
# - Azure AD authentication enabled
# - Performance tuning for production
################################################################################

module "postgresql" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "myapp"
  environment = "prod"

  # PostgreSQL 16 with General Purpose SKU
  version    = "16"
  sku_name   = "GP_Standard_D4s_v3"
  storage_mb = 131072  # 128 GB

  # Authentication
  administrator_login    = "pgadmin"
  administrator_password = random_password.postgresql.result

  authentication = {
    active_directory_auth_enabled = true
    password_auth_enabled         = true
    tenant_id                     = data.azurerm_client_config.current.tenant_id
  }

  # VNet Integration (private access)
  delegated_subnet_id           = azurerm_subnet.postgresql.id
  private_dns_zone_id           = azurerm_private_dns_zone.postgresql.id
  public_network_access_enabled = false

  # High Availability - Zone Redundant
  zone = "1"
  high_availability = {
    mode                      = "ZoneRedundant"
    standby_availability_zone = "2"
  }

  # Backup - Geo-redundant for DR
  backup_retention_days        = 35
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  # Maintenance Window (Sunday 2:00 AM)
  maintenance_window = {
    day_of_week  = 0
    start_hour   = 2
    start_minute = 0
  }

  # Create application databases
  databases = [
    {
      name      = "appdb"
      charset   = "UTF8"
      collation = "en_US.utf8"
    },
    {
      name      = "analyticsdb"
      charset   = "UTF8"
      collation = "en_US.utf8"
    }
  ]

  # Performance tuning for production
  server_configurations = {
    # Memory settings (for 4 vCPU / 16 GB RAM)
    "shared_buffers"       = "262144"   # ~4GB
    "work_mem"             = "32768"    # 32MB
    "maintenance_work_mem" = "131072"   # 128MB
    "effective_cache_size" = "786432"   # ~12GB

    # Logging
    "log_min_duration_statement" = "1000"  # Log queries > 1 second
    "log_connections"            = "on"
    "log_disconnections"         = "on"

    # Performance
    "random_page_cost"          = "1.1"
    "effective_io_concurrency"  = "200"
  }

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
    Compliance  = "Required"
  }
}

################################################################################
# Outputs
################################################################################

output "postgresql_server_id" {
  value = module.postgresql.id
}

output "postgresql_fqdn" {
  value = module.postgresql.fqdn
}

output "postgresql_databases" {
  value = module.postgresql.database_ids
}

output "connection_string" {
  description = "PostgreSQL connection string template"
  value       = "host=${module.postgresql.fqdn} port=5432 dbname=appdb user=pgadmin sslmode=require"
  sensitive   = true
}

output "admin_password" {
  value     = random_password.postgresql.result
  sensitive = true
}
