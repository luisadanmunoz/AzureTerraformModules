################################################################################
# Basic Example - Route Server Module
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
# Resource Group (DEPENDENCY)
################################################################################

resource "azurerm_resource_group" "example" {
  name     = "rg-routeserver-example-dev-001"
  location = "westeurope"
}

################################################################################
# Virtual Network and RouteServerSubnet (DEPENDENCY)
################################################################################

resource "azurerm_virtual_network" "example" {
  name                = "vnet-hub-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

# RouteServerSubnet must be named exactly "RouteServerSubnet" with a minimum /27 prefix
resource "azurerm_subnet" "route_server" {
  name                 = "RouteServerSubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/27"]
}

################################################################################
# Route Server Module
################################################################################

module "route_server" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  subnet_id           = azurerm_subnet.route_server.id

  name = "rs-hub-dev-001"

  branch_to_branch_traffic_enabled = false

  tags = {
    Environment = "Development"
  }
}

################################################################################
# Outputs
################################################################################

output "route_server_id" {
  value = module.route_server.id
}

output "route_server_name" {
  value = module.route_server.name
}

output "virtual_router_asn" {
  value = module.route_server.virtual_router_asn
}

output "virtual_router_ips" {
  value = module.route_server.virtual_router_ips
}
