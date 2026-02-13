################################################################################
# Basic Example - Logic App (Consumption) Module
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
  name     = "rg-logicapp-example-dev-001"
  location = "westeurope"
}

################################################################################
# Logic App with System Assigned Identity
################################################################################

module "logic_app" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "logic-process-orders-dev-001"

  enabled = true

  identity = {
    type = "SystemAssigned"
  }

  # Optional: Restrict trigger access to specific IPs
  access_control = {
    trigger = {
      allowed_caller_ip_address_range = ["10.0.0.0/8"]
    }
  }

  tags = {
    Environment = "Development"
    Purpose     = "Order Processing"
  }
}

################################################################################
# Logic App with Parameters
################################################################################

module "logic_app_parameterized" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "logic-notifications-dev-001"

  workflow_parameters = {
    "environment" = jsonencode({
      defaultValue = "development"
      type         = "String"
    })
    "notificationEmail" = jsonencode({
      defaultValue = "admin@example.com"
      type         = "String"
    })
  }

  parameters = {
    "environment"       = "\"development\""
    "notificationEmail" = "\"dev-team@example.com\""
  }

  tags = {
    Environment = "Development"
    Purpose     = "Notifications"
  }
}

################################################################################
# Outputs
################################################################################

output "logic_app_id" {
  value = module.logic_app.id
}

output "logic_app_access_endpoint" {
  value = module.logic_app.access_endpoint
}

output "logic_app_principal_id" {
  value = module.logic_app.principal_id
}

output "parameterized_logic_app_id" {
  value = module.logic_app_parameterized.id
}
