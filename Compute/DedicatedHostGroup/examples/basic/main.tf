################################################################################
# Example: Dedicated Host Group
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

module "host_group" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "sap"
  environment = "dev"

  platform_fault_domain_count = 2
  zone                        = "1"
  automatic_placement_enabled = true

  tags = {
    Environment = "Development"
    Workload    = "SAP"
  }
}

output "host_group_id" {
  value = module.host_group.id
}

output "host_group_name" {
  value = module.host_group.name
}
