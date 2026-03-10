################################################################################
# Example: Entra ID Application Registration
# Demonstrates various application configurations
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
# Web Application
# Standard web app with redirect URIs and ID token issuance
################################################################################

module "app_web" {
  source = "../../"

  display_name     = "example-web-app"
  description      = "Example web application for demonstration"
  sign_in_audience = "AzureADMyOrg"

  owners = [data.azuread_client_config.current.object_id]

  web = {
    homepage_url  = "https://example.com"
    logout_url    = "https://example.com/logout"
    redirect_uris = [
      "https://example.com/auth/callback",
      "https://example.com/auth/silent-callback"
    ]
    implicit_grant = {
      id_token_issuance_enabled = true
    }
  }

  tags = ["web", "production"]
}

################################################################################
# Single Page Application (SPA)
# Modern SPA with authorization code flow + PKCE
################################################################################

module "app_spa" {
  source = "../../"

  display_name     = "example-spa"
  description      = "Example single-page application"
  sign_in_audience = "AzureADMyOrg"

  owners = [data.azuread_client_config.current.object_id]

  single_page_application = {
    redirect_uris = [
      "http://localhost:3000",
      "http://localhost:4200",
      "https://spa.example.com"
    ]
  }

  tags = ["spa", "frontend"]
}

################################################################################
# API Application
# Backend API with custom scopes and app roles
################################################################################

module "app_api" {
  source = "../../"

  display_name     = "example-api"
  description      = "Example API application with custom scopes"
  sign_in_audience = "AzureADMyOrg"
  identifier_uris  = ["api://example-api"]

  owners = [data.azuread_client_config.current.object_id]

  api = {
    requested_access_token_version = 2
    oauth2_permission_scope = [
      {
        id                         = "c9c1c8e0-0001-0000-0000-000000000001"
        value                      = "data.read"
        admin_consent_display_name = "Read application data"
        admin_consent_description  = "Allows the app to read data on behalf of the signed-in user"
        type                       = "User"
        user_consent_display_name  = "Read your data"
        user_consent_description   = "Allow the application to read your data"
        enabled                    = true
      },
      {
        id                         = "c9c1c8e0-0002-0000-0000-000000000002"
        value                      = "data.write"
        admin_consent_display_name = "Write application data"
        admin_consent_description  = "Allows the app to write data on behalf of the signed-in user"
        type                       = "User"
        user_consent_display_name  = "Write your data"
        user_consent_description   = "Allow the application to write your data"
        enabled                    = true
      },
      {
        id                         = "c9c1c8e0-0003-0000-0000-000000000003"
        value                      = "admin.all"
        admin_consent_display_name = "Full administrative access"
        admin_consent_description  = "Allows the app full administrative access (admin consent required)"
        type                       = "Admin"
        enabled                    = true
      }
    ]
  }

  app_roles = [
    {
      id                   = "c9c1c8e0-1001-0000-0000-000000000001"
      allowed_member_types = ["User"]
      display_name         = "Reader"
      description          = "Readers can view all data"
      value                = "Reader"
      enabled              = true
    },
    {
      id                   = "c9c1c8e0-1002-0000-0000-000000000002"
      allowed_member_types = ["User"]
      display_name         = "Contributor"
      description          = "Contributors can view and modify data"
      value                = "Contributor"
      enabled              = true
    },
    {
      id                   = "c9c1c8e0-1003-0000-0000-000000000003"
      allowed_member_types = ["User", "Application"]
      display_name         = "Administrator"
      description          = "Administrators have full access"
      value                = "Administrator"
      enabled              = true
    }
  ]

  tags = ["api", "backend"]
}

################################################################################
# Client Application with Microsoft Graph Permissions
# Application that consumes Microsoft Graph API
################################################################################

module "app_client" {
  source = "../../"

  display_name     = "example-client"
  description      = "Client application with Microsoft Graph permissions"
  sign_in_audience = "AzureADMyOrg"

  owners = [data.azuread_client_config.current.object_id]

  web = {
    redirect_uris = ["https://client.example.com/callback"]
  }

  # Microsoft Graph API permissions
  required_resource_access = [
    {
      # Microsoft Graph App ID
      resource_app_id = "00000003-0000-0000-c000-000000000000"
      resource_access = [
        {
          # User.Read - Sign in and read user profile (Delegated)
          id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
          type = "Scope"
        },
        {
          # User.ReadBasic.All - Read all users' basic profiles (Delegated)
          id   = "b340eb25-3456-403f-be2f-af7a0d370277"
          type = "Scope"
        },
        {
          # Mail.Read - Read user mail (Delegated)
          id   = "570282fd-fa5c-430d-a7fd-fc8dc98a9dca"
          type = "Scope"
        }
      ]
    },
    # Also request access to our custom API
    {
      resource_app_id = module.app_api.application_id
      resource_access = [
        {
          id   = "c9c1c8e0-0001-0000-0000-000000000001" # data.read scope
          type = "Scope"
        }
      ]
    }
  ]

  # Optional claims for enhanced token information
  optional_claims = {
    id_token = [
      {
        name                  = "email"
        essential             = true
        additional_properties = []
      },
      {
        name                  = "upn"
        essential             = false
        additional_properties = []
      }
    ]
    access_token = [
      {
        name                  = "email"
        essential             = false
        additional_properties = []
      }
    ]
  }

  tags = ["client", "graph"]
}

################################################################################
# Outputs
################################################################################

output "web_app_client_id" {
  description = "Client ID of the web application"
  value       = module.app_web.client_id
}

output "spa_client_id" {
  description = "Client ID of the SPA"
  value       = module.app_spa.client_id
}

output "api_client_id" {
  description = "Client ID of the API"
  value       = module.app_api.client_id
}

output "api_scope_ids" {
  description = "OAuth2 scope IDs for the API"
  value       = module.app_api.oauth2_permission_scope_ids
}

output "api_app_role_ids" {
  description = "App role IDs for the API"
  value       = module.app_api.app_role_ids
}

output "client_app_client_id" {
  description = "Client ID of the client application"
  value       = module.app_client.client_id
}
