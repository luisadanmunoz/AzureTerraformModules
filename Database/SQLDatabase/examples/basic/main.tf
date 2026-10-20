################################################################################
# Example: Azure SQL Database
# Following Microsoft Best Practices for Production Workloads
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "rg-sqldb-prod-001"
  location = "westeurope"
}

################################################################################
# SQL Server (using our SQLServer module)
################################################################################

module "sql_server" {
  source = "../../../SQLServer"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "myapp"
  environment = "prod"

  administrator_login          = "sqladmin"
  administrator_login_password = "P@ssw0rd!Change-In-Production"

  azuread_administrator = {
    login_username = "sql-admin@example.com"
    object_id      = data.azurerm_client_config.current.object_id
  }

  minimum_tls_version           = "1.2"
  public_network_access_enabled = false

  identity = {
    type = "SystemAssigned"
  }
}

################################################################################
# Production Database - Business Critical
# Best Practices:
# - Zone redundancy for HA
# - Read replicas for read scale-out
# - Long-term backup retention for compliance
# - Threat detection enabled
################################################################################

module "production_database" {
  source = "../../"

  server_id = module.sql_server.id

  workload    = "orders"
  environment = "prod"

  # Business Critical for mission-critical workloads
  sku_name       = "BC_Gen5_4"
  max_size_gb    = 256
  zone_redundant = true
  read_scale     = true

  # Backup retention for compliance
  short_term_retention_policy = {
    retention_days           = 35
    backup_interval_in_hours = 12
  }

  long_term_retention_policy = {
    weekly_retention  = "P4W"
    monthly_retention = "P12M"
    yearly_retention  = "P7Y"
    week_of_year      = 1
  }

  # Geo-redundant backup
  storage_account_type = "Geo"
  geo_backup_enabled   = true

  # Threat detection
  threat_detection_policy = {
    state                = "Enabled"
    email_account_admins = "Enabled"
    retention_days       = 90
  }

  tags = {
    Environment  = "Production"
    CostCenter   = "IT"
    DataClass    = "Confidential"
  }
}

################################################################################
# Serverless Database - Dev/Test (Cost-Optimized)
# Best Practices:
# - Auto-pause to reduce costs
# - Local backup for non-critical data
################################################################################

module "dev_database" {
  source = "../../"

  server_id = module.sql_server.id

  workload    = "orders"
  environment = "dev"

  # Serverless for cost efficiency
  sku_name                    = "GP_S_Gen5_2"
  max_size_gb                 = 32
  auto_pause_delay_in_minutes = 60
  min_capacity                = 0.5

  # Cost-effective backup for dev
  storage_account_type = "Local"
  geo_backup_enabled   = false

  short_term_retention_policy = {
    retention_days = 7
  }

  tags = {
    Environment = "Development"
  }
}

################################################################################
# Outputs
################################################################################

output "production_database_id" {
  value = module.production_database.id
}

output "production_database_name" {
  value = module.production_database.name
}

output "dev_database_id" {
  value = module.dev_database.id
}

output "connection_string_template" {
  description = "Connection string template (add database name)"
  value       = "Server=tcp:${module.sql_server.fully_qualified_domain_name},1433;Database=${module.production_database.name};Authentication=Active Directory Default;Encrypt=True;TrustServerCertificate=False;"
  sensitive   = true
}
