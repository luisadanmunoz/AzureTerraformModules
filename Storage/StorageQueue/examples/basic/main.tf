################################################################################
# Basic Example - Storage Queue Module
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
# Resource Group (DEPENDENCY for Storage Account)
################################################################################

resource "azurerm_resource_group" "example" {
  name     = "rg-storagequeue-example-dev-001"
  location = "westeurope"

  tags = {
    Environment = "Development"
    Example     = "StorageQueue-Basic"
  }
}

################################################################################
# Storage Account (DEPENDENCY for Storage Queue)
################################################################################

resource "azurerm_storage_account" "example" {
  name                     = "stqueueexampledev001"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = "Development"
    Example     = "StorageQueue-Basic"
  }
}

################################################################################
# Single Storage Queue
################################################################################

module "single_queue" {
  source = "../../"

  # DEPENDENCY: Storage Account must exist
  storage_account_name = azurerm_storage_account.example.name

  # Explicit naming
  name = "orders-queue"

  metadata = {
    purpose = "order-processing"
    team    = "backend"
  }

  tags = {
    Environment = "Development"
    Project     = "Example"
    ManagedBy   = "Terraform"
  }
}

################################################################################
# Multiple Storage Queues
################################################################################

module "multiple_queues" {
  source = "../../"

  # DEPENDENCY: Storage Account must exist
  storage_account_name = azurerm_storage_account.example.name

  queues = {
    "notifications-queue" = {
      metadata = {
        purpose = "email-notifications"
        team    = "communications"
      }
    }
    "audit-queue" = {
      metadata = {
        purpose = "audit-logging"
      }
    }
    "deadletter-queue" = {
      metadata = {}
    }
  }

  tags = {
    Environment = "Development"
    Project     = "Example"
    ManagedBy   = "Terraform"
  }
}

################################################################################
# Outputs
################################################################################

output "single_queue_id" {
  description = "The ID of the single Storage Queue"
  value       = module.single_queue.id
}

output "single_queue_name" {
  description = "The name of the single Storage Queue"
  value       = module.single_queue.name
}

output "multiple_queue_ids" {
  description = "Map of queue names to their IDs"
  value       = module.multiple_queues.queue_ids
}

output "multiple_queue_names" {
  description = "Map of queue keys to their names"
  value       = module.multiple_queues.queue_names
}
