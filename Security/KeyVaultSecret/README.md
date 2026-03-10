# Key Vault Secret

Terraform module for Azure Key Vault Secret.

## Features

- Secret storage with versioning
- Content type specification
- Expiration and activation dates
- Tag support

## Usage

### Basic Secret

```hcl
module "secret" {
  source = "./Security/KeyVaultSecret"

  name         = "database-password"
  key_vault_id = module.keyvault.id
  value        = var.db_password
}
```

### Secret with Expiration

```hcl
module "secret" {
  source = "./Security/KeyVaultSecret"

  name            = "api-key"
  key_vault_id    = module.keyvault.id
  value           = var.api_key
  content_type    = "application/json"
  expiration_date = "2025-12-31T23:59:59Z"

  tags = {
    Application = "MyApp"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Secret name | `string` | n/a | yes |
| key_vault_id | Key Vault ID | `string` | n/a | yes |
| value | Secret value | `string` | n/a | yes |
| content_type | Content type | `string` | `null` | no |
| expiration_date | Expiration date | `string` | `null` | no |
| not_before_date | Activation date | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Secret ID (with version) |
| name | Secret name |
| version | Current version |
| versionless_id | ID without version |

## Best Practices

1. **Use expiration dates** - Rotate secrets regularly
2. **Set content type** - Document what the secret contains
3. **Don't store in state** - Use `sensitive = true` for values
