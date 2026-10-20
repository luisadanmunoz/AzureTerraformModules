# Azure Entra ID Service Principal

Terraform module for creating and managing Azure Entra ID (formerly Azure AD) Service Principals (Enterprise Applications).

## Features

- **Enterprise Application Management**: Create and manage service principals for applications
- **Single Sign-On**: Configure OIDC, SAML, or password-based SSO
- **App Role Assignments**: Require app role assignment for access control
- **SAML Configuration**: Configure SAML relay state for federated authentication
- **Data Source Support**: Reference existing service principals
- **Feature Tags**: Configure enterprise, gallery, and SSO features

## Usage

### Basic Service Principal

```hcl
module "app" {
  source = "path/to/EntraID/Application"

  display_name = "my-application"
}

module "sp" {
  source = "path/to/EntraID/ServicePrincipal"

  client_id = module.app.client_id

  owners = [data.azuread_client_config.current.object_id]
}
```

### Service Principal with App Role Assignment Required

```hcl
module "sp_restricted" {
  source = "path/to/EntraID/ServicePrincipal"

  client_id = module.app.client_id

  app_role_assignment_required = true
  description                  = "Restricted access - requires app role assignment"

  notification_email_addresses = ["admin@company.com"]

  owners = [data.azuread_client_config.current.object_id]
}
```

### Service Principal with SAML SSO

```hcl
module "sp_saml" {
  source = "path/to/EntraID/ServicePrincipal"

  client_id = module.app.client_id

  preferred_single_sign_on_mode = "saml"
  login_url                     = "https://myapp.example.com/login"

  saml_single_sign_on = {
    relay_state = "https://myapp.example.com/dashboard"
  }

  feature_tags = {
    enterprise            = true
    custom_single_sign_on = true
  }
}
```

### Reference Existing Service Principal

```hcl
module "existing_sp" {
  source = "path/to/EntraID/ServicePrincipal"

  client_id    = "00000003-0000-0000-c000-000000000000"  # Microsoft Graph
  use_existing = true
}

output "graph_sp_id" {
  value = module.existing_sp.object_id
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
| client_id | The client ID of the application | `string` | n/a | yes |
| create | Whether to create the service principal | `bool` | `true` | no |
| use_existing | Use existing service principal (data source) | `bool` | `false` | no |
| account_enabled | Whether the service principal is enabled | `bool` | `true` | no |
| alternative_names | Alternative names for the service principal | `set(string)` | `[]` | no |
| app_role_assignment_required | Require app role assignment for access | `bool` | `false` | no |
| description | Description of the service principal | `string` | `null` | no |
| login_url | Login URL for the service provider | `string` | `null` | no |
| notes | Free text notes | `string` | `null` | no |
| notification_email_addresses | Notification email addresses | `set(string)` | `[]` | no |
| owners | Object IDs of owners | `set(string)` | `[]` | no |
| preferred_single_sign_on_mode | SSO mode (oidc, password, saml, notSupported) | `string` | `null` | no |
| saml_single_sign_on | SAML SSO configuration | `object` | `null` | no |
| feature_tags | Feature configuration tags | `object` | `null` | no |
| tags | Tags to apply | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Terraform resource ID |
| object_id | The object ID of the service principal |
| application_id | The application ID (client ID) |
| display_name | The display name |
| app_roles | Published app roles |
| app_role_ids | Map of app role values to IDs |
| oauth2_permission_scopes | OAuth 2.0 permission scopes |
| oauth2_permission_scope_ids | Map of scope values to IDs |
| homepage_url | Home page URL |
| logout_url | Logout URL |
| redirect_uris | Redirect URIs |
| saml_metadata_url | SAML metadata URL |
| service_principal_names | Service principal identifier URIs |
| sign_in_audience | Supported account types |
| type | Service principal type |

## Best Practices

1. **Owners**: Always assign owners for management continuity
2. **App Role Assignment**: Enable `app_role_assignment_required` for sensitive applications
3. **Notifications**: Configure `notification_email_addresses` for important service principals
4. **SSO Mode**: Choose the appropriate SSO mode (OIDC preferred for modern apps)
5. **Description**: Add descriptions for documentation and auditing
6. **Data Source**: Use `use_existing = true` to reference Microsoft service principals
