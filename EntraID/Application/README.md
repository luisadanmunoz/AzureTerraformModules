# Azure Entra ID Application (App Registration)

Terraform module for creating and managing Azure Entra ID (formerly Azure AD) Application registrations.

## Features

- **Multi-tenant Support**: Configure sign-in audience for single or multi-tenant applications
- **Web Applications**: Configure redirect URIs, logout URLs, and implicit grant settings
- **Single Page Applications (SPA)**: Native support for SPA redirect URIs
- **Public/Native Clients**: Support for mobile and desktop applications
- **API Configuration**: Define OAuth2 permission scopes and access token versions
- **App Roles**: Create application roles for RBAC
- **API Permissions**: Configure required resource access (Microsoft Graph, custom APIs)
- **Optional Claims**: Customize token claims for ID, access, and SAML2 tokens
- **Feature Tags**: Configure enterprise, gallery, and SSO features

## Usage

### Basic Web Application

```hcl
module "app_web" {
  source = "path/to/EntraID/Application"

  display_name     = "my-web-app"
  sign_in_audience = "AzureADMyOrg"

  web = {
    homepage_url  = "https://myapp.example.com"
    redirect_uris = ["https://myapp.example.com/auth/callback"]
    implicit_grant = {
      id_token_issuance_enabled = true
    }
  }

  tags = ["production", "web"]
}
```

### Single Page Application (SPA)

```hcl
module "app_spa" {
  source = "path/to/EntraID/Application"

  display_name     = "my-spa-app"
  sign_in_audience = "AzureADMyOrg"

  single_page_application = {
    redirect_uris = [
      "http://localhost:3000",
      "https://myapp.example.com"
    ]
  }
}
```

### API Application with Scopes

```hcl
module "app_api" {
  source = "path/to/EntraID/Application"

  display_name     = "my-api"
  sign_in_audience = "AzureADMyOrg"
  identifier_uris  = ["api://my-api"]

  api = {
    requested_access_token_version = 2
    oauth2_permission_scope = [
      {
        id                         = "00000000-0000-0000-0000-000000000001"
        value                      = "read"
        admin_consent_display_name = "Read access"
        admin_consent_description  = "Allow the application to read data"
        type                       = "User"
        user_consent_display_name  = "Read your data"
        user_consent_description   = "Allow the app to read your data"
      },
      {
        id                         = "00000000-0000-0000-0000-000000000002"
        value                      = "write"
        admin_consent_display_name = "Write access"
        admin_consent_description  = "Allow the application to write data"
        type                       = "Admin"
      }
    ]
  }

  app_roles = [
    {
      id                   = "00000000-0000-0000-0000-000000000003"
      allowed_member_types = ["User", "Application"]
      display_name         = "Admin"
      description          = "Administrators can manage all aspects"
      value                = "Admin"
    }
  ]
}
```

### Application with Microsoft Graph Permissions

```hcl
module "app_with_graph" {
  source = "path/to/EntraID/Application"

  display_name = "my-app-with-graph"

  required_resource_access = [
    {
      # Microsoft Graph
      resource_app_id = "00000003-0000-0000-c000-000000000000"
      resource_access = [
        {
          # User.Read (Delegated)
          id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
          type = "Scope"
        },
        {
          # User.Read.All (Application)
          id   = "df021288-bdef-4463-88db-98f22de89214"
          type = "Role"
        }
      ]
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azuread | >= 2.45.0, < 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| display_name | The display name for the application | `string` | n/a | yes |
| create | Whether to create the application | `bool` | `true` | no |
| description | A description of the application | `string` | `null` | no |
| sign_in_audience | The Microsoft account types supported | `string` | `"AzureADMyOrg"` | no |
| identifier_uris | User-defined URIs that identify the application | `list(string)` | `[]` | no |
| owners | Object IDs of principals that own the application | `list(string)` | `[]` | no |
| prevent_duplicate_names | Return error if duplicate name exists | `bool` | `true` | no |
| fallback_public_client_enabled | Enable public client fallback | `bool` | `false` | no |
| web | Web application configuration | `object` | `null` | no |
| single_page_application | SPA configuration | `object` | `null` | no |
| public_client | Public/native client configuration | `object` | `null` | no |
| api | API configuration with scopes | `object` | `null` | no |
| app_roles | Application roles for RBAC | `list(object)` | `[]` | no |
| required_resource_access | API permissions | `list(object)` | `[]` | no |
| optional_claims | Optional token claims | `object` | `null` | no |
| feature_tags | Feature configuration tags | `object` | `null` | no |
| tags | Tags to apply to the application | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Terraform resource ID of the application |
| object_id | The object ID of the application |
| application_id | The application ID (client ID) |
| client_id | The client ID (alias for application_id) |
| display_name | The display name of the application |
| publisher_domain | The verified publisher domain |
| oauth2_permission_scope_ids | Map of OAuth2 scope values to IDs |
| app_role_ids | Map of app role values to IDs |

## Best Practices

1. **Use RBAC**: Define app roles for fine-grained access control
2. **Least Privilege**: Request only the API permissions your app needs
3. **Token Version**: Use access token version 2 for modern applications
4. **Prevent Duplicates**: Keep `prevent_duplicate_names = true` to avoid conflicts
5. **Owners**: Always specify owners for application management
6. **Sign-in Audience**: Use `AzureADMyOrg` unless multi-tenant is required
7. **Implicit Grant**: Avoid implicit grant flow; use authorization code with PKCE instead
