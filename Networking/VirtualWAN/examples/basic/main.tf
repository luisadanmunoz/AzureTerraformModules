################################################################################
# Basic Example - Virtual WAN Module
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
  name     = "rg-vwan-example-dev-001"
  location = "westeurope"
}

module "virtual_wan" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name = "vwan-hub-dev-001"
  type = "Standard"

  allow_branch_to_branch_traffic = true

  virtual_hubs = [
    {
      name           = "vhub-westeurope-dev-001"
      location       = azurerm_resource_group.example.location
      address_prefix = "10.0.0.0/23"
    }
  ]

  tags = {
    Environment = "Development"
  }
}

output "virtual_wan_id" {
  value = module.virtual_wan.id
}

output "virtual_wan_name" {
  value = module.virtual_wan.name
}

output "virtual_hub_ids" {
  value = module.virtual_wan.virtual_hub_ids
}
