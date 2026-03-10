################################################################################
# Basic Example - Network Watcher Module
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
  name     = "rg-networkwatcher-example-dev-001"
  location = "westeurope"
}

module "network_watcher" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name = "nw-shared-dev-001"

  tags = {
    Environment = "Development"
  }
}

output "network_watcher_id" {
  value = module.network_watcher.id
}

output "network_watcher_name" {
  value = module.network_watcher.name
}
