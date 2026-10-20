################################################################################
# Example: Dedicated Host
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

resource "azurerm_resource_group" "example" {
  name     = "rg-dedicated-dev-001"
  location = "westeurope"
}

resource "azurerm_dedicated_host_group" "example" {
  name                        = "dhg-sap-dev-001"
  resource_group_name         = azurerm_resource_group.example.name
  location                    = azurerm_resource_group.example.location
  platform_fault_domain_count = 2
  zone                        = "1"
}

module "dedicated_host" {
  source = "../../"

  resource_group_name     = azurerm_resource_group.example.name
  location                = azurerm_resource_group.example.location
  dedicated_host_group_id = azurerm_dedicated_host_group.example.id

  workload    = "sap"
  environment = "dev"

  sku_name              = "DSv3-Type1"
  platform_fault_domain = 0
  auto_replace_on_failure = true

  tags = {
    Environment = "Development"
    Workload    = "SAP"
  }
}

output "host_id" {
  value = module.dedicated_host.id
}

output "host_name" {
  value = module.dedicated_host.name
}
