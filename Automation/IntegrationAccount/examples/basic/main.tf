################################################################################
# Basic Example - Integration Account Module
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

resource "azurerm_resource_group" "example" {
  name     = "rg-integration-example-dev-001"
  location = "westeurope"
}

################################################################################
# Integration Account
################################################################################

module "integration_account" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "intacc-b2b-example-dev-001"
  sku_name            = "Basic"

  tags = {
    Environment = "Development"
    Purpose     = "B2B Integration"
  }
}

################################################################################
# Link Integration Account to Logic App (Consumption)
################################################################################

resource "azurerm_logic_app_workflow" "example" {
  name                             = "logic-b2b-process-dev-001"
  location                         = azurerm_resource_group.example.location
  resource_group_name              = azurerm_resource_group.example.name
  logic_app_integration_account_id = module.integration_account.id

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

################################################################################
# Outputs
################################################################################

output "integration_account_id" {
  value = module.integration_account.id
}

output "integration_account_name" {
  value = module.integration_account.name
}

output "logic_app_id" {
  value = azurerm_logic_app_workflow.example.id
}
