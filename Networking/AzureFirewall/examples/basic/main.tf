################################################################################
# Basic Example - Azure Firewall Module
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
# Resource Group
################################################################################

resource "azurerm_resource_group" "example" {
  name     = "rg-firewall-example-dev-001"
  location = "westeurope"
}

################################################################################
# Virtual Network with AzureFirewallSubnet
################################################################################

resource "azurerm_virtual_network" "example" {
  name                = "vnet-hub-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

# IMPORTANT: Subnet must be named exactly "AzureFirewallSubnet"
resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/26"]  # Minimum /26
}

################################################################################
# Firewall Policy
################################################################################

resource "azurerm_firewall_policy" "example" {
  name                = "afwp-hub-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard"

  dns {
    proxy_enabled = true
  }
}

################################################################################
# Azure Firewall Module
################################################################################

module "firewall" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name     = "afw-hub-dev-001"
  sku_tier = "Standard"

  subnet_id          = azurerm_subnet.firewall.id
  firewall_policy_id = azurerm_firewall_policy.example.id

  dns_proxy_enabled = true
  threat_intel_mode = "Alert"

  zones = ["1", "2", "3"]

  tags = {
    Environment = "Development"
    Role        = "Hub Firewall"
  }
}

################################################################################
# Outputs
################################################################################

output "firewall_id" {
  value = module.firewall.id
}

output "firewall_private_ip" {
  value = module.firewall.private_ip_address
}

output "firewall_public_ips" {
  value = module.firewall.created_public_ip_addresses
}
