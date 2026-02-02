################################################################################
# Basic Example - VNet Peering Module
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
# Resource Groups (DEPENDENCIES)
################################################################################

resource "azurerm_resource_group" "hub" {
  name     = "rg-hub-example-dev-001"
  location = "westeurope"
}

resource "azurerm_resource_group" "spoke" {
  name     = "rg-spoke-example-dev-001"
  location = "westeurope"
}

################################################################################
# Virtual Networks (DEPENDENCIES)
################################################################################

resource "azurerm_virtual_network" "hub" {
  name                = "vnet-hub-dev-001"
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_virtual_network" "spoke" {
  name                = "vnet-spoke-dev-001"
  resource_group_name = azurerm_resource_group.spoke.name
  location            = azurerm_resource_group.spoke.location
  address_space       = ["10.1.0.0/16"]
}

################################################################################
# VNet Peering Module - Hub to Spoke
################################################################################

module "hub_to_spoke_peering" {
  source = "../../"

  resource_group_name       = azurerm_resource_group.hub.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke.id

  allow_forwarded_traffic = true
  allow_gateway_transit   = false
}

################################################################################
# VNet Peering Module - Spoke to Hub
################################################################################

module "spoke_to_hub_peering" {
  source = "../../"

  resource_group_name       = azurerm_resource_group.spoke.name
  virtual_network_name      = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id

  allow_forwarded_traffic = true
  use_remote_gateways     = false
}

################################################################################
# Outputs
################################################################################

output "hub_to_spoke_peering_id" {
  value = module.hub_to_spoke_peering.id
}

output "spoke_to_hub_peering_id" {
  value = module.spoke_to_hub_peering.id
}
