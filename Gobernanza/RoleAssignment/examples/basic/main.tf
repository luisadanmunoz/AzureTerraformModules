################################################################################
# Basic Example - Role Assignment Module
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

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "rg-rbac-example-dev-001"
  location = "westeurope"
}

################################################################################
# Example 1: Assign Reader role at Resource Group scope
################################################################################

module "rg_reader" {
  source = "../../"

  role_assignments = [
    {
      scope                = azurerm_resource_group.example.id
      role_definition_name = "Reader"
      principal_id         = data.azurerm_client_config.current.object_id
      principal_type       = "ServicePrincipal"
      description          = "Reader access on the example resource group"
    }
  ]
}

################################################################################
# Example 2: Multiple assignments using the convenience variable
################################################################################

module "rg_scoped_roles" {
  source = "../../"

  resource_group_role_assignments = {
    contributor = {
      resource_group_id    = azurerm_resource_group.example.id
      role_definition_name = "Contributor"
      principal_id         = data.azurerm_client_config.current.object_id
      principal_type       = "ServicePrincipal"
      description          = "Contributor access for deployment pipeline"
      skip_service_principal_aad_check = true
    }
  }
}

################################################################################
# Outputs
################################################################################

output "reader_assignment_ids" {
  value = module.rg_reader.role_assignment_ids
}

output "scoped_assignment_ids" {
  value = module.rg_scoped_roles.role_assignment_ids
}
