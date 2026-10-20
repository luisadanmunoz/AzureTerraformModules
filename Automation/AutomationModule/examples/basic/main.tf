################################################################################
# Basic Example - Automation Module (PowerShell)
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

resource "azurerm_resource_group" "example" {
  name     = "rg-automation-example-dev-001"
  location = "westeurope"
}

resource "azurerm_automation_account" "example" {
  name                = "aa-modules-example-dev-001"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "Basic"

  identity {
    type = "SystemAssigned"
  }
}

################################################################################
# Step 1: Import Az.Accounts first (dependency for other Az modules)
################################################################################

module "az_accounts" {
  source = "../../"

  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name

  powershell_gallery_modules = {
    "Az.Accounts" = { version = "2.13.1" }
  }
}

################################################################################
# Step 2: Import other modules (after Az.Accounts)
################################################################################

module "automation_modules" {
  source = "../../"

  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name

  # From PowerShell Gallery
  powershell_gallery_modules = {
    "Az.Compute"  = { version = "6.3.0" }
    "Az.Storage"  = { version = "5.10.1" }
    "Az.KeyVault" = { version = "4.11.0" }
  }

  depends_on = [module.az_accounts]
}

################################################################################
# Outputs
################################################################################

output "az_accounts_module_id" {
  value = module.az_accounts.module_ids
}

output "module_ids" {
  value = module.automation_modules.module_ids
}

output "module_names" {
  value = module.automation_modules.module_names
}
