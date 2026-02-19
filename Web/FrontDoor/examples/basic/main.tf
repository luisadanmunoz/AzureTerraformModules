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
  name     = "rg-front-door-example"
  location = "eastus"
}

################################################################################
# Front Door - Standard
################################################################################

module "front_door_standard" {
  source = "../../"

  name                = "afd-standard-example"
  resource_group_name = azurerm_resource_group.main.name
  sku_name            = "Standard_AzureFrontDoor"

  tags = {
    Environment = "Example"
    Tier        = "Standard"
  }
}

################################################################################
# Front Door - Premium
################################################################################

module "front_door_premium" {
  source = "../../"

  name                     = "afd-premium-example"
  resource_group_name      = azurerm_resource_group.main.name
  sku_name                 = "Premium_AzureFrontDoor"
  response_timeout_seconds = 60

  tags = {
    Environment = "Example"
    Tier        = "Premium"
  }
}

################################################################################
# Outputs
################################################################################

output "standard_front_door_id" {
  description = "The ID of the standard Front Door."
  value       = module.front_door_standard.id
}

output "premium_front_door_id" {
  description = "The ID of the premium Front Door."
  value       = module.front_door_premium.id
}
