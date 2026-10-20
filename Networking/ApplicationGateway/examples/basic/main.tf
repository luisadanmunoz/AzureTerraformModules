################################################################################
# Basic Example - Application Gateway Module
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
  name     = "rg-appgw-example-dev-001"
  location = "westeurope"
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet-appgw-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "appgw" {
  name                 = "snet-appgw"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

module "appgw" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  subnet_id           = azurerm_subnet.appgw.id

  name = "agw-web-dev-001"

  sku = {
    name = "Standard_v2"
    tier = "Standard_v2"
  }

  autoscale_configuration = {
    min_capacity = 1
    max_capacity = 3
  }

  backend_address_pools = {
    "pool-web" = {
      fqdns = ["app1.example.com"]
    }
  }

  backend_http_settings = {
    "http-settings" = {
      port                                = 80
      protocol                            = "Http"
      pick_host_name_from_backend_address = true
    }
  }

  http_listeners = {
    "listener-http" = {
      frontend_port_name = "http"
      protocol           = "Http"
    }
  }

  request_routing_rules = {
    "rule-basic" = {
      rule_type                  = "Basic"
      priority                   = 100
      http_listener_name         = "listener-http"
      backend_address_pool_name  = "pool-web"
      backend_http_settings_name = "http-settings"
    }
  }

  probes = {
    "probe-web" = {
      protocol = "Http"
      path     = "/health"
      host     = "app1.example.com"
    }
  }

  tags = {
    Environment = "Development"
  }
}

output "appgw_public_ip" {
  value = module.appgw.public_ip_address
}
