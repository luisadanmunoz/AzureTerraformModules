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
  name     = "rg-site-recovery-fabric-example"
  location = "eastus"
}

################################################################################
# Recovery Services Vault
################################################################################

resource "azurerm_recovery_services_vault" "main" {
  name                = "rsv-fabric-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"
}

################################################################################
# Site Recovery Fabrics
################################################################################

module "fabric_primary" {
  source = "../../"

  name                = "fabric-primary-eastus"
  resource_group_name = azurerm_resource_group.main.name
  recovery_vault_name = azurerm_recovery_services_vault.main.name
  location            = "eastus"
}

module "fabric_secondary" {
  source = "../../"

  name                = "fabric-secondary-westus"
  resource_group_name = azurerm_resource_group.main.name
  recovery_vault_name = azurerm_recovery_services_vault.main.name
  location            = "westus"
}

################################################################################
# Outputs
################################################################################

output "primary_fabric_id" {
  description = "The ID of the primary fabric."
  value       = module.fabric_primary.id
}

output "secondary_fabric_id" {
  description = "The ID of the secondary fabric."
  value       = module.fabric_secondary.id
}
