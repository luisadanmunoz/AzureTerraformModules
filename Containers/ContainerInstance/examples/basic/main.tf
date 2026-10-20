################################################################################
# Example: Azure Container Instance
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

resource "azurerm_resource_group" "example" {
  name     = "rg-aci-dev-001"
  location = "westeurope"
}

################################################################################
# Simple NGINX Container
################################################################################

module "nginx" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "nginx"
  environment = "dev"

  containers = [
    {
      name   = "nginx"
      image  = "nginx:latest"
      cpu    = 0.5
      memory = 0.5
      ports = [
        {
          port     = 80
          protocol = "TCP"
        }
      ]
    }
  ]

  ip_address_type = "Public"
  dns_name_label  = "nginx-demo-${random_string.suffix.result}"

  exposed_ports = [
    {
      port     = 80
      protocol = "TCP"
    }
  ]

  tags = {
    Environment = "Development"
  }
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

################################################################################
# Multi-container with Health Checks
################################################################################

module "api" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "api"
  environment = "dev"

  containers = [
    {
      name   = "api"
      image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
      cpu    = 0.5
      memory = 0.5
      ports = [
        {
          port     = 80
          protocol = "TCP"
        }
      ]
      environment_variables = {
        "PORT" = "80"
      }
      liveness_probe = {
        http_get_path   = "/"
        http_get_port   = 80
        http_get_scheme = "Http"
        period_seconds  = 30
      }
      readiness_probe = {
        http_get_path   = "/"
        http_get_port   = 80
        http_get_scheme = "Http"
        period_seconds  = 10
      }
    }
  ]

  ip_address_type = "Public"
  dns_name_label  = "api-demo-${random_string.suffix.result}"

  exposed_ports = [
    {
      port     = 80
      protocol = "TCP"
    }
  ]

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
    Purpose     = "Demo"
  }
}

################################################################################
# Outputs
################################################################################

output "nginx_fqdn" {
  value = module.nginx.fqdn
}

output "nginx_ip" {
  value = module.nginx.ip_address
}

output "api_fqdn" {
  value = module.api.fqdn
}
