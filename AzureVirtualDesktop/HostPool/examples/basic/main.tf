################################################################################
# Example: Basic AVD Host Pool
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
  name     = "rg-avd-dev-001"
  location = "westeurope"
}

# ──────────────────────────────────────────────────────────────────────────────
# Pooled Host Pool
# ──────────────────────────────────────────────────────────────────────────────

module "hostpool_pooled" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "vdpool-general-dev-001"

  type                     = "Pooled"
  load_balancer_type       = "BreadthFirst"
  maximum_sessions_allowed = 10

  friendly_name       = "General Desktop Pool"
  description         = "Shared desktop environment for general users"
  start_vm_on_connect = true

  # Generate registration token valid for 24 hours
  registration_expiration_date = timeadd(timestamp(), "24h")

  # Secure RDP settings
  custom_rdp_properties = "audiocapturemode:i:0;redirectclipboard:i:1;redirectprinters:i:0"

  scheduled_agent_updates = {
    enabled  = true
    timezone = "UTC"
    schedule = [
      {
        day_of_week = "Sunday"
        hour_of_day = 3
      }
    ]
  }

  tags = {
    Environment = "Development"
    Purpose     = "General"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Personal Host Pool
# ──────────────────────────────────────────────────────────────────────────────

module "hostpool_personal" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "vdpool-developers-dev-001"

  type                             = "Personal"
  load_balancer_type               = "Persistent"
  personal_desktop_assignment_type = "Automatic"

  friendly_name       = "Developer Desktops"
  start_vm_on_connect = true

  tags = {
    Environment = "Development"
    Team        = "Engineering"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "pooled_hostpool_id" {
  description = "The ID of the Pooled Host Pool"
  value       = module.hostpool_pooled.id
}

output "pooled_hostpool_registration_token" {
  description = "The registration token for the Pooled Host Pool"
  value       = module.hostpool_pooled.registration_token
  sensitive   = true
}

output "personal_hostpool_id" {
  description = "The ID of the Personal Host Pool"
  value       = module.hostpool_personal.id
}
