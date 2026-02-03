################################################################################
# Basic Example - StorageTable Module
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
# Resource Group (DEPENDENCY)
################################################################################

resource "azurerm_resource_group" "example" {
  name     = "rg-storagetable-example-dev-001"
  location = "westeurope"

  tags = {
    Environment = "Development"
    Example     = "StorageTable-Basic"
  }
}

################################################################################
# Storage Account (DEPENDENCY for Storage Table)
################################################################################

resource "azurerm_storage_account" "example" {
  name                     = "stexampletabledev001"
  resource_group_name      = azurerm_resource_group.example.name # DEPENDENCY: Resource Group
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = azurerm_resource_group.example.tags
}

################################################################################
# StorageTable Module - Single Table (Basic)
################################################################################

module "storage_table_basic" {
  source = "../../"

  # DEPENDENCY: Storage Account must exist
  storage_account_name = azurerm_storage_account.example.name

  name = "basictable"

  tags = {
    Environment = "Development"
    Example     = "basic"
  }
}

################################################################################
# StorageTable Module - Single Table with ACL
################################################################################

module "storage_table_with_acl" {
  source = "../../"

  # DEPENDENCY: Storage Account must exist
  storage_account_name = azurerm_storage_account.example.name

  name = "tablwithacl"

  acl = [
    {
      id = "readpolicy"
      access_policy = {
        start       = "2025-01-01T00:00:00Z"
        expiry      = "2026-12-31T23:59:59Z"
        permissions = "r"
      }
    },
    {
      id = "fullaccess"
      access_policy = {
        start       = "2025-01-01T00:00:00Z"
        expiry      = "2026-12-31T23:59:59Z"
        permissions = "raud"
      }
    }
  ]

  tags = {
    Environment = "Development"
    Example     = "with-acl"
  }
}

################################################################################
# StorageTable Module - Multiple Tables
################################################################################

module "storage_tables_multiple" {
  source = "../../"

  # DEPENDENCY: Storage Account must exist
  storage_account_name = azurerm_storage_account.example.name

  tables = {
    orders = {
      acl = []
    }
    customers = {
      acl = [
        {
          id = "readonly"
          access_policy = {
            start       = "2025-01-01T00:00:00Z"
            expiry      = "2026-12-31T23:59:59Z"
            permissions = "r"
          }
        }
      ]
    }
    inventory = {
      acl = []
    }
  }

  tags = {
    Environment = "Development"
    Example     = "multiple-tables"
  }
}

################################################################################
# Outputs
################################################################################

output "single_table_id" {
  description = "ID of the basic single storage table"
  value       = module.storage_table_basic.id
}

output "single_table_name" {
  description = "Name of the basic single storage table"
  value       = module.storage_table_basic.name
}

output "acl_table_id" {
  description = "ID of the storage table with ACL"
  value       = module.storage_table_with_acl.id
}

output "multiple_table_ids" {
  description = "IDs of the multiple storage tables"
  value       = module.storage_tables_multiple.table_ids
}

output "multiple_table_names" {
  description = "Names of the multiple storage tables"
  value       = module.storage_tables_multiple.table_names
}
