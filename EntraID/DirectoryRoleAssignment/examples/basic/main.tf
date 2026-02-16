################################################################################
# Example: Entra ID Directory Role Assignment
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.45.0"
    }
  }
}

provider "azuread" {}

data "azuread_client_config" "current" {}

resource "azuread_directory_role" "user_admin" {
  display_name = "User Administrator"
}

resource "azuread_group" "admins" {
  display_name       = "user-administrators"
  security_enabled   = true
  assignable_to_role = true
  owners             = [data.azuread_client_config.current.object_id]
}

module "assignment" {
  source = "../../"

  role_id             = azuread_directory_role.user_admin.object_id
  principal_object_id = azuread_group.admins.object_id
}

output "assignment_id" {
  value = module.assignment.id
}
