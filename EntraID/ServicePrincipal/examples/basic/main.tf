################################################################################
# Example: Entra ID Service Principal
# Demonstrates service principal configurations
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
# Application Registration
# First create an application, then create a service principal for it
################################################################################

resource "azuread_application" "example" {
  display_name = "example-app-for-sp"
  description  = "Example application for service principal demo"

  owners = [data.azuread_client_config.current.object_id]
}

################################################################################
# Basic Service Principal
# Standard enterprise application setup
################################################################################

module "sp_basic" {
  source = "../../"

  client_id = azuread_application.example.client_id

  description = "Basic service principal for example application"
  owners      = [data.azuread_client_config.current.object_id]

  tags = ["example", "basic"]
}

################################################################################
# Restricted Service Principal
# Requires app role assignment for access
################################################################################

resource "azuread_application" "restricted" {
  display_name = "example-restricted-app"
  description  = "Application with restricted access"

  owners = [data.azuread_client_config.current.object_id]

  app_role {
    id                   = "b1c2d3e4-f5a6-7890-abcd-ef1234567890"
    allowed_member_types = ["User", "Application"]
    display_name         = "App User"
    description          = "Users who can access this application"
    value                = "User"
    enabled              = true
  }
}

module "sp_restricted" {
  source = "../../"

  client_id = azuread_application.restricted.client_id

  account_enabled              = true
  app_role_assignment_required = true
  description                  = "Restricted - requires explicit role assignment"

  notification_email_addresses = [
    "security@example.com",
    "admin@example.com"
  ]

  notes  = "This service principal requires users to be assigned an app role before they can access the application."
  owners = [data.azuread_client_config.current.object_id]

  tags = ["restricted", "enterprise"]
}

################################################################################
# SAML Enterprise Application
# Configured for SAML single sign-on
################################################################################

resource "azuread_application" "saml_app" {
  display_name = "example-saml-app"
  description  = "SAML-based enterprise application"

  identifier_uris = ["https://saml.example.com"]
  owners          = [data.azuread_client_config.current.object_id]

  web {
    redirect_uris = ["https://saml.example.com/auth/callback"]
  }
}

module "sp_saml" {
  source = "../../"

  client_id = azuread_application.saml_app.client_id

  account_enabled               = true
  preferred_single_sign_on_mode = "saml"
  login_url                     = "https://saml.example.com/login"

  saml_single_sign_on = {
    relay_state = "https://saml.example.com/dashboard"
  }

  feature_tags = {
    enterprise            = true
    custom_single_sign_on = true
    gallery               = false
    hide                  = false
  }

  owners = [data.azuread_client_config.current.object_id]

  tags = ["saml", "enterprise", "sso"]
}

################################################################################
# Reference Existing Service Principal (Microsoft Graph)
# Use data source to get Microsoft Graph service principal
################################################################################

module "graph_sp" {
  source = "../../"

  # Microsoft Graph Application ID
  client_id    = "00000003-0000-0000-c000-000000000000"
  use_existing = true
}

################################################################################
# Outputs
################################################################################

output "basic_sp_object_id" {
  description = "Object ID of the basic service principal"
  value       = module.sp_basic.object_id
}

output "restricted_sp_object_id" {
  description = "Object ID of the restricted service principal"
  value       = module.sp_restricted.object_id
}

output "saml_sp_object_id" {
  description = "Object ID of the SAML service principal"
  value       = module.sp_saml.object_id
}

output "saml_sp_saml_metadata_url" {
  description = "SAML metadata URL for federation"
  value       = module.sp_saml.saml_metadata_url
}

output "graph_sp_object_id" {
  description = "Object ID of Microsoft Graph service principal"
  value       = module.graph_sp.object_id
}

output "graph_sp_app_roles" {
  description = "App roles available in Microsoft Graph"
  value       = module.graph_sp.app_role_ids
}
