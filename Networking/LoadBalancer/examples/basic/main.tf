################################################################################
# Basic Example - Load Balancer Module
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

resource "azurerm_resource_group" "example" {
  name     = "rg-lb-example-dev-001"
  location = "westeurope"
}

resource "azurerm_public_ip" "lb" {
  name                = "pip-lb-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
}

module "lb" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "lb-web-dev-001"

  frontend_ip_configurations = {
    "frontend-public" = {
      public_ip_address_id = azurerm_public_ip.lb.id
    }
  }

  backend_address_pools = {
    "pool-web" = {}
  }

  probes = {
    "probe-http" = {
      protocol     = "Http"
      port         = 80
      request_path = "/"
    }
  }

  lb_rules = {
    "rule-http" = {
      frontend_ip_configuration_name = "frontend-public"
      backend_address_pool_names     = ["pool-web"]
      probe_name                     = "probe-http"
      protocol                       = "Tcp"
      frontend_port                  = 80
      backend_port                   = 80
    }
  }

  tags = {
    Environment = "Development"
  }
}

output "lb_id" {
  value = module.lb.id
}

output "backend_pool_id" {
  value = module.lb.backend_address_pool_ids["pool-web"]
}
