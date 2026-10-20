# -----------------------------------------------------------------------------
# Basic Example: Azure Event Grid Domain with Domain Topics
# -----------------------------------------------------------------------------
# This example demonstrates how to create an Event Grid Domain with multiple
# domain topics for organizing events by category.
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
  name     = "rg-eventgrid-example"
  location = "eastus"

  tags = {
    Environment = "Example"
    Purpose     = "EventGridDomain Demo"
  }
}

# -----------------------------------------------------------------------------
# Event Grid Domain with Topics
# -----------------------------------------------------------------------------
module "eventgrid_domain" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Naming using components
  workload    = "ecommerce"
  environment = "dev"
  instance    = "001"

  # Enable managed identity for secure access
  identity = {
    type = "SystemAssigned"
  }

  # Domain configuration
  input_schema                              = "EventGridSchema"
  public_network_access_enabled             = true
  local_auth_enabled                        = true
  auto_create_topic_with_first_subscription = true
  auto_delete_topic_with_last_subscription  = true

  # Create domain topics for different event categories
  domain_topics = {
    orders = {
      name = "orders"
    }
    customers = {
      name = "customers"
    }
    inventory = {
      name = "inventory"
    }
    payments = {
      name = "payments"
    }
    notifications = {
      name = "notifications"
    }
  }

  tags = {
    Environment = "Development"
    Application = "E-Commerce Platform"
    CostCenter  = "IT-001"
  }
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------
output "domain_id" {
  description = "The ID of the Event Grid Domain"
  value       = module.eventgrid_domain.id
}

output "domain_name" {
  description = "The name of the Event Grid Domain"
  value       = module.eventgrid_domain.name
}

output "domain_endpoint" {
  description = "The endpoint of the Event Grid Domain"
  value       = module.eventgrid_domain.endpoint
}

output "domain_topic_ids" {
  description = "Map of domain topic names to their IDs"
  value       = module.eventgrid_domain.domain_topic_ids
}

output "principal_id" {
  description = "The Principal ID of the system-assigned managed identity"
  value       = module.eventgrid_domain.principal_id
}
