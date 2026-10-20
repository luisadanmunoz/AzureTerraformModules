################################################################################
# Basic Example - Firewall Policy Module
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
  name     = "rg-fwpolicy-example-dev-001"
  location = "westeurope"
}

module "firewall_policy" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "afwp-hub-dev-001"
  sku                 = "Standard"

  threat_intelligence_mode = "Alert"

  dns = {
    proxy_enabled = true
  }

  tags = {
    Environment = "Development"
  }
}

output "policy_id" {
  value = module.firewall_policy.id
}
