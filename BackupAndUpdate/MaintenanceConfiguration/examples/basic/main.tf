################################################################################
# Example: Maintenance Configurations
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
  name     = "rg-maintenance-dev-001"
  location = "westeurope"
}

# ──────────────────────────────────────────────────────────────────────────────
# VM In-Guest Patching Configuration
# ──────────────────────────────────────────────────────────────────────────────

module "patch_config_weekly" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "patching"
  environment = "dev"

  scope                    = "InGuestPatch"
  in_guest_user_patch_mode = "Platform"

  window = {
    start_date_time = "2024-01-07 02:00"
    duration        = "03:00"
    time_zone       = "UTC"
    recur_every     = "Week Sunday"
  }

  install_patches = {
    reboot = "IfRequired"
    windows = {
      classifications_to_include = ["Critical", "Security", "UpdateRollup"]
      kb_numbers_to_exclude      = []
    }
    linux = {
      classifications_to_include    = ["Critical", "Security"]
      package_names_mask_to_exclude = ["kernel*"]
    }
  }

  tags = {
    Environment = "Development"
    Schedule    = "Weekly"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Monthly Security-Only Patching
# ──────────────────────────────────────────────────────────────────────────────

module "patch_config_monthly" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "maint-monthly-security"

  scope                    = "InGuestPatch"
  in_guest_user_patch_mode = "Platform"

  window = {
    start_date_time = "2024-01-14 03:00"
    duration        = "04:00"
    time_zone       = "UTC"
    recur_every     = "Month Second Sunday"
  }

  install_patches = {
    reboot = "Always"
    windows = {
      classifications_to_include = ["Security"]
    }
    linux = {
      classifications_to_include = ["Security"]
    }
  }

  tags = {
    Environment = "Development"
    Schedule    = "Monthly"
    Type        = "SecurityOnly"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Host Maintenance Configuration
# ──────────────────────────────────────────────────────────────────────────────

module "host_maintenance" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "maint-host-quarterly"

  scope = "Host"

  window = {
    start_date_time = "2024-01-21 04:00"
    duration        = "05:00"
    time_zone       = "UTC"
    recur_every     = "Month Fourth Sunday"
  }

  tags = {
    Environment = "Development"
    Type        = "DedicatedHost"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "weekly_patch_config_id" {
  description = "Weekly patch configuration ID"
  value       = module.patch_config_weekly.id
}

output "monthly_patch_config_id" {
  description = "Monthly patch configuration ID"
  value       = module.patch_config_monthly.id
}

output "host_maintenance_id" {
  description = "Host maintenance configuration ID"
  value       = module.host_maintenance.id
}
