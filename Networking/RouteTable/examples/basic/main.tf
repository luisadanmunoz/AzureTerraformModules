################################################################################
# Basic Example - Route Table Module
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
  name     = "rg-rt-example-dev-001"
  location = "westeurope"
}

################################################################################
# Route Table Module - With Custom Routes
################################################################################

module "route_table" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name                          = "rt-spoke-dev-001"
  bgp_route_propagation_enabled = false

  routes = {
    "to-firewall" = {
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.0.0.4"
    }
    "to-shared-services" = {
      address_prefix = "10.1.0.0/16"
      next_hop_type  = "VnetLocal"
    }
  }

  tags = {
    Environment = "Development"
  }
}

################################################################################
# Outputs
################################################################################

output "route_table_id" {
  value = module.route_table.id
}

output "routes" {
  value = module.route_table.routes
}
