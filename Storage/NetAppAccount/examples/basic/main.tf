# -----------------------------------------------------------------------------
# Basic Azure NetApp Files Account Example
# -----------------------------------------------------------------------------
# This example demonstrates how to create a basic Azure NetApp Files Account
# without Active Directory integration, suitable for NFS volumes.
# -----------------------------------------------------------------------------

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

# -----------------------------------------------------------------------------
# Resource Group
# -----------------------------------------------------------------------------

resource "azurerm_resource_group" "example" {
  name     = "rg-netapp-example"
  location = "eastus"
}

# -----------------------------------------------------------------------------
# NetApp Account - Basic Configuration
# -----------------------------------------------------------------------------

module "netapp_account" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name_prefix = "anf"
  workload    = "data"
  environment = "dev"
  instance    = "001"

  tags = {
    Application = "DataPlatform"
    Owner       = "Platform Team"
  }
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "netapp_account_id" {
  description = "The ID of the NetApp Account."
  value       = module.netapp_account.id
}

output "netapp_account_name" {
  description = "The name of the NetApp Account."
  value       = module.netapp_account.name
}

output "netapp_account_location" {
  description = "The location of the NetApp Account."
  value       = module.netapp_account.location
}
