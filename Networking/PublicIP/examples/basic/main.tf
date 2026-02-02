################################################################################
# Basic Example - Public IP Module
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
  name     = "rg-pip-example-dev-001"
  location = "westeurope"
}

################################################################################
# Public IP Module - Standard Zone-Redundant
################################################################################

module "pip_standard" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name              = "pip-standard-dev-001"
  sku               = "Standard"
  allocation_method = "Static"
  zones             = ["1", "2", "3"]

  tags = {
    Environment = "Development"
  }
}

################################################################################
# Public IP Module - With DNS Label
################################################################################

module "pip_with_dns" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name              = "pip-web-dev-001"
  domain_name_label = "myapp-example-dev"

  tags = {
    Environment = "Development"
    Purpose     = "WebApp"
  }
}

################################################################################
# Outputs
################################################################################

output "pip_standard_ip" {
  value = module.pip_standard.ip_address
}

output "pip_with_dns_fqdn" {
  value = module.pip_with_dns.fqdn
}
