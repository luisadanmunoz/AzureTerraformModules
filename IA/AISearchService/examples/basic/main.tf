################################################################################
# Example: Azure AI Search Service
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

resource "azurerm_resource_group" "ai" {
  name     = "rg-search"
  location = "westeurope"
}

################################################################################
# Basic Search Service
################################################################################

module "search_basic" {
  source = "../../"

  name                = "search-dev-001"
  resource_group_name = azurerm_resource_group.ai.name
  location            = azurerm_resource_group.ai.location
  sku                 = "basic"

  tags = {
    Environment = "Development"
  }
}

################################################################################
# Production Search Service with Semantic Search
################################################################################

module "search_prod" {
  source = "../../"

  name                = "search-prod-001"
  resource_group_name = azurerm_resource_group.ai.name
  location            = azurerm_resource_group.ai.location
  sku                 = "standard"

  replica_count   = 2
  partition_count = 1

  semantic_search_sku = "standard"
  identity_type       = "SystemAssigned"

  tags = {
    Environment = "Production"
    Purpose     = "RAG"
  }
}

################################################################################
# Outputs
################################################################################

output "dev_search_id" {
  value = module.search_basic.id
}

output "prod_search_id" {
  value = module.search_prod.id
}

output "prod_search_principal_id" {
  value = module.search_prod.principal_id
}
