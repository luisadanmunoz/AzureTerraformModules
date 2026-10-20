################################################################################
# Provider Configuration
################################################################################

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

################################################################################
# Resource Group
################################################################################

resource "azurerm_resource_group" "main" {
  name     = "rg-migration-project-example"
  location = "eastus"
}

################################################################################
# Virtual Network and Subnet
################################################################################

resource "azurerm_virtual_network" "main" {
  name                = "vnet-migration-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "dms" {
  name                 = "snet-dms"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

################################################################################
# Database Migration Service
################################################################################

module "dms" {
  source = "../../../DatabaseMigrationService"

  name                = "dms-project-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  subnet_id           = azurerm_subnet.dms.id
  sku_name            = "Standard_1vCores"

  tags = {
    Environment = "Example"
  }
}

################################################################################
# Migration Projects
################################################################################

module "project_sql" {
  source = "../../"

  name                = "migrate-sql-to-azure"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  service_name        = module.dms.name
  source_platform     = "SQL"
  target_platform     = "SQLDB"

  tags = {
    Environment = "Example"
    Migration   = "SQLtoAzureSQL"
  }

  depends_on = [module.dms]
}

module "project_postgres" {
  source = "../../"

  name                = "migrate-postgres-to-azure"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  service_name        = module.dms.name
  source_platform     = "PostgreSql"
  target_platform     = "AzureDbForPostgreSql"

  tags = {
    Environment = "Example"
    Migration   = "PostgreSQLtoAzure"
  }

  depends_on = [module.dms]
}

################################################################################
# Outputs
################################################################################

output "sql_project_id" {
  description = "The ID of the SQL migration project."
  value       = module.project_sql.id
}

output "postgres_project_id" {
  description = "The ID of the PostgreSQL migration project."
  value       = module.project_postgres.id
}
