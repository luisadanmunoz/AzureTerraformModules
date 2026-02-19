################################################################################
# Provider Configuration
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
# Resource Group
################################################################################

resource "azurerm_resource_group" "main" {
  name     = "rg-scheduled-query-example"
  location = "eastus"
}

################################################################################
# Log Analytics Workspace
################################################################################

resource "azurerm_log_analytics_workspace" "main" {
  name                = "law-query-rule-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

################################################################################
# Action Group
################################################################################

module "action_group" {
  source = "../../../ActionGroup"

  name                = "ag-query-alerts"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "query"

  email_receivers = [
    {
      name          = "admin"
      email_address = "admin@contoso.com"
    }
  ]
}

################################################################################
# Scheduled Query Rule - Error Count
################################################################################

module "alert_error_count" {
  source = "../../"

  name                = "alert-high-error-count"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  scopes              = [azurerm_log_analytics_workspace.main.id]
  description         = "Alert when error count exceeds threshold"
  severity            = 1
  evaluation_frequency = "PT5M"
  window_duration      = "PT15M"

  criteria = {
    query                   = <<-QUERY
      AppExceptions
      | summarize ErrorCount = count() by bin(TimeGenerated, 5m)
    QUERY
    time_aggregation_method = "Count"
    threshold               = 10
    operator                = "GreaterThan"
    failing_periods = {
      minimum_failing_periods_to_trigger_alert = 2
      number_of_evaluation_periods             = 3
    }
  }

  action_group_ids = [module.action_group.id]

  tags = {
    Environment = "Example"
  }
}

################################################################################
# Scheduled Query Rule - Heartbeat Missing
################################################################################

module "alert_heartbeat" {
  source = "../../"

  name                = "alert-heartbeat-missing"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  scopes              = [azurerm_log_analytics_workspace.main.id]
  description         = "Alert when heartbeat is missing"
  severity            = 0
  evaluation_frequency = "PT5M"
  window_duration      = "PT10M"

  criteria = {
    query                   = <<-QUERY
      Heartbeat
      | summarize LastHeartbeat = max(TimeGenerated) by Computer
      | where LastHeartbeat < ago(10m)
    QUERY
    time_aggregation_method = "Count"
    threshold               = 0
    operator                = "GreaterThan"
  }

  action_group_ids = [module.action_group.id]

  tags = {
    Environment = "Example"
  }
}

################################################################################
# Outputs
################################################################################

output "error_alert_id" {
  description = "The ID of the error count alert."
  value       = module.alert_error_count.id
}

output "heartbeat_alert_id" {
  description = "The ID of the heartbeat alert."
  value       = module.alert_heartbeat.id
}
