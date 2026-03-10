################################################################################
# Example: Basic Function App
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

# ──────────────────────────────────────────────────────────────────────────────
# Resource Group
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_resource_group" "example" {
  name     = "rg-functions-dev-001"
  location = "westeurope"
}

# ──────────────────────────────────────────────────────────────────────────────
# Storage Account (Required for Function App)
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_storage_account" "example" {
  name                     = "stfuncdev001"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# ──────────────────────────────────────────────────────────────────────────────
# App Service Plan (Consumption)
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_service_plan" "example" {
  name                = "asp-functions-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = "Linux"
  sku_name            = "Y1" # Consumption plan
}

# ──────────────────────────────────────────────────────────────────────────────
# Application Insights
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_application_insights" "example" {
  name                = "appi-functions-dev-001"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  application_type    = "other"
}

# ──────────────────────────────────────────────────────────────────────────────
# Function App Module - Linux Python
# ──────────────────────────────────────────────────────────────────────────────

module "function_app" {
  source = "../../"

  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  name                       = "func-api-dev-001"
  os_type                    = "Linux"
  service_plan_id            = azurerm_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key

  # Consumption plan requires always_on = false
  site_config = {
    always_on = false
    application_stack = {
      python_version = "3.11"
    }
    application_insights_connection_string = azurerm_application_insights.example.connection_string
  }

  identity = {
    type = "SystemAssigned"
  }

  app_settings = {
    "CUSTOM_SETTING" = "value"
  }

  tags = {
    Environment = "Development"
    Purpose     = "API"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "function_app_id" {
  description = "The ID of the Function App"
  value       = module.function_app.id
}

output "function_app_name" {
  description = "The name of the Function App"
  value       = module.function_app.name
}

output "function_app_hostname" {
  description = "The default hostname of the Function App"
  value       = module.function_app.default_hostname
}

output "function_app_principal_id" {
  description = "The Principal ID of the Function App's System Assigned Identity"
  value       = module.function_app.principal_id
}
