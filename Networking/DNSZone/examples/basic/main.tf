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
  name     = "rg-dns-example-dev-001"
  location = "westeurope"
}

module "dns_zone" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  name                = "example.com"

  a_records = {
    "www" = { records = ["10.0.0.1"] }
    "api" = { records = ["10.0.0.2"] }
  }

  cname_records = {
    "mail" = { record = "mail.example.com" }
  }

  txt_records = {
    "@" = { records = ["v=spf1 -all"] }
  }

  tags = {
    Environment = "Development"
  }
}

output "name_servers" {
  value = module.dns_zone.name_servers
}
