################################################################################
# Basic Example - Virtual Network Manager Module
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

data "azurerm_subscription" "current" {}

################################################################################
# Resource Group (DEPENDENCY for Virtual Network Manager)
################################################################################

resource "azurerm_resource_group" "example" {
  name     = "rg-vnm-example-dev-001"
  location = "westeurope"

  tags = {
    Environment = "Development"
    Example     = "VirtualNetworkManager-Basic"
  }
}

################################################################################
# Virtual Network Manager Module
################################################################################

module "vnm" {
  source = "../../"

  # DEPENDENCY: Resource Group must exist
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Explicit naming
  name = "vnm-example-dev-001"

  # Scope accesses - what configuration types this manager can deploy
  scope_accesses = ["Connectivity", "SecurityAdmin"]

  # Scope - which subscriptions/management groups this manager can manage
  scope = {
    subscription_ids = [data.azurerm_subscription.current.id]
  }

  description = "Example Virtual Network Manager for development"

  # Network Groups
  network_groups = [
    {
      name        = "ng-spoke-vnets"
      description = "Network group for spoke virtual networks"
    }
  ]

  tags = {
    Environment = "Development"
    Project     = "Example"
    ManagedBy   = "Terraform"
  }
}

################################################################################
# Outputs
################################################################################

output "vnm_id" {
  description = "The ID of the created Virtual Network Manager"
  value       = module.vnm.id
}

output "vnm_name" {
  description = "The name of the created Virtual Network Manager"
  value       = module.vnm.name
}

output "network_group_ids" {
  description = "Map of Network Group names to their IDs"
  value       = module.vnm.network_group_ids
}

output "cross_tenant_scopes" {
  description = "The cross-tenant scopes of the Virtual Network Manager"
  value       = module.vnm.cross_tenant_scopes
}
