################################################################################
# Basic Example - Network Security Group Module
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
  name     = "rg-nsg-example-dev-001"
  location = "westeurope"

  tags = {
    Environment = "Development"
    Example     = "NSG-Basic"
  }
}

################################################################################
# NSG Module - Basic with Preset Rules
################################################################################

module "nsg_web" {
  source = "../../"

  # DEPENDENCY: Resource Group must exist
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name = "nsg-web-dev-001"

  # Use preset rules
  allow_https = {
    enabled               = true
    priority              = 100
    source_address_prefix = "*"
  }

  allow_http = {
    enabled               = true
    priority              = 110
    source_address_prefix = "*"
  }

  deny_all_inbound = {
    enabled  = true
    priority = 4096
  }

  tags = {
    Environment = "Development"
    Role        = "WebServer"
  }
}

################################################################################
# NSG Module - With Custom Rules
################################################################################

module "nsg_backend" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name = "nsg-backend-dev-001"

  security_rules = {
    "AllowAppGateway" = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["8080", "8443"]
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "*"
      description                = "Allow traffic from App Gateway subnet"
    }
    "AllowHealthProbe" = {
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "AzureLoadBalancer"
      destination_address_prefix = "*"
      description                = "Allow Azure Load Balancer health probes"
    }
    "DenyAllInbound" = {
      priority                   = 4096
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Deny all other inbound traffic"
    }
  }

  tags = {
    Environment = "Development"
    Role        = "Backend"
  }
}

################################################################################
# Outputs
################################################################################

output "nsg_web_id" {
  description = "ID of the web NSG"
  value       = module.nsg_web.id
}

output "nsg_web_rules" {
  description = "Security rules in the web NSG"
  value       = module.nsg_web.security_rules
}

output "nsg_backend_id" {
  description = "ID of the backend NSG"
  value       = module.nsg_backend.id
}
