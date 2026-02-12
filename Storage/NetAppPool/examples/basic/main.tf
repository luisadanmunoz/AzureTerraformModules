################################################################################
# Basic Example - NetApp Capacity Pool Module
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
# Resource Group (DEPENDENCY for NetApp Account and Capacity Pool)
################################################################################

resource "azurerm_resource_group" "example" {
  name     = "rg-netapp-example-dev-001"
  location = "westeurope"

  tags = {
    Environment = "Development"
    Example     = "NetAppPool-Basic"
  }
}

################################################################################
# NetApp Account (DEPENDENCY for Capacity Pool)
################################################################################

resource "azurerm_netapp_account" "example" {
  name                = "anf-example-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  tags = {
    Environment = "Development"
    Example     = "NetAppPool-Basic"
  }
}

################################################################################
# NetApp Capacity Pool Module
################################################################################

module "netapp_pool" {
  source = "../../"

  # DEPENDENCY: Resource Group must exist
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # DEPENDENCY: NetApp Account must exist
  account_name = azurerm_netapp_account.example.name

  # Explicit naming
  name = "pool-example-dev-001"

  # Basic configuration - Standard tier with 4 TiB
  size_in_tb    = 4
  service_level = "Standard"
  qos_type      = "Auto"

  tags = {
    Environment = "Development"
    Project     = "Example"
    ManagedBy   = "Terraform"
  }
}

################################################################################
# Outputs
################################################################################

output "netapp_pool_id" {
  description = "The ID of the created NetApp Capacity Pool"
  value       = module.netapp_pool.id
}

output "netapp_pool_name" {
  description = "The name of the created NetApp Capacity Pool"
  value       = module.netapp_pool.name
}

output "netapp_pool_service_level" {
  description = "The service level of the NetApp Capacity Pool"
  value       = module.netapp_pool.service_level
}

output "netapp_pool_size_in_tb" {
  description = "The size of the NetApp Capacity Pool in TiB"
  value       = module.netapp_pool.size_in_tb
}
