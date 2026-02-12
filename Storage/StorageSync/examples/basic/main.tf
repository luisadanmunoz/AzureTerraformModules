################################################################################
# Basic Example - Storage Sync Module
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
# Resource Group (DEPENDENCY for Storage Sync)
################################################################################

resource "azurerm_resource_group" "example" {
  name     = "rg-storagesync-example-dev-001"
  location = "westeurope"

  tags = {
    Environment = "Development"
    Example     = "StorageSync-Basic"
  }
}

################################################################################
# Storage Account (DEPENDENCY for Cloud Endpoint)
################################################################################

resource "azurerm_storage_account" "example" {
  name                     = "stexamplefilesync001"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  tags = {
    Environment = "Development"
    Example     = "StorageSync-Basic"
  }
}

################################################################################
# File Share (DEPENDENCY for Cloud Endpoint)
################################################################################

resource "azurerm_storage_share" "example" {
  name                 = "documents-share"
  storage_account_name = azurerm_storage_account.example.name
  quota                = 50
}

################################################################################
# Storage Sync Module
################################################################################

module "storage_sync" {
  source = "../../"

  # DEPENDENCY: Resource Group must exist
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Explicit naming
  name = "ss-example-dev-001"

  # Traffic policy
  incoming_traffic_policy = "AllowAllTraffic"

  # Create a sync group
  sync_groups = {
    "documents" = {
      name = "sync-group-documents"
    }
  }

  # Create a cloud endpoint for the sync group
  cloud_endpoints = {
    "documents-cloud" = {
      sync_group_key     = "documents"
      file_share_name    = azurerm_storage_share.example.name
      storage_account_id = azurerm_storage_account.example.id
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

output "storage_sync_id" {
  description = "The ID of the created Storage Sync Service"
  value       = module.storage_sync.id
}

output "storage_sync_name" {
  description = "The name of the created Storage Sync Service"
  value       = module.storage_sync.name
}

output "sync_group_ids" {
  description = "Map of Sync Group keys to their IDs"
  value       = module.storage_sync.sync_group_ids
}

output "cloud_endpoint_ids" {
  description = "Map of Cloud Endpoint keys to their IDs"
  value       = module.storage_sync.cloud_endpoint_ids
}
