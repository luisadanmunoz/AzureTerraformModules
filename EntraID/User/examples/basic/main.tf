################################################################################
# Example: Entra ID User
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.45.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}

provider "azuread" {}

data "azuread_domains" "default" {
  only_initial = true
}

resource "random_password" "user" {
  length  = 16
  special = true
}

module "user" {
  source = "../../"

  display_name        = "Example User"
  user_principal_name = "example.user@${data.azuread_domains.default.domains[0].domain_name}"

  given_name     = "Example"
  surname        = "User"
  department     = "Engineering"
  job_title      = "Developer"
  usage_location = "US"

  password              = random_password.user.result
  force_password_change = true
}

output "user_id" {
  value = module.user.object_id
}

output "user_upn" {
  value = module.user.user_principal_name
}
