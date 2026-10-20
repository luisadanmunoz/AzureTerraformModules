################################################################################
# Basic Example - Automation Variable Module
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

resource "azurerm_automation_account" "example" {
  name                = "aa-variables-example-dev-001"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "Basic"
}

################################################################################
# Automation Variables - All Types
################################################################################

module "automation_variables" {
  source = "../../"

  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name

  # String Variables
  string_variables = {
    "Environment" = {
      value       = "Development"
      description = "Current environment"
    }
    "SubscriptionId" = {
      value       = "00000000-0000-0000-0000-000000000000"
      description = "Target subscription"
    }
    "ApiKey" = {
      value       = "super-secret-api-key"
      description = "External API key"
      encrypted   = true
    }
  }

  # Integer Variables
  int_variables = {
    "MaxRetries" = {
      value       = 3
      description = "Maximum retry attempts"
    }
    "TimeoutMinutes" = {
      value       = 30
      description = "Operation timeout"
    }
  }

  # Boolean Variables
  bool_variables = {
    "EnableNotifications" = {
      value       = true
      description = "Send notifications on completion"
    }
    "DryRun" = {
      value       = false
      description = "Run without making changes"
    }
  }

  # DateTime Variables
  datetime_variables = {
    "LastMaintenance" = {
      value       = "2024-01-01T00:00:00Z"
      description = "Last maintenance date"
    }
  }

  # Object/JSON Variables
  object_variables = {
    "VMConfig" = {
      value = {
        allowed_sizes = ["Standard_D2s_v3", "Standard_D4s_v3"]
        allowed_regions = ["westeurope", "northeurope"]
        max_instances = 10
      }
      description = "VM configuration settings"
    }
    "Credentials" = {
      value = {
        username = "admin"
        password = "secret123"
      }
      description = "Service credentials"
      encrypted   = true
    }
  }
}

################################################################################
# Outputs
################################################################################

output "string_variable_ids" {
  value = module.automation_variables.string_variable_ids
}

output "int_variable_ids" {
  value = module.automation_variables.int_variable_ids
}

output "bool_variable_ids" {
  value = module.automation_variables.bool_variable_ids
}

output "all_variable_ids" {
  value = module.automation_variables.all_variable_ids
}
