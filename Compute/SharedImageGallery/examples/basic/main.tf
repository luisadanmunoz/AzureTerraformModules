################################################################################
# Example: Shared Image Gallery
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

module "gallery" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "golden"
  environment = "dev"

  description = "Golden images for development"

  tags = {
    Environment = "Development"
    Purpose     = "ImageManagement"
  }
}

output "gallery_id" {
  value = module.gallery.id
}

output "gallery_name" {
  value = module.gallery.name
}
