################################################################################
# Example: Basic AVD Application Groups
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
# Host Pool (Required)
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_virtual_desktop_host_pool" "example" {
  name                = "vdpool-example-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  type                     = "Pooled"
  load_balancer_type       = "BreadthFirst"
  maximum_sessions_allowed = 10
}

# ──────────────────────────────────────────────────────────────────────────────
# Desktop Application Group
# ──────────────────────────────────────────────────────────────────────────────

module "app_group_desktop" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "vdag-desktop-dev-001"

  host_pool_id = azurerm_virtual_desktop_host_pool.example.id
  type         = "Desktop"

  friendly_name                = "Full Desktop"
  description                  = "Full desktop experience for power users"
  default_desktop_display_name = "Development Desktop"

  tags = {
    Environment = "Development"
    Type        = "Desktop"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# RemoteApp Application Group
# ──────────────────────────────────────────────────────────────────────────────

module "app_group_remoteapp" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "vdag-office-dev-001"

  host_pool_id = azurerm_virtual_desktop_host_pool.example.id
  type         = "RemoteApp"

  friendly_name = "Office Applications"
  description   = "Microsoft Office suite and business applications"

  tags = {
    Environment = "Development"
    Type        = "RemoteApp"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "desktop_app_group_id" {
  description = "The ID of the Desktop Application Group"
  value       = module.app_group_desktop.id
}

output "remoteapp_group_id" {
  description = "The ID of the RemoteApp Application Group"
  value       = module.app_group_remoteapp.id
}
