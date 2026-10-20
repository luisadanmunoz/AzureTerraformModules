################################################################################
# Basic Example - Automation Account Module
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

resource "azurerm_resource_group" "example" {
  name     = "rg-automation-example-dev-001"
  location = "westeurope"
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "log-automation-example-dev-001"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

################################################################################
# Automation Account with System Assigned Identity and Diagnostics
################################################################################

module "automation_account" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "aa-runbooks-dev-001"

  sku_name = "Basic"

  identity = {
    type = "SystemAssigned"
  }

  diagnostic_settings = {
    name                       = "diag-aa-runbooks"
    log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
    enabled_log_categories     = ["JobLogs", "JobStreams", "DscNodeStatus", "AuditEvent"]
    metric_categories          = ["AllMetrics"]
  }

  tags = {
    Environment = "Development"
    Project     = "Automation"
  }
}

################################################################################
# Outputs
################################################################################

output "automation_account_id" {
  value = module.automation_account.id
}

output "automation_account_name" {
  value = module.automation_account.name
}

output "automation_account_principal_id" {
  value = module.automation_account.principal_id
}

output "dsc_server_endpoint" {
  value = module.automation_account.dsc_server_endpoint
}

output "hybrid_service_url" {
  value = module.automation_account.hybrid_service_url
}
