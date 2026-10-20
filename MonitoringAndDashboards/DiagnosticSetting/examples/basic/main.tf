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
# Data Sources
################################################################################

data "azurerm_client_config" "current" {}

################################################################################
# Resource Group
################################################################################

resource "azurerm_resource_group" "main" {
  name     = "rg-diagnostic-setting-example"
  location = "eastus"
}

################################################################################
# Log Analytics Workspace
################################################################################

resource "azurerm_log_analytics_workspace" "main" {
  name                = "law-diagnostic-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

################################################################################
# Key Vault (target resource)
################################################################################

resource "azurerm_key_vault" "main" {
  name                = "kv-diag-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}

################################################################################
# Diagnostic Setting - All Logs to Log Analytics
################################################################################

module "diag_keyvault" {
  source = "../../"

  name                       = "diag-keyvault-to-law"
  target_resource_id         = azurerm_key_vault.main.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_logs = [
    { category_group = "allLogs" }
  ]

  metrics = [
    { category = "AllMetrics" }
  ]
}

################################################################################
# Storage Account (for archival)
################################################################################

resource "azurerm_storage_account" "audit" {
  name                     = "stdiagexampleaudit"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

################################################################################
# Diagnostic Setting - Specific Logs to Storage
################################################################################

module "diag_keyvault_storage" {
  source = "../../"

  name               = "diag-keyvault-to-storage"
  target_resource_id = azurerm_key_vault.main.id
  storage_account_id = azurerm_storage_account.audit.id

  enabled_logs = [
    {
      category = "AuditEvent"
      retention_policy = {
        enabled = true
        days    = 365
      }
    }
  ]
}

################################################################################
# Outputs
################################################################################

output "law_diagnostic_id" {
  description = "The ID of the Log Analytics diagnostic setting."
  value       = module.diag_keyvault.id
}

output "storage_diagnostic_id" {
  description = "The ID of the Storage diagnostic setting."
  value       = module.diag_keyvault_storage.id
}
