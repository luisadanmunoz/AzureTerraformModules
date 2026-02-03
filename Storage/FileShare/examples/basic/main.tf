################################################################################
# Azure File Share - Basic Example
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
# Resource Group
################################################################################

resource "azurerm_resource_group" "example" {
  name     = "rg-fileshare-example"
  location = "East US"
}

################################################################################
# Storage Account (DEPENDENCY: required before File Share)
################################################################################

resource "azurerm_storage_account" "example" {
  name                     = "stfileshareexample001"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  tags = {
    Environment = "example"
  }
}

################################################################################
# File Share Module - SMB (Basic)
################################################################################

module "file_share_smb" {
  source = "../../"

  name               = "documents"
  storage_account_id = azurerm_storage_account.example.id # DEPENDENCY: Storage Account
  quota              = 50
  access_tier        = "TransactionOptimized"
  enabled_protocol   = "SMB"

  metadata = {
    purpose = "document-storage"
  }

  acl = [
    {
      id = "read-access"
      access_policy = {
        permissions = "rl"
        start       = "2025-01-01T00:00:00Z"
        expiry      = "2025-12-31T23:59:59Z"
      }
    }
  ]

  tags = {
    Environment = "example"
    Project     = "fileshare-demo"
  }
}

################################################################################
# Outputs
################################################################################

output "file_share_id" {
  description = "The ID of the File Share."
  value       = module.file_share_smb.id
}

output "file_share_name" {
  description = "The name of the File Share."
  value       = module.file_share_smb.name
}

output "file_share_url" {
  description = "The URL of the File Share."
  value       = module.file_share_smb.url
}

output "file_share_resource_manager_id" {
  description = "The Resource Manager ID of the File Share."
  value       = module.file_share_smb.resource_manager_id
}
