################################################################################
# Provider Configuration
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

resource "azurerm_resource_group" "main" {
  name     = "rg-digital-twins-example"
  location = "eastus"
}

################################################################################
# Digital Twins - Basic Configuration
################################################################################

module "digital_twins_basic" {
  source = "../../"

  name                = "dt-basic-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  tags = {
    Environment = "Example"
    Purpose     = "BasicDemo"
  }
}

################################################################################
# Digital Twins - With Managed Identity
################################################################################

module "digital_twins_with_identity" {
  source = "../../"

  name                = "dt-identity-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  identity_type = "SystemAssigned"

  tags = {
    Environment = "Example"
    Purpose     = "IdentityDemo"
  }
}

################################################################################
# Outputs
################################################################################

output "basic_digital_twins_id" {
  description = "The ID of the basic Digital Twins instance."
  value       = module.digital_twins_basic.id
}

output "basic_digital_twins_host_name" {
  description = "The hostname of the basic Digital Twins instance."
  value       = module.digital_twins_basic.host_name
}

output "identity_digital_twins_id" {
  description = "The ID of the Digital Twins instance with identity."
  value       = module.digital_twins_with_identity.id
}

output "identity_digital_twins_principal_id" {
  description = "The principal ID of the Digital Twins managed identity."
  value       = module.digital_twins_with_identity.principal_id
}
