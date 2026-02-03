################################################################################
# Basic Example - ExpressRoute Circuit Module
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
  name     = "rg-expressroute-example-dev-001"
  location = "westeurope"
}

module "expressroute" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name                  = "erc-hub-dev-001"
  service_provider_name = "Equinix"
  peering_location      = "Amsterdam"
  bandwidth_in_mbps     = 50

  sku_tier   = "Standard"
  sku_family = "MeteredData"

  tags = {
    Environment = "Development"
  }
}

output "expressroute_circuit_id" {
  value = module.expressroute.id
}

output "expressroute_circuit_name" {
  value = module.expressroute.name
}

output "expressroute_service_key" {
  value     = module.expressroute.service_key
  sensitive = true
}

output "expressroute_provisioning_state" {
  value = module.expressroute.service_provider_provisioning_state
}
