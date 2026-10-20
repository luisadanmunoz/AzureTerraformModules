# Azure Entra ID Application Password (Client Secret)

Terraform module for creating and managing Azure Entra ID (formerly Azure AD) Application Passwords (Client Secrets).

## Features

- **Client Secret Generation**: Create secure client secrets for application authentication
- **Expiration Control**: Configure start and end dates for password validity
- **Relative Expiration**: Set expiration using relative time durations
- **Automatic Rotation**: Trigger rotation based on changed values
- **Sensitive Output**: Password value is marked as sensitive

## Usage

### Basic Client Secret

```hcl
module "app" {
  source = "path/to/EntraID/Application"

  display_name = "my-application"
}

module "app_secret" {
  source = "path/to/EntraID/ApplicationPassword"

  application_id = module.app.id
  display_name   = "terraform-managed-secret"
}

# Store the secret securely (e.g., in Key Vault)
resource "azurerm_key_vault_secret" "app_secret" {
  name         = "app-client-secret"
  value        = module.app_secret.value
  key_vault_id = azurerm_key_vault.main.id
}
```

### Client Secret with Custom Expiration

```hcl
module "app_secret_expiring" {
  source = "path/to/EntraID/ApplicationPassword"

  application_id = module.app.id
  display_name   = "short-lived-secret"

  # Expires in 90 days
  end_date_relative = "2160h"  # 90 days * 24 hours
}
```

### Client Secret with Fixed Dates

```hcl
module "app_secret_dated" {
  source = "path/to/EntraID/ApplicationPassword"

  application_id = module.app.id
  display_name   = "fixed-date-secret"

  start_date = "2024-01-01T00:00:00Z"
  end_date   = "2024-12-31T23:59:59Z"
}
```

### Rotating Secret Based on Changes

```hcl
module "app_secret_rotating" {
  source = "path/to/EntraID/ApplicationPassword"

  application_id = module.app.id
  display_name   = "rotating-secret"

  rotate_when_changed = {
    rotation = plantimestamp()  # Rotates on each apply
  }
}
```

### Multiple Secrets for Rotation Strategy

```hcl
# Primary secret
module "app_secret_primary" {
  source = "path/to/EntraID/ApplicationPassword"

  application_id = module.app.id
  display_name   = "primary-secret"
  end_date_relative = "4320h"  # 180 days
}

# Secondary secret (for zero-downtime rotation)
module "app_secret_secondary" {
  source = "path/to/EntraID/ApplicationPassword"

  application_id = module.app.id
  display_name   = "secondary-secret"
  end_date_relative = "4320h"  # 180 days
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
| application_id | The resource ID of the application | `string` | `null` | yes* |
| application_object_id | The object ID of the application (deprecated) | `string` | `null` | yes* |
| create | Whether to create the password | `bool` | `true` | no |
| display_name | Display name for the password | `string` | `null` | no |
| end_date | End date (RFC3339 format) | `string` | `null` | no |
| end_date_relative | Relative duration (e.g., "2160h") | `string` | `null` | no |
| start_date | Start date (RFC3339 format) | `string` | `null` | no |
| rotate_when_changed | Map of values to trigger rotation | `map(string)` | `null` | no |

*Note: Either `application_id` or `application_object_id` must be provided.

## Outputs

| Name | Description |
|------|-------------|
| id | The Terraform resource ID |
| key_id | UUID identifying this password credential |
| display_name | Display name of the password |
| value | The password value (sensitive) |
| start_date | Start date of validity |
| end_date | End date of validity |

## Best Practices

1. **Short Expiration**: Use short expiration periods (90-180 days) and rotate regularly
2. **Secure Storage**: Store the secret value in Azure Key Vault immediately after creation
3. **Multiple Secrets**: Maintain multiple active secrets for zero-downtime rotation
4. **Meaningful Names**: Use descriptive display names for audit purposes
5. **Avoid Terraform State**: Consider using `rotate_when_changed` to minimize secret exposure in state
6. **Monitor Expiration**: Set up alerts for secrets approaching expiration
7. **Prefer Managed Identity**: Use Managed Identity instead of secrets when possible

## Security Considerations

- The `value` output is marked as sensitive but will still be stored in Terraform state
- Consider using remote state with encryption enabled
- Rotate secrets before they expire to avoid service disruptions
- Audit and remove unused secrets regularly

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
| [azuread_application_password.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_application_id"></a> [application\_id](#input\_application\_id) | The resource ID of the application for which this password should be created. Use either application\_id or application\_object\_id. | `string` | `null` | no |
| <a name="input_application_object_id"></a> [application\_object\_id](#input\_application\_object\_id) | The object ID of the application for which this password should be created. Use either application\_id or application\_object\_id. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the application password. | `bool` | `true` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | A display name for the password. If not specified, a random name will be generated. | `string` | `null` | no |
| <a name="input_end_date"></a> [end\_date](#input\_end\_date) | The end date until which the password is valid, formatted as an RFC3339 date string (e.g. 2025-01-01T00:00:00Z). If not specified, defaults to 2 years from creation. | `string` | `null` | no |
| <a name="input_end_date_relative"></a> [end\_date\_relative](#input\_end\_date\_relative) | A relative duration for which the password is valid, for example 240h (10 days) or 2400h30m. Valid time units are ns, us, ms, s, m, h. | `string` | `null` | no |
| <a name="input_rotate_when_changed"></a> [rotate\_when\_changed](#input\_rotate\_when\_changed) | A map of values that, when changed, will trigger rotation of the password. | `map(string)` | `null` | no |
| <a name="input_start_date"></a> [start\_date](#input\_start\_date) | The start date from which the password is valid, formatted as an RFC3339 date string (e.g. 2024-01-01T00:00:00Z). If not specified, the current date is used. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the password. |
| <a name="output_end_date"></a> [end\_date](#output\_end\_date) | The end date until which the password is valid. |
| <a name="output_id"></a> [id](#output\_id) | The Terraform resource ID of the application password. |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | A UUID used to uniquely identify this password credential. |
| <a name="output_start_date"></a> [start\_date](#output\_start\_date) | The start date from which the password is valid. |
| <a name="output_value"></a> [value](#output\_value) | The password value. This is a sensitive value and should be stored securely. |
<!-- END_TF_DOCS -->