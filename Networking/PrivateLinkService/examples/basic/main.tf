################################################################################
# Basic Example - Private Link Service Module
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
  name     = "rg-pls-example-dev-001"
  location = "westeurope"
}

################################################################################
# Virtual Network and Subnets (DEPENDENCIES)
################################################################################

resource "azurerm_virtual_network" "example" {
  name                = "vnet-example-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "backend" {
  name                 = "snet-backend"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "pls" {
  name                 = "snet-privatelinkservice"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]

  private_link_service_network_policies_enabled = false
}

################################################################################
# Standard Load Balancer (DEPENDENCY)
################################################################################

resource "azurerm_lb" "example" {
  name                = "lb-example-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "fe-internal"
    subnet_id                     = azurerm_subnet.backend.id
    private_ip_address_allocation = "Dynamic"
  }
}

################################################################################
# Private Link Service Module
################################################################################

module "private_link_service" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name = "pls-example-dev-001"

  load_balancer_frontend_ip_configuration_ids = [
    azurerm_lb.example.frontend_ip_configuration[0].id
  ]

  nat_ip_configuration = [
    {
      name      = "nat-primary"
      subnet_id = azurerm_subnet.pls.id
      primary   = true
    }
  ]

  tags = {
    Environment = "Development"
    Service     = "PrivateLink"
  }
}

################################################################################
# Outputs
################################################################################

output "private_link_service_id" {
  value = module.private_link_service.id
}

output "private_link_service_name" {
  value = module.private_link_service.name
}

output "private_link_service_alias" {
  value = module.private_link_service.alias
}
