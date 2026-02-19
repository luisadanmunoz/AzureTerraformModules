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
  name     = "rg-static-web-app-example"
  location = "eastus2"
}

################################################################################
# Static Web App - Free Tier
################################################################################

module "swa_free" {
  source = "../../"

  name                = "swa-free-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku_tier            = "Free"
  sku_size            = "Free"

  tags = {
    Environment = "Example"
    Tier        = "Free"
  }
}

################################################################################
# Static Web App - Standard with Identity
################################################################################

module "swa_standard" {
  source = "../../"

  name                = "swa-standard-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku_tier            = "Standard"
  sku_size            = "Standard"

  app_settings = {
    API_URL     = "https://api.contoso.com"
    ENVIRONMENT = "production"
  }

  identity_type = "SystemAssigned"

  tags = {
    Environment = "Example"
    Tier        = "Standard"
  }
}

################################################################################
# Outputs
################################################################################

output "free_swa_hostname" {
  description = "The hostname of the free Static Web App."
  value       = module.swa_free.default_host_name
}

output "standard_swa_hostname" {
  description = "The hostname of the standard Static Web App."
  value       = module.swa_standard.default_host_name
}

output "standard_swa_principal_id" {
  description = "The principal ID of the standard Static Web App."
  value       = module.swa_standard.principal_id
}
