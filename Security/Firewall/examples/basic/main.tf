################################################################################
# Example: Azure Firewall
# Following Microsoft Network Security Best Practices
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
  name     = "rg-firewall-prod-001"
  location = "westeurope"
}

################################################################################
# Network Infrastructure
################################################################################

resource "azurerm_virtual_network" "example" {
  name                = "vnet-firewall-prod-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/26"]
}

resource "azurerm_subnet" "workload" {
  name                 = "snet-workload"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "firewall" {
  name                = "pip-firewall-prod-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
}

################################################################################
# Production Azure Firewall
# Best Practices:
# - Standard tier for cost-effective network protection
# - Availability zones for high availability
# - Threat intelligence in Alert mode
# - DNS proxy enabled for FQDN-based rules
################################################################################

module "firewall" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "hub"
  environment = "prod"

  sku_name          = "AZFW_VNet"
  sku_tier          = "Standard"
  threat_intel_mode = "Alert"
  dns_proxy_enabled = true
  zones             = ["1", "2", "3"]

  ip_configuration = [
    {
      name                 = "fw-ipconfig"
      subnet_id            = azurerm_subnet.firewall.id
      public_ip_address_id = azurerm_public_ip.firewall.id
    }
  ]

  tags = {
    Environment = "Production"
    CostCenter  = "Networking"
  }
}

################################################################################
# Route Table for Workload Subnet
# Route all traffic through the Azure Firewall
################################################################################

resource "azurerm_route_table" "workload" {
  name                = "rt-workload-prod-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

resource "azurerm_route" "default" {
  name                   = "default-to-firewall"
  resource_group_name    = azurerm_resource_group.example.name
  route_table_name       = azurerm_route_table.workload.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = module.firewall.private_ip_address
}

resource "azurerm_subnet_route_table_association" "workload" {
  subnet_id      = azurerm_subnet.workload.id
  route_table_id = azurerm_route_table.workload.id
}

################################################################################
# Outputs
################################################################################

output "firewall_id" {
  value = module.firewall.id
}

output "firewall_name" {
  value = module.firewall.name
}

output "firewall_private_ip" {
  value = module.firewall.private_ip_address
}
