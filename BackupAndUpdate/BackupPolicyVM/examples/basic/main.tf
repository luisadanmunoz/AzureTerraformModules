################################################################################
# Example: VM Backup Policies
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
  name                = "rsv-backup-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard"
  storage_mode_type   = "LocallyRedundant"
  soft_delete_enabled = true
}

# ──────────────────────────────────────────────────────────────────────────────
# Standard Daily Policy
# ──────────────────────────────────────────────────────────────────────────────

module "policy_standard" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  recovery_vault_name = azurerm_recovery_services_vault.example.name

  workload    = "standard"
  environment = "dev"

  timezone = "UTC"

  backup = {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily = 14

  retention_weekly = {
    count    = 4
    weekdays = ["Sunday"]
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Hourly Policy for Critical VMs (V2)
# ──────────────────────────────────────────────────────────────────────────────

module "policy_critical" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  recovery_vault_name = azurerm_recovery_services_vault.example.name
  name                = "bkpol-critical-hourly"

  policy_type = "V2"
  timezone    = "UTC"

  backup = {
    frequency     = "Hourly"
    hour_interval = 4   # Every 4 hours
    hour_duration = 24  # Backup window
  }

  instant_restore_retention_days = 7

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
# Long-term Retention Policy
# ──────────────────────────────────────────────────────────────────────────────

module "policy_longterm" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  recovery_vault_name = azurerm_recovery_services_vault.example.name
  name                = "bkpol-longterm-archive"

  backup = {
    frequency = "Daily"
    time      = "02:00"
  }

  retention_daily = 30

  retention_weekly = {
    count    = 12
    weekdays = ["Sunday"]
  }

  retention_monthly = {
    count    = 60  # 5 years
    weekdays = ["Sunday"]
    weeks    = ["First"]
  }

  retention_yearly = {
    count    = 7
    months   = ["January"]
    weekdays = ["Sunday"]
    weeks    = ["First"]
  }

  # Archive older backups for cost savings
  tiering_policy = {
    archive_tier = {
      mode          = "TierAfter"
      duration      = 180
      duration_type = "Days"
    }
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "standard_policy_id" {
  description = "Standard policy ID"
  value       = module.policy_standard.id
}

output "critical_policy_id" {
  description = "Critical (hourly) policy ID"
  value       = module.policy_critical.id
}

output "longterm_policy_id" {
  description = "Long-term policy ID"
  value       = module.policy_longterm.id
}
