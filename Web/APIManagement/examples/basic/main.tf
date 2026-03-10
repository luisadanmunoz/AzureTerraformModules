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
  name     = "rg-apim-example"
  location = "eastus"
}

################################################################################
# API Management - Developer
################################################################################

module "apim_developer" {
  source = "../../"

  name                = "apim-developer-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  publisher_name      = "Contoso"
  publisher_email     = "api-admin@contoso.com"
  sku_name            = "Developer_1"

  identity_type = "SystemAssigned"

  protocols = {
    enable_http2 = true
  }

  tags = {
    Environment = "Example"
    Tier        = "Developer"
  }
}

################################################################################
# API Management - Consumption
################################################################################

module "apim_consumption" {
  source = "../../"

  name                = "apim-consumption-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  publisher_name      = "Contoso"
  publisher_email     = "api-admin@contoso.com"
  sku_name            = "Consumption_0"

  tags = {
    Environment = "Example"
    Tier        = "Consumption"
  }
}

################################################################################
# Outputs
################################################################################

output "developer_apim_gateway_url" {
  description = "The gateway URL of the developer APIM."
  value       = module.apim_developer.gateway_url
}

output "developer_apim_portal_url" {
  description = "The developer portal URL."
  value       = module.apim_developer.developer_portal_url
}

output "consumption_apim_id" {
  description = "The ID of the consumption APIM."
  value       = module.apim_consumption.id
}
