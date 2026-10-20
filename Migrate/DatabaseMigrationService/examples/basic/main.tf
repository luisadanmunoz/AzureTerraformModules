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
  name     = "rg-dms-example"
  location = "eastus"
}

################################################################################
# Virtual Network and Subnet
################################################################################

resource "azurerm_virtual_network" "main" {
  name                = "vnet-dms-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "dms" {
  name                 = "snet-dms"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

################################################################################
# Database Migration Service - Standard
################################################################################

module "dms_standard" {
  source = "../../"

  name                = "dms-standard-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  subnet_id           = azurerm_subnet.dms.id
  sku_name            = "Standard_1vCores"

  tags = {
    Environment = "Example"
    Purpose     = "StandardMigration"
  }
}

################################################################################
# Database Migration Service - Premium
################################################################################

module "dms_premium" {
  source = "../../"

  name                = "dms-premium-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  subnet_id           = azurerm_subnet.dms.id
  sku_name            = "Premium_4vCores"

  tags = {
    Environment = "Example"
    Purpose     = "OnlineMigration"
  }
}

################################################################################
# Outputs
################################################################################

output "standard_dms_id" {
  description = "The ID of the standard DMS."
  value       = module.dms_standard.id
}

output "premium_dms_id" {
  description = "The ID of the premium DMS."
  value       = module.dms_premium.id
}
