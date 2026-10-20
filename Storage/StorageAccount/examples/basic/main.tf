################################################################################
# Basic Example - Storage Account Module
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
  name     = "rg-storage-example-dev-001"
  location = "westeurope"

  tags = {
    Environment = "Development"
    Example     = "StorageAccount-Basic"
  }
}

################################################################################
# Storage Account Module
################################################################################

module "storage_account" {
  source = "../../"

  # DEPENDENCY: Resource Group must exist
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Explicit naming (3-24 chars, lowercase letters and numbers only)
  name = "stexampledev001"

  # Basic configuration
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"

  # Enable blob versioning and soft delete
  blob_properties = {
    versioning_enabled  = true
    change_feed_enabled = true
    delete_retention_policy = {
      days = 7
    }
    container_delete_retention_policy = {
      days = 7
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

output "storage_account_id" {
  description = "The ID of the created Storage Account"
  value       = module.storage_account.id
}

output "storage_account_name" {
  description = "The name of the created Storage Account"
  value       = module.storage_account.name
}

output "primary_blob_endpoint" {
  description = "The primary blob endpoint of the Storage Account"
  value       = module.storage_account.primary_blob_endpoint
}
