################################################################################
# Example: Entra ID Group Member
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

resource "azuread_group" "example" {
  display_name     = "example-group"
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
}

module "member" {
  source = "../../"

  group_object_id  = azuread_group.example.object_id
  member_object_id = data.azuread_client_config.current.object_id
}

output "membership_id" {
  value = module.member.id
}
