################################################################################
# Provider Configuration
################################################################################

provider "azurerm" {
  features {}
}

################################################################################
# Resource Group
################################################################################

resource "azurerm_resource_group" "example" {
  name     = "rg-lifecycle-example"
  location = "East US 2"
}

################################################################################
# Storage Account
################################################################################

resource "azurerm_storage_account" "example" {
  name                     = "stlifecycleexample001"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"

  blob_properties {
    versioning_enabled       = true
    last_access_time_enabled = true
  }

  tags = {
    Environment = "example"
  }
}

################################################################################
# Storage Management Policy (Lifecycle)
################################################################################

module "lifecycle_policy" {
  source = "../../"

  storage_account_id = azurerm_storage_account.example.id

  rules = [
    # Rule 1: Tier and delete base blobs in the logs container
    {
      name    = "manage-logs-lifecycle"
      enabled = true
      filters = {
        blob_types   = ["blockBlob"]
        prefix_match = ["logs/"]
      }
      actions = {
        base_blob = {
          tier_to_cool_after_days    = 30
          tier_to_archive_after_days = 90
          delete_after_days          = 365
        }
      }
    },
    # Rule 2: Clean up old snapshots and versions
    {
      name    = "cleanup-snapshots-and-versions"
      enabled = true
      filters = {
        blob_types = ["blockBlob"]
      }
      actions = {
        snapshot = {
          change_tier_to_cool_after_days    = 30
          change_tier_to_archive_after_days = 90
          delete_after_days                 = 180
        }
        version = {
          change_tier_to_cool_after_days    = 30
          change_tier_to_archive_after_days = 90
          delete_after_days                 = 180
        }
      }
    },
    # Rule 3: Delete temporary data after 7 days
    {
      name    = "delete-temporary-data"
      enabled = true
      filters = {
        blob_types   = ["blockBlob"]
        prefix_match = ["tmp/", "temp/"]
      }
      actions = {
        base_blob = {
          delete_after_days = 7
        }
      }
    }
  ]

  tags = {
    Environment = "example"
    Project     = "lifecycle-demo"
  }
}

################################################################################
# Outputs
################################################################################

output "policy_id" {
  description = "The ID of the lifecycle management policy."
  value       = module.lifecycle_policy.id
}
