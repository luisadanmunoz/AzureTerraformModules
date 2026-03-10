# ------------------------------------------------------------------------------
# BASIC PREMIUM SSD MANAGED DISK EXAMPLE
# ------------------------------------------------------------------------------
# This example demonstrates how to create a basic Premium SSD Managed Disk
# using the ManagedDisk module.
# ------------------------------------------------------------------------------

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

# ------------------------------------------------------------------------------
# RESOURCE GROUP
# ------------------------------------------------------------------------------

resource "azurerm_resource_group" "example" {
  name     = "rg-managed-disk-example"
  location = "eastus"

  tags = {
    Environment = "example"
    Project     = "terraform-managed-disk"
  }
}

# ------------------------------------------------------------------------------
# PREMIUM SSD MANAGED DISK
# ------------------------------------------------------------------------------

module "premium_disk" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Explicit naming
  name = "disk-premium-example"

  # Disk configuration
  storage_account_type = "Premium_LRS"
  disk_size_gb         = 128

  # Optional: Place in Availability Zone 1
  zone = "1"

  # Optional: Enable on-demand bursting for Premium disks
  on_demand_bursting_enabled = true

  tags = {
    Environment = "example"
    Project     = "terraform-managed-disk"
    DiskType    = "Premium"
  }
}

# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------

output "disk_id" {
  description = "The ID of the Premium Managed Disk."
  value       = module.premium_disk.id
}

output "disk_name" {
  description = "The name of the Premium Managed Disk."
  value       = module.premium_disk.name
}

output "disk_size_gb" {
  description = "The size of the Premium Managed Disk in GB."
  value       = module.premium_disk.disk_size_gb
}

output "disk_storage_account_type" {
  description = "The storage account type of the Managed Disk."
  value       = module.premium_disk.storage_account_type
}
