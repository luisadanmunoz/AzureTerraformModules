################################################################################
# Basic Example - Subnet Module
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
  name     = "rg-subnet-example-dev-001"
  location = "westeurope"

  tags = {
    Environment = "Development"
    Example     = "Subnet-Basic"
  }
}

################################################################################
# Virtual Network (DEPENDENCY for Subnet)
################################################################################

resource "azurerm_virtual_network" "example" {
  name                = "vnet-example-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]

  tags = azurerm_resource_group.example.tags
}

################################################################################
# Subnet Module - Basic
################################################################################

module "subnet_basic" {
  source = "../../"

  # DEPENDENCIES
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name

  name             = "snet-basic-001"
  address_prefixes = ["10.0.1.0/24"]
}

################################################################################
# Subnet Module - With Service Endpoints
################################################################################

module "subnet_with_endpoints" {
  source = "../../"

  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name

  name             = "snet-data-001"
  address_prefixes = ["10.0.2.0/24"]

  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.KeyVault"
  ]
}

################################################################################
# Subnet Module - With Delegation
################################################################################

module "subnet_delegated" {
  source = "../../"

  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name

  name             = "snet-appservice-001"
  address_prefixes = ["10.0.3.0/24"]

  delegation = {
    name = "appservice-delegation"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

################################################################################
# Outputs
################################################################################

output "subnet_basic_id" {
  description = "ID of the basic subnet"
  value       = module.subnet_basic.id
}

output "subnet_with_endpoints_id" {
  description = "ID of the subnet with service endpoints"
  value       = module.subnet_with_endpoints.id
}

output "subnet_delegated_id" {
  description = "ID of the delegated subnet"
  value       = module.subnet_delegated.id
}
