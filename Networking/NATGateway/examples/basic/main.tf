################################################################################
# Basic Example - NAT Gateway Module
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
  name     = "rg-natgw-example-dev-001"
  location = "westeurope"
}

################################################################################
# NAT Gateway Module
################################################################################

module "nat_gateway" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name                    = "ng-spoke-dev-001"
  idle_timeout_in_minutes = 10
  create_public_ip        = true

  tags = {
    Environment = "Development"
  }
}

################################################################################
# Outputs
################################################################################

output "nat_gateway_id" {
  value = module.nat_gateway.id
}

output "public_ip_address" {
  value = module.nat_gateway.public_ip_address
}
