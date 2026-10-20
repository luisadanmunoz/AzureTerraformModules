################################################################################
# Example: Entra ID Conditional Access Policy
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

# Break glass group (excluded from policies)
resource "azuread_group" "break_glass" {
  display_name     = "CA-BreakGlass-Exclusion"
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
}

################################################################################
# Require MFA for All Users
################################################################################

module "require_mfa" {
  source = "../../"

  display_name = "CA001-Require-MFA-AllUsers"
  state        = "enabledForReportingButNotEnforced"

  conditions_users = {
    included_users  = ["All"]
    excluded_groups = [azuread_group.break_glass.object_id]
  }

  conditions_applications = {
    included_applications = ["All"]
  }

  grant_controls = {
    operator          = "OR"
    built_in_controls = ["mfa"]
  }
}

################################################################################
# Block Legacy Authentication
################################################################################

module "block_legacy" {
  source = "../../"

  display_name = "CA002-Block-LegacyAuth"
  state        = "enabledForReportingButNotEnforced"

  conditions_users = {
    included_users  = ["All"]
    excluded_groups = [azuread_group.break_glass.object_id]
  }

  conditions_applications = {
    included_applications = ["All"]
  }

  conditions_client_app_types = ["exchangeActiveSync", "other"]

  grant_controls = {
    operator          = "OR"
    built_in_controls = ["block"]
  }
}

################################################################################
# Outputs
################################################################################

output "mfa_policy_id" {
  value = module.require_mfa.object_id
}

output "legacy_block_policy_id" {
  value = module.block_legacy.object_id
}
