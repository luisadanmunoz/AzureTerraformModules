################################################################################
# Example: File Share Backup Protection
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

# ──────────────────────────────────────────────────────────────────────────────
# Resource Group
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_resource_group" "example" {
  name     = "rg-backup-dev-001"
  location = "westeurope"
}

# ──────────────────────────────────────────────────────────────────────────────
# Storage Account with File Share
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_storage_account" "example" {
  name                     = "stbackupdev001"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "data" {
  name                 = "share-data"
  storage_account_name = azurerm_storage_account.example.name
  quota                = 50
}

resource "azurerm_storage_share" "logs" {
  name                 = "share-logs"
  storage_account_name = azurerm_storage_account.example.name
  quota                = 100
}

# ──────────────────────────────────────────────────────────────────────────────
# Recovery Services Vault
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_recovery_services_vault" "example" {
  name                = "rsv-fileshare-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard"
  storage_mode_type   = "LocallyRedundant"
  soft_delete_enabled = true
}

# ──────────────────────────────────────────────────────────────────────────────
# Backup Policy
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_backup_policy_file_share" "example" {
  name                = "bkpol-fileshare-daily"
  resource_group_name = azurerm_resource_group.example.name
  recovery_vault_name = azurerm_recovery_services_vault.example.name

  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 30
  }

  retention_weekly {
    count    = 4
    weekdays = ["Sunday"]
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Protect File Shares
# ──────────────────────────────────────────────────────────────────────────────

module "backup_data_share" {
  source = "../../"

  resource_group_name       = azurerm_resource_group.example.name
  recovery_vault_name       = azurerm_recovery_services_vault.example.name
  source_storage_account_id = azurerm_storage_account.example.id
  source_file_share_name    = azurerm_storage_share.data.name
  backup_policy_id          = azurerm_backup_policy_file_share.example.id
}

module "backup_logs_share" {
  source = "../../"

  resource_group_name       = azurerm_resource_group.example.name
  recovery_vault_name       = azurerm_recovery_services_vault.example.name
  source_storage_account_id = azurerm_storage_account.example.id
  source_file_share_name    = azurerm_storage_share.logs.name
  backup_policy_id          = azurerm_backup_policy_file_share.example.id

  depends_on = [module.backup_data_share]
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "data_share_backup_id" {
  description = "Backup ID for data share"
  value       = module.backup_data_share.id
}

output "logs_share_backup_id" {
  description = "Backup ID for logs share"
  value       = module.backup_logs_share.id
}
