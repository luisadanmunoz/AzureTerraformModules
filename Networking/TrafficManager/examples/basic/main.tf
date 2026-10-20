################################################################################
# Basic Example - Traffic Manager Module
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
  name     = "rg-tm-example-dev-001"
  location = "westeurope"
}

resource "azurerm_public_ip" "primary" {
  name                = "pip-tm-primary-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "secondary" {
  name                = "pip-tm-secondary-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

module "traffic_manager" {
  source = "../../"

  resource_group_name    = azurerm_resource_group.example.name
  name                   = "tm-web-dev-001"
  traffic_routing_method = "Performance"

  monitor_config = {
    protocol = "HTTPS"
    port     = 443
    path     = "/health"
  }

  endpoints = [
    {
      name               = "ep-primary"
      type               = "azureEndpoints"
      target_resource_id = azurerm_public_ip.primary.id
    },
    {
      name               = "ep-secondary"
      type               = "azureEndpoints"
      target_resource_id = azurerm_public_ip.secondary.id
    }
  ]

  tags = {
    Environment = "Development"
  }
}

output "tm_id" {
  value = module.traffic_manager.id
}

output "tm_fqdn" {
  value = module.traffic_manager.fqdn
}
