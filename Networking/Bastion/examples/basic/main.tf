################################################################################
# Basic Example - Bastion Module
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
  name     = "rg-bastion-example-dev-001"
  location = "westeurope"
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet-hub-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

# AzureBastionSubnet must be named exactly "AzureBastionSubnet"
resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.255.0/26"]
}

module "bastion" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  subnet_id           = azurerm_subnet.bastion.id

  name        = "bas-hub-dev-001"
  sku         = "Standard"
  scale_units = 2

  copy_paste_enabled = true
  tunneling_enabled  = true

  tags = {
    Environment = "Development"
  }
}

output "bastion_dns_name" {
  value = module.bastion.dns_name
}
