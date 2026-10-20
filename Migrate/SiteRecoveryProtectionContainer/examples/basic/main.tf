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
  name     = "rg-protection-container-example"
  location = "eastus"
}

################################################################################
# Recovery Services Vault
################################################################################

resource "azurerm_recovery_services_vault" "main" {
  name                = "rsv-container-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"
}

################################################################################
# Site Recovery Fabric
################################################################################

module "fabric_primary" {
  source = "../../../SiteRecoveryFabric"

  name                = "fabric-primary"
  resource_group_name = azurerm_resource_group.main.name
  recovery_vault_name = azurerm_recovery_services_vault.main.name
  location            = "eastus"
}

module "fabric_secondary" {
  source = "../../../SiteRecoveryFabric"

  name                = "fabric-secondary"
  resource_group_name = azurerm_resource_group.main.name
  recovery_vault_name = azurerm_recovery_services_vault.main.name
  location            = "westus"
}

################################################################################
# Protection Containers
################################################################################

module "container_primary" {
  source = "../../"

  name                 = "container-primary"
  resource_group_name  = azurerm_resource_group.main.name
  recovery_vault_name  = azurerm_recovery_services_vault.main.name
  recovery_fabric_name = module.fabric_primary.name

  depends_on = [module.fabric_primary]
}

module "container_secondary" {
  source = "../../"

  name                 = "container-secondary"
  resource_group_name  = azurerm_resource_group.main.name
  recovery_vault_name  = azurerm_recovery_services_vault.main.name
  recovery_fabric_name = module.fabric_secondary.name

  depends_on = [module.fabric_secondary]
}

################################################################################
# Outputs
################################################################################

output "primary_container_id" {
  description = "The ID of the primary protection container."
  value       = module.container_primary.id
}

output "secondary_container_id" {
  description = "The ID of the secondary protection container."
  value       = module.container_secondary.id
}
