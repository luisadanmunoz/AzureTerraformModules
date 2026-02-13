################################################################################
# Basic Example - Logic App Standard Module
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
  name     = "rg-logicstd-example-dev-001"
  location = "westeurope"
}

################################################################################
# Storage Account for Logic App
################################################################################

resource "azurerm_storage_account" "example" {
  name                     = "stlogicstdexample001"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

################################################################################
# App Service Plan (Workflow Standard)
################################################################################

resource "azurerm_service_plan" "example" {
  name                = "asp-logicstd-example-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = "Windows"
  sku_name            = "WS1" # Workflow Standard
}

################################################################################
# Logic App Standard
################################################################################

module "logic_app_standard" {
  source = "../../"

  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  name                       = "logic-std-example-dev-001"
  app_service_plan_id        = azurerm_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key

  identity = {
    type = "SystemAssigned"
  }

  site_config = {
    always_on     = true
    http2_enabled = true
    ftps_state    = "Disabled"
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"     = "node"
    "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
  }

  tags = {
    Environment = "Development"
  }
}

################################################################################
# Outputs
################################################################################

output "logic_app_id" {
  value = module.logic_app_standard.id
}

output "logic_app_hostname" {
  value = module.logic_app_standard.default_hostname
}

output "logic_app_principal_id" {
  value = module.logic_app_standard.principal_id
}
