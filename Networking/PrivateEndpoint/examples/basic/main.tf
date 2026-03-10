################################################################################
# Basic Example - Private Endpoint Module
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
  name     = "rg-pe-example-dev-001"
  location = "westeurope"
}

################################################################################
# Virtual Network and Subnet (DEPENDENCIES)
################################################################################

resource "azurerm_virtual_network" "example" {
  name                = "vnet-example-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "pe" {
  name                 = "snet-privateendpoints"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.250.0/24"]

  private_endpoint_network_policies = "Disabled"
}

################################################################################
# Storage Account (Target Resource)
################################################################################

resource "azurerm_storage_account" "example" {
  name                     = "stpeexample${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  public_network_access_enabled = false
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

################################################################################
# Private DNS Zone
################################################################################

resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob" {
  name                  = "link-vnet-example"
  resource_group_name   = azurerm_resource_group.example.name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = azurerm_virtual_network.example.id
}

################################################################################
# Private Endpoint Module
################################################################################

module "pe_storage_blob" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  subnet_id           = azurerm_subnet.pe.id

  name = "pe-stpeexample-blob"

  private_service_connection = {
    name                           = "psc-stpeexample-blob"
    private_connection_resource_id = azurerm_storage_account.example.id
    subresource_names              = ["blob"]
  }

  private_dns_zone_group = {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.blob.id]
  }

  tags = {
    Environment = "Development"
    Service     = "Storage"
  }
}

################################################################################
# Outputs
################################################################################

output "private_endpoint_id" {
  value = module.pe_storage_blob.id
}

output "private_ip_address" {
  value = module.pe_storage_blob.private_ip_address
}

output "storage_account_name" {
  value = azurerm_storage_account.example.name
}
