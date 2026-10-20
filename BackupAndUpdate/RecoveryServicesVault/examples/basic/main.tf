################################################################################
# Example: Recovery Services Vault
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
  features {
    recovery_services_vault {
      recover_soft_deleted_backup_protected_vm = true
    }
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Resource Group
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_resource_group" "example" {
  name     = "rg-backup-dev-001"
  location = "westeurope"
}

# ──────────────────────────────────────────────────────────────────────────────
# Log Analytics Workspace (for diagnostics)
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_log_analytics_workspace" "example" {
  name                = "log-backup-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# ──────────────────────────────────────────────────────────────────────────────
# Basic Recovery Services Vault
# ──────────────────────────────────────────────────────────────────────────────

module "recovery_vault_basic" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "general"
  environment = "dev"

  storage_mode_type   = "LocallyRedundant" # Cost-effective for dev
  soft_delete_enabled = true

  tags = {
    Environment = "Development"
    Purpose     = "VM Backups"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Production Recovery Services Vault with DR
# ──────────────────────────────────────────────────────────────────────────────

module "recovery_vault_prod" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "rsv-enterprise-prod-001"

  # Geo-redundant with cross-region restore
  storage_mode_type            = "GeoRedundant"
  cross_region_restore_enabled = true
  soft_delete_enabled          = true

  # Alerting
  monitoring = {
    alerts_for_all_job_failures_enabled            = true
    alerts_for_critical_operation_failures_enabled = true
  }

  # Diagnostics
  diagnostic_settings = {
    name                       = "diag-rsv-prod"
    log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
    log_categories = [
      "CoreAzureBackup",
      "AddonAzureBackupJobs",
      "AddonAzureBackupAlerts",
      "AzureBackupReport"
    ]
  }

  tags = {
    Environment = "Production"
    DR          = "Enabled"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "basic_vault_id" {
  description = "The ID of the basic Recovery Services Vault"
  value       = module.recovery_vault_basic.id
}

output "basic_vault_name" {
  description = "The name of the basic Recovery Services Vault"
  value       = module.recovery_vault_basic.name
}

output "prod_vault_id" {
  description = "The ID of the production Recovery Services Vault"
  value       = module.recovery_vault_prod.id
}

output "prod_vault_name" {
  description = "The name of the production Recovery Services Vault"
  value       = module.recovery_vault_prod.name
}
