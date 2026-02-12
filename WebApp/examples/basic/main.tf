# -----------------------------------------------------------------------------
# Basic Linux Web App Example with Node.js
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
# Resource Group
# -----------------------------------------------------------------------------

resource "azurerm_resource_group" "example" {
  name     = "rg-webapp-example"
  location = "East US"
}

# -----------------------------------------------------------------------------
# App Service Plan
# -----------------------------------------------------------------------------

resource "azurerm_service_plan" "example" {
  name                = "asp-webapp-example"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = "Linux"
  sku_name            = "B1"
}

# -----------------------------------------------------------------------------
# Linux Web App with Node.js
# -----------------------------------------------------------------------------

module "webapp" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "app-nodejs-example"
  service_plan_id     = azurerm_service_plan.example.id

  os_type    = "Linux"
  https_only = true

  site_config = {
    always_on           = true
    http2_enabled       = true
    minimum_tls_version = "1.2"

    application_stack = {
      node_version = "18-lts"
    }
  }

  app_settings = {
    "NODE_ENV"                    = "production"
    "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
  }

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
    Project     = "WebApp Example"
  }
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "webapp_id" {
  description = "The ID of the Web App"
  value       = module.webapp.id
}

output "webapp_name" {
  description = "The name of the Web App"
  value       = module.webapp.name
}

output "webapp_default_hostname" {
  description = "The default hostname of the Web App"
  value       = module.webapp.default_hostname
}

output "webapp_identity_principal_id" {
  description = "The principal ID of the Web App's managed identity"
  value       = module.webapp.identity != null ? module.webapp.identity.principal_id : null
}
