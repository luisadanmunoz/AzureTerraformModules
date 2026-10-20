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

# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "rg-eventgrid-subscription-example"
  location = "East US"
}

# Storage Account to subscribe to
resource "azurerm_storage_account" "example" {
  name                     = "stexampleegsub"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Example 1: Basic Webhook Subscription
module "webhook_subscription" {
  source = "../../"

  name  = "webhook-blob-events"
  scope = azurerm_storage_account.example.id

  webhook_endpoint = {
    url                               = "https://myapp.azurewebsites.net/api/eventgrid"
    max_events_per_batch              = 1
    preferred_batch_size_in_kilobytes = 64
  }

  included_event_types = [
    "Microsoft.Storage.BlobCreated",
    "Microsoft.Storage.BlobDeleted"
  ]

  subject_filter = {
    subject_begins_with = "/blobServices/default/containers/uploads"
    subject_ends_with   = ".json"
    case_sensitive      = false
  }

  retry_policy = {
    max_delivery_attempts = 30
    event_time_to_live    = 1440
  }

  labels = ["example", "webhook", "storage"]
}

# Example 2: Subscription with Advanced Filtering
module "filtered_subscription" {
  source = "../../"

  name  = "filtered-blob-events"
  scope = azurerm_storage_account.example.id

  webhook_endpoint = {
    url = "https://myapp.azurewebsites.net/api/filtered-events"
  }

  included_event_types = [
    "Microsoft.Storage.BlobCreated"
  ]

  advanced_filtering_on_arrays_enabled = true

  advanced_filter = {
    string_ends_with = [
      {
        key    = "subject"
        values = [".jpg", ".png", ".gif"]
      }
    ]
    number_greater_than = [
      {
        key   = "data.contentLength"
        value = 1024
      }
    ]
  }
}

# Example 3: Disabled Subscription (create = false)
module "disabled_subscription" {
  source = "../../"

  create = false
  name   = "disabled-subscription"
  scope  = azurerm_storage_account.example.id

  webhook_endpoint = {
    url = "https://example.com/events"
  }
}

# Outputs
output "webhook_subscription_id" {
  description = "The ID of the webhook subscription"
  value       = module.webhook_subscription.id
}

output "webhook_subscription_name" {
  description = "The name of the webhook subscription"
  value       = module.webhook_subscription.name
}

output "filtered_subscription_id" {
  description = "The ID of the filtered subscription"
  value       = module.filtered_subscription.id
}

output "disabled_subscription_id" {
  description = "The ID of the disabled subscription (should be null)"
  value       = module.disabled_subscription.id
}
