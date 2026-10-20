################################################################################
# Basic Example - VPN Connection Module (Site-to-Site)
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
  name     = "rg-vpnconn-example-dev-001"
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

resource "azurerm_public_ip" "example" {
  name                = "pip-vpngw-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_virtual_network_gateway" "example" {
  name                = "vpngw-hub-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = "VpnGw1AZ"

  ip_configuration {
    name                          = "ipconfig-primary"
    public_ip_address_id          = azurerm_public_ip.example.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway.id
  }
}

resource "azurerm_local_network_gateway" "onprem" {
  name                = "lgw-onprem-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  gateway_address     = "203.0.113.1"
  address_space       = ["192.168.0.0/16"]
}

module "vpn_connection" {
  source = "../../"

  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  virtual_network_gateway_id = azurerm_virtual_network_gateway.example.id
  local_network_gateway_id   = azurerm_local_network_gateway.onprem.id

  name       = "vcn-onprem-dev-001"
  type       = "IPsec"
  shared_key = "ExampleSharedKey123!"

  connection_protocol = "IKEv2"
  enable_bgp          = false

  tags = {
    Environment = "Development"
  }
}

output "vpn_connection_id" {
  value = module.vpn_connection.id
}

output "vpn_connection_name" {
  value = module.vpn_connection.name
}
