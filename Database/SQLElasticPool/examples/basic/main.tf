################################################################################
# Example: Azure SQL Elastic Pool
# Multi-Tenant SaaS Architecture (Microsoft Best Practice)
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
  name     = "rg-saas-prod-001"
  location = "westeurope"
}

################################################################################
# SQL Server
################################################################################

module "sql_server" {
  source = "../../../SQLServer"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "saas"
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
# Elastic Pool - Production
# Best Practice: Use elastic pools for multi-tenant SaaS
# - Efficient resource sharing between databases
# - Cost-effective for databases with variable usage
# - Zone redundant for high availability
################################################################################

module "elastic_pool" {
  source = "../../"

  server_id           = module.sql_server.id
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "tenants"
  environment = "prod"

  # Business Critical for production SaaS
  sku = {
    name     = "BC_Gen5"
    tier     = "BusinessCritical"
    family   = "Gen5"
    capacity = 8
  }

  max_size_gb    = 500
  zone_redundant = true

  # Per-database settings
  # - min: Reserve minimum resources per tenant
  # - max: Cap per-tenant usage to ensure fair sharing
  per_database_settings = {
    min_capacity = 0
    max_capacity = 4
  }

  # Azure Hybrid Benefit (if you have existing SQL licenses)
  license_type = "LicenseIncluded"

  tags = {
    Environment = "Production"
    Architecture = "Multi-Tenant"
    CostCenter  = "SaaS-Platform"
  }
}

################################################################################
# Tenant Databases (in the elastic pool)
################################################################################

module "tenant_databases" {
  source = "../../../SQLDatabase"

  for_each = {
    "acme-corp"   = { max_gb = 50 }
    "contoso"     = { max_gb = 100 }
    "northwind"   = { max_gb = 75 }
  }

  server_id       = module.sql_server.id
  elastic_pool_id = module.elastic_pool.id

  name = "db-${each.key}"

  max_size_gb = each.value.max_gb

  # Backup configuration (per-database)
  short_term_retention_policy = {
    retention_days = 14
  }

  tags = {
    Tenant = each.key
  }
}

################################################################################
# Outputs
################################################################################

output "elastic_pool_id" {
  value = module.elastic_pool.id
}

output "elastic_pool_name" {
  value = module.elastic_pool.name
}

output "tenant_database_ids" {
  value = { for k, v in module.tenant_databases : k => v.id }
}

output "connection_template" {
  value     = "Server=tcp:${module.sql_server.fully_qualified_domain_name},1433;Database=<tenant-db>;Authentication=Active Directory Default;"
  sensitive = true
}
