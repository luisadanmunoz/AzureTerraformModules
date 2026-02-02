################################################################################
# Basic Example - VPN Gateway Module
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
  name     = "rg-vpngw-example-dev-001"
  location = "westeurope"
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet-hub-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

# GatewaySubnet must be named exactly "GatewaySubnet"
resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.255.0/27"]
}

module "vpn_gateway" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  subnet_id           = azurerm_subnet.gateway.id

  name       = "vpngw-hub-dev-001"
  sku        = "VpnGw1AZ"
  generation = "Generation1"

  enable_bgp = true
  bgp_settings = {
    asn = 65515
  }

  tags = {
    Environment = "Development"
  }
}

output "vpn_gateway_id" {
  value = module.vpn_gateway.id
}

output "vpn_gateway_public_ip" {
  value = module.vpn_gateway.public_ip_address
}
