################################################################################
# Basic Example - Private DNS Zone Module
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
  name     = "rg-dns-example-dev-001"
  location = "westeurope"
}

################################################################################
# Virtual Network (DEPENDENCY for VNet Links)
################################################################################

resource "azurerm_virtual_network" "example" {
  name                = "vnet-example-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

################################################################################
# Private DNS Zone Module - Storage Blob
################################################################################

module "private_dns_blob" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  name                = "privatelink.blob.core.windows.net"

  virtual_network_links = {
    "link-example-vnet" = {
      virtual_network_id   = azurerm_virtual_network.example.id
      registration_enabled = false
    }
  }

  tags = {
    Environment = "Development"
    Service     = "Storage"
  }
}

################################################################################
# Private DNS Zone Module - Custom Internal Zone
################################################################################

module "private_dns_internal" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  name                = "internal.example.com"

  virtual_network_links = {
    "link-example-vnet" = {
      virtual_network_id   = azurerm_virtual_network.example.id
      registration_enabled = true  # VMs auto-register
    }
  }

  a_records = {
    "app1" = {
      ttl     = 300
      records = ["10.0.1.10"]
    }
    "db1" = {
      ttl     = 300
      records = ["10.0.2.10"]
    }
  }

  cname_records = {
    "www" = {
      ttl    = 300
      record = "app1.internal.example.com"
    }
  }

  tags = {
    Environment = "Development"
    Service     = "Internal DNS"
  }
}

################################################################################
# Outputs
################################################################################

output "blob_dns_zone_id" {
  value = module.private_dns_blob.id
}

output "internal_dns_zone_id" {
  value = module.private_dns_internal.id
}

output "internal_a_record_fqdns" {
  value = module.private_dns_internal.a_record_fqdns
}
