################################################################################
# Example: File Share Backup Policies
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
# Standard Daily Policy
# ──────────────────────────────────────────────────────────────────────────────

module "policy_daily" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  recovery_vault_name = azurerm_recovery_services_vault.example.name

  workload    = "standard"
  environment = "dev"

  backup = {
    frequency = "Daily"
    time      = "22:00"
  }

  retention_daily = 30

  retention_weekly = {
    count    = 4
    weekdays = ["Sunday"]
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Hourly Policy for Critical Shares
# ──────────────────────────────────────────────────────────────────────────────

module "policy_hourly" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  recovery_vault_name = azurerm_recovery_services_vault.example.name
  name                = "bkpol-fileshare-hourly"

  timezone = "UTC"

  backup = {
    frequency = "Hourly"
    hourly = {
      interval        = 4
      start_time      = "08:00"
      window_duration = 16
    }
  }

  retention_daily = 30

  retention_weekly = {
    count    = 12
    weekdays = ["Sunday"]
  }

  retention_monthly = {
    count    = 12
    weekdays = ["Sunday"]
    weeks    = ["First"]
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "daily_policy_id" {
  description = "Daily policy ID"
  value       = module.policy_daily.id
}

output "hourly_policy_id" {
  description = "Hourly policy ID"
  value       = module.policy_hourly.id
}
