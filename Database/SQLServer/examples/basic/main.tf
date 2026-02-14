################################################################################
# Example: Azure SQL Server
# Following Microsoft Security Best Practices
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "rg-sql-prod-001"
  location = "westeurope"
}

################################################################################
# Network Infrastructure (Best Practice: VNet Integration)
################################################################################

resource "azurerm_virtual_network" "example" {
  name                = "vnet-sql-prod-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "app" {
  name                 = "snet-app"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.Sql"]
}

resource "azurerm_subnet" "data" {
  name                 = "snet-data"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql"]
}

################################################################################
# Audit Storage (Best Practice: Enable Auditing)
################################################################################

resource "azurerm_storage_account" "audit" {
  name                     = "staudit${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  # Security best practices
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

################################################################################
# SQL Server - Production Configuration
# Following Microsoft Security Best Practices:
# - Azure AD authentication enabled
# - TLS 1.2 enforced
# - VNet integration (service endpoints)
# - Auditing enabled
# - Threat detection enabled
################################################################################

module "sql_server" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "myapp"
  environment = "prod"

  # Authentication: SQL + Azure AD (for migration scenarios)
  # For greenfield: use azuread_authentication_only = true
  administrator_login          = "sqladmin"
  administrator_login_password = "P@ssw0rd!Change-This-In-Production"

  azuread_administrator = {
    login_username = "sql-admins@example.com"
    object_id      = data.azurerm_client_config.current.object_id
  }

  # Security: TLS 1.2 and restricted access
  minimum_tls_version           = "1.2"
  public_network_access_enabled = true  # Required for VNet rules

  # Network security: VNet integration
  virtual_network_rules = [
    {
      name      = "app-subnet"
      subnet_id = azurerm_subnet.app.id
    },
    {
      name      = "data-subnet"
      subnet_id = azurerm_subnet.data.id
    }
  ]

  # Compliance: Extended auditing
  extended_auditing_policy = {
    enabled                    = true
    retention_in_days          = 90
    log_monitoring_enabled     = true
    storage_endpoint           = azurerm_storage_account.audit.primary_blob_endpoint
    storage_account_access_key = azurerm_storage_account.audit.primary_access_key
  }

  # Security: Threat detection
  security_alert_policy = {
    state                = "Enabled"
    email_account_admins = true
    retention_days       = 30
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

output "server_id" {
  value = module.sql_server.id
}

output "server_fqdn" {
  value = module.sql_server.fully_qualified_domain_name
}

output "connection_string" {
  description = "ADO.NET connection string template"
  value       = "Server=tcp:${module.sql_server.fully_qualified_domain_name},1433;Authentication=Active Directory Default;"
  sensitive   = true
}
