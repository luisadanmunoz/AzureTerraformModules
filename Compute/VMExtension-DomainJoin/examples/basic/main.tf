################################################################################
# Example: AD Domain Join Extension
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

variable "domain_password" {
  description = "Domain admin password"
  type        = string
  sensitive   = true
}

# Assumes VM already exists
data "azurerm_virtual_machine" "example" {
  name                = "vm-windows-prod-001"
  resource_group_name = "rg-compute-prod-001"
}

module "domain_join" {
  source = "../../"

  virtual_machine_id = data.azurerm_virtual_machine.example.id

  domain_name     = "corp.contoso.com"
  domain_username = "svc-domainjoin@corp.contoso.com"
  domain_password = var.domain_password
  ou_path         = "OU=Servers,OU=Azure,DC=corp,DC=contoso,DC=com"
  restart         = "true"
}

output "extension_id" {
  value = module.domain_join.id
}
