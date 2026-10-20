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
| [azuread_application.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_api"></a> [api](#input\_api) | API configuration for the application. | <pre>object({<br/>    mapped_claims_enabled          = optional(bool, false)<br/>    requested_access_token_version = optional(number, 2)<br/>    known_client_applications      = optional(list(string), [])<br/>    oauth2_permission_scope = optional(list(object({<br/>      id                         = string<br/>      admin_consent_description  = string<br/>      admin_consent_display_name = string<br/>      enabled                    = optional(bool, true)<br/>      type                       = optional(string, "User")<br/>      user_consent_description   = optional(string)<br/>      user_consent_display_name  = optional(string)<br/>      value                      = string<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_app_roles"></a> [app\_roles](#input\_app\_roles) | A collection of app roles that the application may declare. | <pre>list(object({<br/>    id                   = string<br/>    allowed_member_types = list(string)<br/>    description          = string<br/>    display_name         = string<br/>    enabled              = optional(bool, true)<br/>    value                = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the application. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the application, as shown to end users. | `string` | `null` | no |
| <a name="input_device_only_auth_enabled"></a> [device\_only\_auth\_enabled](#input\_device\_only\_auth\_enabled) | Specifies whether this application supports device authentication without a user. | `bool` | `false` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name for the application. | `string` | n/a | yes |
| <a name="input_fallback_public_client_enabled"></a> [fallback\_public\_client\_enabled](#input\_fallback\_public\_client\_enabled) | Specifies whether the application is a public client. Appropriate for apps using token grant flows that don't use a redirect URI. | `bool` | `false` | no |
| <a name="input_feature_tags"></a> [feature\_tags](#input\_feature\_tags) | Block of features to configure for this application using tags. | <pre>object({<br/>    custom_single_sign_on = optional(bool, false)<br/>    enterprise            = optional(bool, false)<br/>    gallery               = optional(bool, false)<br/>    hide                  = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_group_membership_claims"></a> [group\_membership\_claims](#input\_group\_membership\_claims) | Configures the groups claim issued in tokens. Possible values are: None, SecurityGroup, DirectoryRole, ApplicationGroup, All. | `list(string)` | `[]` | no |
| <a name="input_identifier_uris"></a> [identifier\_uris](#input\_identifier\_uris) | A list of user-defined URIs that uniquely identify the application within its Azure AD tenant. | `list(string)` | `[]` | no |
| <a name="input_logo_image"></a> [logo\_image](#input\_logo\_image) | A logo image to upload for the application, as a raw base64-encoded string. | `string` | `null` | no |
| <a name="input_marketing_url"></a> [marketing\_url](#input\_marketing\_url) | URL of the application's marketing page. | `string` | `null` | no |
| <a name="input_notes"></a> [notes](#input\_notes) | User-specified notes relevant for the management of the application. | `string` | `null` | no |
| <a name="input_oauth2_post_response_required"></a> [oauth2\_post\_response\_required](#input\_oauth2\_post\_response\_required) | Specifies whether, as part of OAuth 2.0 token requests, Azure AD allows POST requests, as opposed to GET requests. | `bool` | `false` | no |
| <a name="input_optional_claims"></a> [optional\_claims](#input\_optional\_claims) | Optional claims configuration for ID tokens, access tokens, and SAML2 tokens. | <pre>object({<br/>    access_token = optional(list(object({<br/>      name                  = string<br/>      additional_properties = optional(list(string), [])<br/>      essential             = optional(bool, false)<br/>      source                = optional(string)<br/>    })), [])<br/>    id_token = optional(list(object({<br/>      name                  = string<br/>      additional_properties = optional(list(string), [])<br/>      essential             = optional(bool, false)<br/>      source                = optional(string)<br/>    })), [])<br/>    saml2_token = optional(list(object({<br/>      name                  = string<br/>      additional_properties = optional(list(string), [])<br/>      essential             = optional(bool, false)<br/>      source                = optional(string)<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_owners"></a> [owners](#input\_owners) | A list of object IDs of principals that will be granted ownership of the application. | `list(string)` | `[]` | no |
| <a name="input_prevent_duplicate_names"></a> [prevent\_duplicate\_names](#input\_prevent\_duplicate\_names) | If true, will return an error if an existing application is found with the same name. | `bool` | `true` | no |
| <a name="input_privacy_statement_url"></a> [privacy\_statement\_url](#input\_privacy\_statement\_url) | URL of the application's privacy statement. | `string` | `null` | no |
| <a name="input_public_client"></a> [public\_client](#input\_public\_client) | Public client (mobile & desktop) configuration including redirect URIs. | <pre>object({<br/>    redirect_uris = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_required_resource_access"></a> [required\_resource\_access](#input\_required\_resource\_access) | A collection of required resource access for the application (API permissions). | <pre>list(object({<br/>    resource_app_id = string<br/>    resource_access = list(object({<br/>      id   = string<br/>      type = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_service_management_reference"></a> [service\_management\_reference](#input\_service\_management\_reference) | References application context information from a Service or Asset Management database. | `string` | `null` | no |
| <a name="input_sign_in_audience"></a> [sign\_in\_audience](#input\_sign\_in\_audience) | The Microsoft account types that are supported for the application. Possible values are: AzureADMyOrg, AzureADMultipleOrgs, AzureADandPersonalMicrosoftAccount, PersonalMicrosoftAccount. | `string` | `"AzureADMyOrg"` | no |
| <a name="input_single_page_application"></a> [single\_page\_application](#input\_single\_page\_application) | Single-page application configuration including redirect URIs. | <pre>object({<br/>    redirect_uris = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_support_url"></a> [support\_url](#input\_support\_url) | URL of the application's support page. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A set of tags to apply to the application. | `set(string)` | `[]` | no |
| <a name="input_terms_of_service_url"></a> [terms\_of\_service\_url](#input\_terms\_of\_service\_url) | URL of the application's terms of service statement. | `string` | `null` | no |
| <a name="input_web"></a> [web](#input\_web) | Web configuration for the application including redirect URIs and implicit grant settings. | <pre>object({<br/>    homepage_url  = optional(string)<br/>    logout_url    = optional(string)<br/>    redirect_uris = optional(list(string), [])<br/>    implicit_grant = optional(object({<br/>      access_token_issuance_enabled = optional(bool, false)<br/>      id_token_issuance_enabled     = optional(bool, false)<br/>    }))<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_app_role_ids"></a> [app\_role\_ids](#output\_app\_role\_ids) | A map of app role values to app role IDs. |
| <a name="output_application_id"></a> [application\_id](#output\_application\_id) | The application ID (client ID) of the application. |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | The client ID of the application (alias for application\_id). |
| <a name="output_disabled_by_microsoft"></a> [disabled\_by\_microsoft](#output\_disabled\_by\_microsoft) | Whether Microsoft has disabled the registered application. |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the application. |
| <a name="output_id"></a> [id](#output\_id) | The Terraform resource ID of the application. |
| <a name="output_logo_url"></a> [logo\_url](#output\_logo\_url) | CDN URL to the application's logo. |
| <a name="output_oauth2_permission_scope_ids"></a> [oauth2\_permission\_scope\_ids](#output\_oauth2\_permission\_scope\_ids) | A map of OAuth2 permission scope values to scope IDs. |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | The object ID of the application. |
| <a name="output_publisher_domain"></a> [publisher\_domain](#output\_publisher\_domain) | The verified publisher domain for the application. |
<!-- END_TF_DOCS -->