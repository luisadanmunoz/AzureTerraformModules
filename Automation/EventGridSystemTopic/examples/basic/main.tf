# -----------------------------------------------------------------------------
# Basic Example - Storage Account System Topic with Blob Created Subscription
# -----------------------------------------------------------------------------
# This example demonstrates how to create an Event Grid System Topic for a
# Storage Account and subscribe to blob created events using a webhook endpoint.
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
    Purpose     = "EventGridSystemTopicDemo"
  }
}

# -----------------------------------------------------------------------------
# Storage Account (Source Resource for System Topic)
# -----------------------------------------------------------------------------

resource "azurerm_storage_account" "example" {
  name                     = "stexampleevgst001"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = "Example"
    Purpose     = "EventGridSystemTopicDemo"
  }
}

# -----------------------------------------------------------------------------
# Storage Container for Blob Uploads
# -----------------------------------------------------------------------------

resource "azurerm_storage_container" "uploads" {
  name                  = "uploads"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

# -----------------------------------------------------------------------------
# Event Grid System Topic Module
# -----------------------------------------------------------------------------

module "eventgrid_system_topic" {
  source = "../../"

  # Required parameters
  resource_group_name    = azurerm_resource_group.example.name
  location               = azurerm_resource_group.example.location
  source_arm_resource_id = azurerm_storage_account.example.id
  topic_type             = "Microsoft.Storage.StorageAccounts"

  # Naming configuration
  workload    = "storage"
  environment = "dev"
  instance    = "001"

  # Enable System Assigned Managed Identity
  identity = {
    type = "SystemAssigned"
  }

  # Event Subscriptions
  event_subscriptions = {
    # Subscription for blob created events
    "blob-created-webhook" = {
      # Only subscribe to BlobCreated events
      included_event_types = ["Microsoft.Storage.BlobCreated"]

      # Filter to only receive events from the uploads container
      subject_filter = {
        subject_begins_with = "/blobServices/default/containers/uploads/"
        case_sensitive      = false
      }

      # Webhook endpoint configuration
      # Replace with your actual webhook URL
      webhook_endpoint = {
        url                               = "https://example.com/api/blob-events"
        max_events_per_batch              = 1
        preferred_batch_size_in_kilobytes = 64
      }

      # Retry policy for failed deliveries
      retry_policy = {
        max_delivery_attempts = 30
        event_time_to_live    = 1440 # 24 hours in minutes
      }

      # Labels for organization
      labels = ["blob-events", "uploads", "example"]
    }

    # Subscription for blob deleted events
    "blob-deleted-webhook" = {
      included_event_types = ["Microsoft.Storage.BlobDeleted"]

      subject_filter = {
        subject_begins_with = "/blobServices/default/containers/uploads/"
      }

      webhook_endpoint = {
        url = "https://example.com/api/blob-deleted-events"
      }
    }
  }

  # Tags
  tags = {
    Environment = "Development"
    Project     = "EventGridExample"
    ManagedBy   = "Terraform"
  }
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "system_topic_id" {
  description = "The ID of the Event Grid System Topic"
  value       = module.eventgrid_system_topic.id
}

output "system_topic_name" {
  description = "The name of the Event Grid System Topic"
  value       = module.eventgrid_system_topic.name
}

output "system_topic_principal_id" {
  description = "The Principal ID of the System Assigned Managed Identity"
  value       = module.eventgrid_system_topic.principal_id
}

output "event_subscription_ids" {
  description = "Map of event subscription names to their IDs"
  value       = module.eventgrid_system_topic.event_subscription_ids
}

output "metric_arm_resource_id" {
  description = "The Metric ARM Resource ID for monitoring"
  value       = module.eventgrid_system_topic.metric_arm_resource_id
}
