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
  name     = "rg-metric-alert-example"
  location = "eastus"
}

################################################################################
# Action Group
################################################################################

module "action_group" {
  source = "../../../ActionGroup"

  name                = "ag-alerts-example"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "alerts"

  email_receivers = [
    {
      name          = "admin"
      email_address = "admin@contoso.com"
    }
  ]
}

################################################################################
# Storage Account (target resource)
################################################################################

resource "azurerm_storage_account" "main" {
  name                     = "stmetricalertexample"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

################################################################################
# Metric Alert - Storage Availability
################################################################################

module "alert_storage_availability" {
  source = "../../"

  name                = "alert-storage-availability"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_storage_account.main.id]
  description         = "Alert when storage availability drops below 99%"
  severity            = 1
  frequency           = "PT5M"
  window_size         = "PT15M"

  criteria = [
    {
      metric_namespace = "Microsoft.Storage/storageAccounts"
      metric_name      = "Availability"
      aggregation      = "Average"
      operator         = "LessThan"
      threshold        = 99
    }
  ]

  action_group_ids = [module.action_group.id]

  tags = {
    Environment = "Example"
  }
}

################################################################################
# Metric Alert - Storage Latency
################################################################################

module "alert_storage_latency" {
  source = "../../"

  name                = "alert-storage-latency"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_storage_account.main.id]
  description         = "Alert when storage latency exceeds 100ms"
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT15M"

  criteria = [
    {
      metric_namespace = "Microsoft.Storage/storageAccounts"
      metric_name      = "SuccessE2ELatency"
      aggregation      = "Average"
      operator         = "GreaterThan"
      threshold        = 100
    }
  ]

  action_group_ids = [module.action_group.id]

  tags = {
    Environment = "Example"
  }
}

################################################################################
# Outputs
################################################################################

output "availability_alert_id" {
  description = "The ID of the availability alert."
  value       = module.alert_storage_availability.id
}

output "latency_alert_id" {
  description = "The ID of the latency alert."
  value       = module.alert_storage_latency.id
}
