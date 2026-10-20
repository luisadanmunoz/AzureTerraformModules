################################################################################
# Example: Basic AVD Workspace
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
# Host Pool
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
# Application Groups
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_virtual_desktop_application_group" "desktop" {
  name                = "vdag-desktop-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  host_pool_id        = azurerm_virtual_desktop_host_pool.example.id
  type                = "Desktop"
  friendly_name       = "Full Desktop"
}

resource "azurerm_virtual_desktop_application_group" "remoteapp" {
  name                = "vdag-office-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  host_pool_id        = azurerm_virtual_desktop_host_pool.example.id
  type                = "RemoteApp"
  friendly_name       = "Office Apps"
}

# ──────────────────────────────────────────────────────────────────────────────
# Workspace Module
# ──────────────────────────────────────────────────────────────────────────────

module "workspace" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "vdws-corporate-dev-001"

  friendly_name = "Corporate Virtual Desktops"
  description   = "Virtual desktop environment for all employees"

  # Associate both application groups
  application_group_ids = [
    azurerm_virtual_desktop_application_group.desktop.id,
    azurerm_virtual_desktop_application_group.remoteapp.id,
  ]

  tags = {
    Environment = "Development"
    Purpose     = "Corporate"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "workspace_id" {
  description = "The ID of the Workspace"
  value       = module.workspace.id
}

output "workspace_name" {
  description = "The name of the Workspace"
  value       = module.workspace.name
}

output "associated_app_groups" {
  description = "The associated Application Group IDs"
  value       = module.workspace.associated_application_group_ids
}
