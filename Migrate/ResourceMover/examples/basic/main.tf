################################################################################
# Provider Configuration
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
# Resource Group
################################################################################

resource "azurerm_resource_group" "main" {
  name     = "rg-resource-mover-example"
  location = "eastus"
}

################################################################################
# Resource Mover - East US to West US
################################################################################

module "mover_eastus_westus" {
  source = "../../"

  name                = "move-eastus-to-westus"
  resource_group_name = azurerm_resource_group.main.name
  source_region       = "eastus"
  target_region       = "westus"

  tags = {
    Environment = "Example"
    Purpose     = "CrossRegionMigration"
  }
}

################################################################################
# Resource Mover - East US to West Europe
################################################################################

module "mover_eastus_westeurope" {
  source = "../../"

  name                = "move-eastus-to-westeurope"
  resource_group_name = azurerm_resource_group.main.name
  source_region       = "eastus"
  target_region       = "westeurope"

  tags = {
    Environment = "Example"
    Purpose     = "GeoMigration"
  }
}

################################################################################
# Outputs
################################################################################

output "mover_westus_id" {
  description = "The ID of the East US to West US mover."
  value       = module.mover_eastus_westus.id
}

output "mover_westus_principal_id" {
  description = "The principal ID of the East US to West US mover."
  value       = module.mover_eastus_westus.principal_id
}

output "mover_westeurope_id" {
  description = "The ID of the East US to West Europe mover."
  value       = module.mover_eastus_westeurope.id
}
