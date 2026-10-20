################################################################################
# Example: Gallery Image Definition
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
  name     = "rg-gallery-dev-001"
  location = "westeurope"
}

resource "azurerm_shared_image_gallery" "example" {
  name                = "gal_golden_dev_001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

module "linux_image" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  gallery_name        = azurerm_shared_image_gallery.example.name
  name                = "ubuntu-2204-hardened"

  os_type            = "Linux"
  hyper_v_generation = "V2"

  identifier = {
    publisher = "MyOrg"
    offer     = "Ubuntu"
    sku       = "22.04-LTS-Hardened"
  }

  trusted_launch_enabled              = true
  accelerated_network_support_enabled = true

  min_recommended_vcpu_count   = 2
  min_recommended_memory_in_gb = 4

  tags = {
    OS      = "Linux"
    Distro  = "Ubuntu"
    Version = "22.04"
  }
}

output "image_id" {
  value = module.linux_image.id
}
