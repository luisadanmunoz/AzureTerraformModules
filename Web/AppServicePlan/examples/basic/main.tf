# -----------------------------------------------------------------------------
# Basic Linux Premium App Service Plan Example
# -----------------------------------------------------------------------------
# This example demonstrates how to create a basic Linux App Service Plan
# using the Premium v3 tier, suitable for production workloads.
# -----------------------------------------------------------------------------

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

# -----------------------------------------------------------------------------
# Resource Group
# -----------------------------------------------------------------------------

resource "azurerm_resource_group" "example" {
  name     = "rg-appservice-example"
  location = "eastus"

  tags = {
    Environment = "Example"
    Purpose     = "AppServicePlan Module Demo"
  }
}

# -----------------------------------------------------------------------------
# App Service Plan using the module
# -----------------------------------------------------------------------------

module "app_service_plan" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Naming configuration
  name_prefix = "asp"
  workload    = "webapp"
  environment = "dev"

  # App Service Plan configuration
  os_type  = "Linux"
  sku_name = "P1v3"

  # Optional: Set specific worker count
  # worker_count = 2

  # Optional: Enable zone redundancy for high availability
  # zone_balancing_enabled = true

  # Optional: Enable per-site scaling
  # per_site_scaling_enabled = true

  tags = {
    Application = "WebApp"
    Environment = "Development"
    CostCenter  = "IT-12345"
  }
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "app_service_plan_id" {
  description = "The ID of the App Service Plan"
  value       = module.app_service_plan.id
}

output "app_service_plan_name" {
  description = "The name of the App Service Plan"
  value       = module.app_service_plan.name
}

output "app_service_plan_kind" {
  description = "The kind of the App Service Plan"
  value       = module.app_service_plan.kind
}

output "app_service_plan_os_type" {
  description = "The OS type of the App Service Plan"
  value       = module.app_service_plan.os_type
}
