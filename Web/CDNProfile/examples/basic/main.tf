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
  name     = "rg-cdn-profile-example"
  location = "eastus"
}

################################################################################
# CDN Profile - Microsoft Standard
################################################################################

module "cdn_microsoft" {
  source = "../../"

  name                = "cdn-microsoft-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard_Microsoft"

  tags = {
    Environment = "Example"
    Provider    = "Microsoft"
  }
}

################################################################################
# CDN Profile - Verizon Premium
################################################################################

module "cdn_verizon" {
  source = "../../"

  name                = "cdn-verizon-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Premium_Verizon"

  tags = {
    Environment = "Example"
    Provider    = "Verizon"
  }
}

################################################################################
# Outputs
################################################################################

output "microsoft_cdn_id" {
  description = "The ID of the Microsoft CDN profile."
  value       = module.cdn_microsoft.id
}

output "verizon_cdn_id" {
  description = "The ID of the Verizon CDN profile."
  value       = module.cdn_verizon.id
}
