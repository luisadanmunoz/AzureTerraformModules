################################################################################
# Example: Azure Arc Private Link Scope
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

resource "azurerm_resource_group" "arc" {
  name     = "rg-arc-privatelink"
  location = "westeurope"
}

################################################################################
# Network Infrastructure
################################################################################

resource "azurerm_virtual_network" "main" {
  name                = "vnet-arc"
  resource_group_name = azurerm_resource_group.arc.name
  location            = azurerm_resource_group.arc.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "private" {
  name                 = "snet-private-endpoints"
  resource_group_name  = azurerm_resource_group.arc.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

################################################################################
# Arc Private Link Scope
################################################################################

module "arc_pls" {
  source = "../../"

  name                          = "pls-arc-prod"
  resource_group_name           = azurerm_resource_group.arc.name
  location                      = azurerm_resource_group.arc.location
  public_network_access_enabled = false

  tags = {
    Environment = "Production"
    Purpose     = "ArcPrivateConnectivity"
  }
}

################################################################################
# Private Endpoint
################################################################################

resource "azurerm_private_endpoint" "arc" {
  name                = "pe-arc"
  location            = azurerm_resource_group.arc.location
  resource_group_name = azurerm_resource_group.arc.name
  subnet_id           = azurerm_subnet.private.id

  private_service_connection {
    name                           = "arc-connection"
    private_connection_resource_id = module.arc_pls.id
    subresource_names              = ["hybridcompute"]
    is_manual_connection           = false
  }
}

################################################################################
# Outputs
################################################################################

output "private_link_scope_id" {
  value = module.arc_pls.id
}

output "private_endpoint_ip" {
  value = azurerm_private_endpoint.arc.private_service_connection[0].private_ip_address
}
