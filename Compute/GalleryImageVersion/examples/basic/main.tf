################################################################################
# Example: Gallery Image Version
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

resource "azurerm_shared_image" "example" {
  name                = "ubuntu-2204"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  gallery_name        = azurerm_shared_image_gallery.example.name
  os_type             = "Linux"
  hyper_v_generation  = "V2"

  identifier {
    publisher = "MyOrg"
    offer     = "Ubuntu"
    sku       = "22.04-LTS"
  }
}

# Note: In real use, you'd have a managed image to reference
# This example shows the module structure

module "image_version" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  gallery_name        = azurerm_shared_image_gallery.example.name
  image_name          = azurerm_shared_image.example.name
  name                = "1.0.0"

  # managed_image_id = azurerm_image.golden.id

  target_regions = [
    {
      name                   = "westeurope"
      regional_replica_count = 2
      storage_account_type   = "Standard_LRS"
    },
    {
      name                   = "northeurope"
      regional_replica_count = 1
    }
  ]

  tags = {
    Version = "1.0.0"
    Status  = "Production"
  }
}

output "version_id" {
  value = module.image_version.id
}
