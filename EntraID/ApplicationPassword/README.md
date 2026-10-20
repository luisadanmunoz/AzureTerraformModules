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
