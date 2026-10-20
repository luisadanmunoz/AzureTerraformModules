################################################################################
# Azure Blob Container - Basic Example
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
  name     = "rg-blobcontainer-example"
  location = "East US 2"
}

################################################################################
# Storage Account (DEPENDENCY: Required for Blob Container)
################################################################################

resource "azurerm_storage_account" "example" {
  name                     = "stblobexample001"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = "example"
  }
}

################################################################################
# Blob Container
################################################################################

module "blob_container" {
  source = "../../"

  # DEPENDENCY: Storage Account must exist
  storage_account_id = azurerm_storage_account.example.id

  # Naming
  name_prefix = "blob"
  workload    = "data"
  environment = "dev"
  instance    = "001"

  # Container configuration
  container_access_type = "private"

  # Metadata
  metadata = {
    purpose = "example"
    team    = "platform"
  }

  # Tags
  tags = {
    Environment = "example"
    Project     = "blob-container-demo"
  }
}

################################################################################
# Outputs
################################################################################

output "container_id" {
  description = "The ID of the created Blob Container."
  value       = module.blob_container.id
}

output "container_name" {
  description = "The name of the created Blob Container."
  value       = module.blob_container.name
}

output "container_resource_manager_id" {
  description = "The Resource Manager ID of the created Blob Container."
  value       = module.blob_container.resource_manager_id
}
