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
  name     = "rg-datalake-example-dev"
  location = "East US 2"
}

################################################################################
# Storage Account (HNS-enabled for Data Lake Gen2)
################################################################################

# DEPENDENCY: Storage Account must have is_hns_enabled=true for Data Lake Gen2
resource "azurerm_storage_account" "example" {
  name                     = "stadatalakeexdev001"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true # Required for Data Lake Gen2

  tags = {
    environment = "dev"
  }
}

################################################################################
# Data Lake Gen2 Filesystem
################################################################################

module "datalake_filesystem" {
  source = "../../"

  storage_account_id = azurerm_storage_account.example.id # DEPENDENCY: HNS-enabled Storage Account

  name_prefix = "dlfs"
  workload    = "analytics"
  environment = "dev"
  instance    = "001"

  properties = {
    "purpose" = "raw-data-ingestion"
  }

  ace = [
    {
      scope       = "access"
      type        = "user"
      permissions = "rwx"
    },
    {
      scope       = "access"
      type        = "group"
      permissions = "r-x"
    },
    {
      scope       = "access"
      type        = "other"
      permissions = "---"
    }
  ]

  paths = {
    landing = {
      path     = "landing"
      resource = "directory"
    }
    processed = {
      path     = "processed"
      resource = "directory"
    }
    curated = {
      path     = "curated"
      resource = "directory"
    }
  }

  tags = {
    project     = "data-platform"
    environment = "dev"
  }
}

################################################################################
# Outputs
################################################################################

output "filesystem_id" {
  description = "The ID of the Data Lake Gen2 Filesystem."
  value       = module.datalake_filesystem.id
}

output "filesystem_name" {
  description = "The name of the Data Lake Gen2 Filesystem."
  value       = module.datalake_filesystem.name
}

output "path_ids" {
  description = "Map of directory path keys to their resource IDs."
  value       = module.datalake_filesystem.path_ids
}
