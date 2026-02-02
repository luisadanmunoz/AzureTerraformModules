################################################################################
# Basic Example - DDoS Protection Plan Module
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
  name     = "rg-ddos-example-dev-001"
  location = "westeurope"
}

module "ddos_plan" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name = "ddos-shared-dev-001"

  tags = {
    Environment = "Development"
  }
}

# Example: VNet with DDoS Protection enabled
resource "azurerm_virtual_network" "protected" {
  name                = "vnet-protected-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]

  ddos_protection_plan {
    id     = module.ddos_plan.id
    enable = true
  }
}

output "ddos_plan_id" {
  value = module.ddos_plan.id
}
