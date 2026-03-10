################################################################################
# Example: Entra ID Directory Role
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

module "user_admin" {
  source = "../../"

  display_name = "User Administrator"
}

module "app_admin" {
  source = "../../"

  display_name = "Application Administrator"
}

output "user_admin_role_id" {
  value = module.user_admin.object_id
}

output "app_admin_role_id" {
  value = module.app_admin.object_id
}
