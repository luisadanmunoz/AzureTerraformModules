# -----------------------------------------------------------------------------
# Basic Workspace-based Application Insights Example
# -----------------------------------------------------------------------------
# This example demonstrates how to create a workspace-based Application Insights
# resource with a Log Analytics workspace for unified monitoring and querying.
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
  name     = "rg-appinsights-example"
  location = "East US"

  tags = {
    Environment = "Example"
    Purpose     = "Application Insights Demo"
  }
}

# -----------------------------------------------------------------------------
# Log Analytics Workspace
# -----------------------------------------------------------------------------
# Workspace-based Application Insights requires a Log Analytics workspace
# to store telemetry data.
# -----------------------------------------------------------------------------

resource "azurerm_log_analytics_workspace" "example" {
  name                = "log-appinsights-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    Environment = "Example"
    Purpose     = "Application Insights Demo"
  }
}

# -----------------------------------------------------------------------------
# Application Insights Module
# -----------------------------------------------------------------------------

module "application_insights" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Naming
  workload    = "webapp"
  environment = "dev"

  # Link to Log Analytics workspace (recommended)
  workspace_id = azurerm_log_analytics_workspace.example.id

  # Application type
  application_type = "web"

  # Optional settings
  sampling_percentage = 100  # Collect all telemetry (reduce for high-volume apps)
  disable_ip_masking  = false  # Keep IP masking enabled for privacy

  tags = {
    Environment = "Example"
    Purpose     = "Application Insights Demo"
  }
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "application_insights_id" {
  description = "The ID of the Application Insights resource."
  value       = module.application_insights.id
}

output "application_insights_name" {
  description = "The name of the Application Insights resource."
  value       = module.application_insights.name
}

output "application_insights_app_id" {
  description = "The App ID of the Application Insights resource."
  value       = module.application_insights.app_id
}

output "application_insights_instrumentation_key" {
  description = "The Instrumentation Key for configuring applications."
  value       = module.application_insights.instrumentation_key
  sensitive   = true
}

output "application_insights_connection_string" {
  description = "The Connection String for configuring applications."
  value       = module.application_insights.connection_string
  sensitive   = true
}
