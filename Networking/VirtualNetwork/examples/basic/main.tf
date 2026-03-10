################################################################################
# Basic Example - Virtual Network Module
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
# Resource Group (DEPENDENCY for VNet)
################################################################################

resource "azurerm_resource_group" "example" {
  name     = "rg-vnet-example-dev-001"
  location = "westeurope"

  tags = {
    Environment = "Development"
    Example     = "VirtualNetwork-Basic"
  }
}

################################################################################
# Virtual Network Module
################################################################################

module "vnet" {
  source = "../../"

  # DEPENDENCY: Resource Group must exist
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Explicit naming
  name          = "vnet-example-dev-001"
  address_space = ["10.0.0.0/16"]

  # Custom DNS servers (optional - uses Azure DNS if empty)
  dns_servers = []

  # Inline subnets (optional)
  subnets = {
    "snet-default" = {
      address_prefixes = ["10.0.0.0/24"]
    }
    "snet-workloads" = {
      address_prefixes  = ["10.0.1.0/24"]
      service_endpoints = ["Microsoft.Storage"]
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

output "vnet_id" {
  description = "The ID of the created Virtual Network"
  value       = module.vnet.id
}

output "vnet_name" {
  description = "The name of the created Virtual Network"
  value       = module.vnet.name
}

output "subnet_ids" {
  description = "Map of subnet names to their IDs"
  value       = module.vnet.subnet_ids
}
