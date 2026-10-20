################################################################################
# Example: Proximity Placement Group
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
  name     = "rg-ppg-dev-001"
  location = "westeurope"
}

module "ppg" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "hpc"
  environment = "dev"

  zone = "1"

  tags = {
    Environment = "Development"
    Purpose     = "LowLatency"
  }
}

output "ppg_id" {
  value = module.ppg.id
}
