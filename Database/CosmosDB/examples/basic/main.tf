# -----------------------------------------------------------------------------
# BASIC COSMOS DB ACCOUNT EXAMPLE
# This example creates a single-region Cosmos DB account with SQL API
# and Session consistency level
# -----------------------------------------------------------------------------

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

# -----------------------------------------------------------------------------
# RESOURCE GROUP
# -----------------------------------------------------------------------------

resource "azurerm_resource_group" "example" {
  name     = "rg-cosmosdb-example"
  location = "eastus"

  tags = {
    Environment = "Example"
    Purpose     = "CosmosDB Module Demo"
  }
}

# -----------------------------------------------------------------------------
# COSMOS DB ACCOUNT
# Creates a basic SQL API Cosmos DB account with Session consistency
# -----------------------------------------------------------------------------

module "cosmosdb" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Naming
  name_prefix = "cosmos"
  workload    = "myapp"
  environment = "dev"
  instance    = "001"

  # SQL API (GlobalDocumentDB) with Session consistency
  kind       = "GlobalDocumentDB"
  offer_type = "Standard"

  consistency_policy = {
    consistency_level = "Session"
  }

  # Single region deployment
  geo_locations = [
    {
      location          = azurerm_resource_group.example.location
      failover_priority = 0
      zone_redundant    = false
    }
  ]

  tags = {
    Environment = "Development"
    Application = "MyApp"
    CostCenter  = "IT"
  }
}

# -----------------------------------------------------------------------------
# OUTPUTS
# -----------------------------------------------------------------------------

output "cosmosdb_id" {
  description = "The ID of the Cosmos DB Account"
  value       = module.cosmosdb.id
}

output "cosmosdb_name" {
  description = "The name of the Cosmos DB Account"
  value       = module.cosmosdb.name
}

output "cosmosdb_endpoint" {
  description = "The endpoint of the Cosmos DB Account"
  value       = module.cosmosdb.endpoint
}

output "cosmosdb_primary_key" {
  description = "The primary key of the Cosmos DB Account"
  value       = module.cosmosdb.primary_key
  sensitive   = true
}
