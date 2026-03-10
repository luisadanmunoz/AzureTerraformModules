################################################################################
# Example: Azure Resource Locks
# Protect Critical Resources
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

resource "azurerm_resource_group" "production" {
  name     = "rg-production-001"
  location = "westeurope"

  tags = {
    Environment = "Production"
  }
}

resource "azurerm_storage_account" "critical" {
  name                     = "stcriticaldata001"
  resource_group_name      = azurerm_resource_group.production.name
  location                 = azurerm_resource_group.production.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

################################################################################
# Resource Group Lock
# Best Practice: Protect entire production resource groups
################################################################################

module "lock_production_rg" {
  source = "../../"

  name                = "production-do-not-delete"
  lock_level          = "CanNotDelete"
  scope_type          = "resource_group"
  resource_group_name = azurerm_resource_group.production.name
  notes               = "Production environment - deletion requires approval from IT governance team"
}

################################################################################
# Resource Lock
# Best Practice: Additional protection for critical resources
################################################################################

module "lock_critical_storage" {
  source = "../../"

  name       = "critical-data-protection"
  lock_level = "CanNotDelete"
  scope_type = "resource"
  scope      = azurerm_storage_account.critical.id
  notes      = "Contains business-critical data - contact data-governance@company.com before any changes"
}

################################################################################
# Outputs
################################################################################

output "rg_lock_id" {
  value = module.lock_production_rg.id
}

output "storage_lock_id" {
  value = module.lock_critical_storage.id
}
