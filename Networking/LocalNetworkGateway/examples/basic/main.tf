################################################################################
# Basic Example - Local Network Gateway Module
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
  name     = "rg-lgw-example-dev-001"
  location = "westeurope"
}

module "local_network_gateway" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  gateway_address     = "203.0.113.1"

  address_space = [
    "10.1.0.0/16",
    "10.2.0.0/16"
  ]

  bgp_settings = {
    asn                 = 65010
    bgp_peering_address = "10.1.0.1"
    peer_weight         = 0
  }

  tags = {
    Environment = "Development"
  }
}

output "local_network_gateway_id" {
  value = module.local_network_gateway.id
}

output "local_network_gateway_name" {
  value = module.local_network_gateway.name
}
