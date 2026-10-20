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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.45.0, < 3.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.45.0, < 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azuread_service_principal.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_account_enabled"></a> [account\_enabled](#input\_account\_enabled) | Whether the service principal account is enabled. | `bool` | `true` | no |
| <a name="input_alternative_names"></a> [alternative\_names](#input\_alternative\_names) | A set of alternative names used to refer to this service principal. | `set(string)` | `[]` | no |
| <a name="input_app_role_assignment_required"></a> [app\_role\_assignment\_required](#input\_app\_role\_assignment\_required) | Whether users or other service principals need an app role assignment before access is granted. | `bool` | `false` | no |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | The client ID (application ID) of the application for which to create a service principal. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the service principal. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the service principal. | `string` | `null` | no |
| <a name="input_feature_tags"></a> [feature\_tags](#input\_feature\_tags) | Block of features to configure for this service principal using tags. | <pre>object({<br/>    custom_single_sign_on = optional(bool, false)<br/>    enterprise            = optional(bool, false)<br/>    gallery               = optional(bool, false)<br/>    hide                  = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_login_url"></a> [login\_url](#input\_login\_url) | The URL where the service provider redirects the user to Azure AD to authenticate. | `string` | `null` | no |
| <a name="input_notes"></a> [notes](#input\_notes) | Free text field for notes about the service principal. | `string` | `null` | no |
| <a name="input_notification_email_addresses"></a> [notification\_email\_addresses](#input\_notification\_email\_addresses) | A set of email addresses for receiving notifications. | `set(string)` | `[]` | no |
| <a name="input_owners"></a> [owners](#input\_owners) | A set of object IDs of principals that will be granted ownership. | `set(string)` | `[]` | no |
| <a name="input_preferred_single_sign_on_mode"></a> [preferred\_single\_sign\_on\_mode](#input\_preferred\_single\_sign\_on\_mode) | The single sign-on mode configured for this application. Possible values: oidc, password, saml, notSupported. | `string` | `null` | no |
| <a name="input_saml_single_sign_on"></a> [saml\_single\_sign\_on](#input\_saml\_single\_sign\_on) | SAML single sign-on configuration. | <pre>object({<br/>    relay_state = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A set of tags to apply to the service principal. | `set(string)` | `[]` | no |
| <a name="input_use_existing"></a> [use\_existing](#input\_use\_existing) | Whether to use an existing service principal instead of creating a new one. | `bool` | `false` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_app_role_ids"></a> [app\_role\_ids](#output\_app\_role\_ids) | A map of app role values to app role IDs. |
| <a name="output_app_roles"></a> [app\_roles](#output\_app\_roles) | The app roles published by the associated application. |
| <a name="output_application_id"></a> [application\_id](#output\_application\_id) | The application ID (client ID) of the associated application. |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the service principal. |
| <a name="output_homepage_url"></a> [homepage\_url](#output\_homepage\_url) | The home page URL of the service principal. |
| <a name="output_id"></a> [id](#output\_id) | The Terraform resource ID of the service principal. |
| <a name="output_logout_url"></a> [logout\_url](#output\_logout\_url) | The logout URL of the service principal. |
| <a name="output_oauth2_permission_scope_ids"></a> [oauth2\_permission\_scope\_ids](#output\_oauth2\_permission\_scope\_ids) | A map of OAuth 2.0 permission scope values to scope IDs. |
| <a name="output_oauth2_permission_scopes"></a> [oauth2\_permission\_scopes](#output\_oauth2\_permission\_scopes) | The OAuth 2.0 permission scopes published by the associated application. |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | The object ID of the service principal. |
| <a name="output_redirect_uris"></a> [redirect\_uris](#output\_redirect\_uris) | The redirect URIs of the service principal. |
| <a name="output_saml_metadata_url"></a> [saml\_metadata\_url](#output\_saml\_metadata\_url) | The URL where the service exposes SAML metadata for federation. |
| <a name="output_service_principal_names"></a> [service\_principal\_names](#output\_service\_principal\_names) | A list of identifier URIs for the service principal. |
| <a name="output_sign_in_audience"></a> [sign\_in\_audience](#output\_sign\_in\_audience) | The Microsoft account types supported for the associated application. |
| <a name="output_type"></a> [type](#output\_type) | The type of the service principal. |
<!-- END_TF_DOCS -->