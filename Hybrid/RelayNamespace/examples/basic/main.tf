################################################################################
# Example: Azure Relay Namespace
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "relay" {
  name     = "rg-relay"
  location = "westeurope"
}

module "relay_namespace" {
  source = "../../"

  name                = "relay-prod-001"
  resource_group_name = azurerm_resource_group.relay.name
  location            = azurerm_resource_group.relay.location

  tags = {
    Environment = "Production"
  }
}

output "namespace_id" {
  value = module.relay_namespace.id
}
