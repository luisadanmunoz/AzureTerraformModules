################################################################################
# Example: Availability Set
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# ──────────────────────────────────────────────────────────────────────────────
# Resource Group
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_resource_group" "example" {
  name     = "rg-avset-dev-001"
  location = "westeurope"
}

# ──────────────────────────────────────────────────────────────────────────────
# Availability Set
# ──────────────────────────────────────────────────────────────────────────────

module "availability_set" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "web"
  environment = "dev"

  platform_fault_domain_count  = 2
  platform_update_domain_count = 5

  tags = {
    Environment = "Development"
    Purpose     = "HighAvailability"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "availability_set_id" {
  description = "Availability Set ID"
  value       = module.availability_set.id
}

output "availability_set_name" {
  description = "Availability Set name"
  value       = module.availability_set.name
}
