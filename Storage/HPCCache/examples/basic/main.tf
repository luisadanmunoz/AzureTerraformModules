# -----------------------------------------------------------------------------
# BASIC AZURE HPC CACHE EXAMPLE
# -----------------------------------------------------------------------------
# This example demonstrates a basic deployment of Azure HPC Cache with minimal
# configuration required for a functional cache instance.
# -----------------------------------------------------------------------------

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

# -----------------------------------------------------------------------------
# RESOURCE GROUP
# -----------------------------------------------------------------------------

resource "azurerm_resource_group" "example" {
  name     = "rg-hpccache-example"
  location = "eastus"
}

# -----------------------------------------------------------------------------
# VIRTUAL NETWORK AND SUBNET
# -----------------------------------------------------------------------------

resource "azurerm_virtual_network" "example" {
  name                = "vnet-hpccache-example"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "hpc_cache" {
  name                 = "snet-hpccache"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]

  service_endpoints = ["Microsoft.StorageCache"]
}

# -----------------------------------------------------------------------------
# HPC CACHE MODULE
# -----------------------------------------------------------------------------

module "hpc_cache" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Naming
  name_prefix = "hpc"
  workload    = "example"
  environment = "dev"

  # Cache configuration
  cache_size_in_gb = 3072
  sku_name         = "Standard_2G"
  subnet_id        = azurerm_subnet.hpc_cache.id

  # Optional: Custom NTP server
  ntp_server = "time.windows.com"

  # Optional: MTU configuration
  mtu = 1500

  tags = {
    Environment = "Development"
    Project     = "HPC-Example"
    ManagedBy   = "Terraform"
  }
}

# -----------------------------------------------------------------------------
# OUTPUTS
# -----------------------------------------------------------------------------

output "hpc_cache_id" {
  description = "The ID of the HPC Cache"
  value       = module.hpc_cache.id
}

output "hpc_cache_name" {
  description = "The name of the HPC Cache"
  value       = module.hpc_cache.name
}

output "hpc_cache_mount_addresses" {
  description = "The mount addresses for the HPC Cache"
  value       = module.hpc_cache.mount_addresses
}
