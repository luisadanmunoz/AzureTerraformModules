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
# Data Sources
################################################################################

data "azurerm_subscription" "current" {}

################################################################################
# Resource Group
################################################################################

resource "azurerm_resource_group" "main" {
  name     = "rg-activity-log-alert-example"
  location = "eastus"
}

################################################################################
# Action Group
################################################################################

module "action_group" {
  source = "../../../ActionGroup"

  name                = "ag-activity-alerts"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "activity"

  email_receivers = [
    {
      name          = "admin"
      email_address = "admin@contoso.com"
    }
  ]
}

################################################################################
# Activity Log Alert - Service Health
################################################################################

module "alert_service_health" {
  source = "../../"

  name                = "alert-service-health"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [data.azurerm_subscription.current.id]
  description         = "Alert on Azure service health incidents"

  criteria = {
    category = "ServiceHealth"
  }

  action_group_ids = [module.action_group.id]

  tags = {
    Environment = "Example"
  }
}

################################################################################
# Activity Log Alert - Resource Deletion
################################################################################

module "alert_resource_delete" {
  source = "../../"

  name                = "alert-resource-delete"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [data.azurerm_subscription.current.id]
  description         = "Alert on VM deletions"

  criteria = {
    category       = "Administrative"
    operation_name = "Microsoft.Compute/virtualMachines/delete"
    level          = "Critical"
  }

  action_group_ids = [module.action_group.id]

  tags = {
    Environment = "Example"
  }
}

################################################################################
# Outputs
################################################################################

output "service_health_alert_id" {
  description = "The ID of the service health alert."
  value       = module.alert_service_health.id
}

output "resource_delete_alert_id" {
  description = "The ID of the resource deletion alert."
  value       = module.alert_resource_delete.id
}
