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
# Resource Groups
################################################################################

resource "azurerm_resource_group" "primary" {
  name     = "rg-network-mapping-primary"
  location = "eastus"
}

resource "azurerm_resource_group" "secondary" {
  name     = "rg-network-mapping-secondary"
  location = "westus"
}

################################################################################
# Virtual Networks
################################################################################

resource "azurerm_virtual_network" "primary" {
  name                = "vnet-primary"
  resource_group_name = azurerm_resource_group.primary.name
  location            = azurerm_resource_group.primary.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_virtual_network" "secondary" {
  name                = "vnet-secondary"
  resource_group_name = azurerm_resource_group.secondary.name
  location            = azurerm_resource_group.secondary.location
  address_space       = ["10.1.0.0/16"]
}

################################################################################
# Recovery Services Vault
################################################################################

resource "azurerm_recovery_services_vault" "main" {
  name                = "rsv-net-mapping-example"
  resource_group_name = azurerm_resource_group.primary.name
  location            = azurerm_resource_group.primary.location
  sku                 = "Standard"
}

################################################################################
# Site Recovery Fabrics
################################################################################

module "fabric_primary" {
  source = "../../../SiteRecoveryFabric"

  name                = "fabric-primary"
  resource_group_name = azurerm_resource_group.primary.name
  recovery_vault_name = azurerm_recovery_services_vault.main.name
  location            = "eastus"
}

module "fabric_secondary" {
  source = "../../../SiteRecoveryFabric"

  name                = "fabric-secondary"
  resource_group_name = azurerm_resource_group.primary.name
  recovery_vault_name = azurerm_recovery_services_vault.main.name
  location            = "westus"
}

################################################################################
# Network Mapping
################################################################################

module "network_mapping" {
  source = "../../"

  name                        = "mapping-eastus-westus"
  resource_group_name         = azurerm_resource_group.primary.name
  recovery_vault_name         = azurerm_recovery_services_vault.main.name
  source_recovery_fabric_name = module.fabric_primary.name
  target_recovery_fabric_name = module.fabric_secondary.name
  source_network_id           = azurerm_virtual_network.primary.id
  target_network_id           = azurerm_virtual_network.secondary.id

  depends_on = [
    module.fabric_primary,
    module.fabric_secondary
  ]
}

################################################################################
# Outputs
################################################################################

output "network_mapping_id" {
  description = "The ID of the network mapping."
  value       = module.network_mapping.id
}
