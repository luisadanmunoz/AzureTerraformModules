################################################################################
# Example: Azure Relay Hybrid Connection
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

resource "azurerm_resource_group" "relay" {
  name     = "rg-relay"
  location = "westeurope"
}

resource "azurerm_relay_namespace" "example" {
  name                = "relay-prod-001"
  resource_group_name = azurerm_resource_group.relay.name
  location            = azurerm_resource_group.relay.location
  sku_name            = "Standard"
}

################################################################################
# Hybrid Connection for Database
################################################################################

module "hc_database" {
  source = "../../"

  name                 = "hc-sqlserver"
  resource_group_name  = azurerm_resource_group.relay.name
  relay_namespace_name = azurerm_relay_namespace.example.name

  user_metadata                 = "sqlserver.internal.corp:1433"
  requires_client_authorization = true
}

################################################################################
# Hybrid Connection for API
################################################################################

module "hc_api" {
  source = "../../"

  name                 = "hc-internalapi"
  resource_group_name  = azurerm_resource_group.relay.name
  relay_namespace_name = azurerm_relay_namespace.example.name

  user_metadata                 = "api.internal.corp:8080"
  requires_client_authorization = true
}

################################################################################
# Outputs
################################################################################

output "database_hc_id" {
  value = module.hc_database.id
}

output "api_hc_id" {
  value = module.hc_api.id
}
