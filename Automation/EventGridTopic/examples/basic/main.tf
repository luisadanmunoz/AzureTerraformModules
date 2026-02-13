# ==============================================================================
# Basic Example - Azure Event Grid Topic
# ==============================================================================

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

# ==============================================================================
# Resource Group
# ==============================================================================

resource "azurerm_resource_group" "example" {
  name     = "rg-eventgrid-example"
  location = "eastus"
}

# ==============================================================================
# Event Grid Topic - Basic
# ==============================================================================

module "eventgrid_topic" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name_prefix = "evgt"
  workload    = "myapp"
  environment = "dev"
  instance    = "001"

  # Use default EventGridSchema
  input_schema = "EventGridSchema"

  # Enable public network access and local authentication
  public_network_access_enabled = true
  local_auth_enabled            = true

  tags = {
    Project     = "EventGridExample"
    Environment = "Development"
  }
}

# ==============================================================================
# Outputs
# ==============================================================================

output "eventgrid_topic_id" {
  description = "The ID of the Event Grid Topic."
  value       = module.eventgrid_topic.id
}

output "eventgrid_topic_name" {
  description = "The name of the Event Grid Topic."
  value       = module.eventgrid_topic.name
}

output "eventgrid_topic_endpoint" {
  description = "The endpoint URI of the Event Grid Topic."
  value       = module.eventgrid_topic.endpoint
}
