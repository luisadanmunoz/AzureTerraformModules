################################################################################
# Example: Entra ID Group
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

################################################################################
# Security Group
################################################################################

module "security_group" {
  source = "../../"

  display_name     = "sg-example-admins"
  description      = "Example administrators group"
  security_enabled = true

  owners = [data.azuread_client_config.current.object_id]
}

################################################################################
# Dynamic Group
################################################################################

module "dynamic_group" {
  source = "../../"

  display_name     = "sg-example-developers"
  description      = "All users in Development department"
  security_enabled = true
  types            = ["DynamicMembership"]

  dynamic_membership = {
    enabled = true
    rule    = "user.department -eq \"Development\""
  }

  owners = [data.azuread_client_config.current.object_id]
}

################################################################################
# Role-Assignable Group
################################################################################

module "role_assignable_group" {
  source = "../../"

  display_name       = "sg-global-admins"
  description        = "Group assignable to Azure AD roles"
  security_enabled   = true
  assignable_to_role = true

  owners = [data.azuread_client_config.current.object_id]
}

################################################################################
# Outputs
################################################################################

output "security_group_id" {
  value = module.security_group.object_id
}

output "dynamic_group_id" {
  value = module.dynamic_group.object_id
}

output "role_assignable_group_id" {
  value = module.role_assignable_group.object_id
}
