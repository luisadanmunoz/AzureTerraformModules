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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_key_vault_secret.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_content_type"></a> [content\_type](#input\_content\_type) | The content type of the secret (e.g., text/plain, application/json). | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_expiration_date"></a> [expiration\_date](#input\_expiration\_date) | The date after which the secret expires (ISO 8601 format). | `string` | `null` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | The ID of the Key Vault where the secret will be stored. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Key Vault Secret. | `string` | n/a | yes |
| <a name="input_not_before_date"></a> [not\_before\_date](#input\_not\_before\_date) | The date before which the secret is not valid (ISO 8601 format). | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the secret. | `map(string)` | `{}` | no |
| <a name="input_value"></a> [value](#input\_value) | The value of the secret. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Key Vault Secret. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Key Vault Secret. |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The Resource ID of the Key Vault Secret. |
| <a name="output_resource_versionless_id"></a> [resource\_versionless\_id](#output\_resource\_versionless\_id) | The versionless Resource ID of the Key Vault Secret. |
| <a name="output_version"></a> [version](#output\_version) | The current version of the Key Vault Secret. |
| <a name="output_versionless_id"></a> [versionless\_id](#output\_versionless\_id) | The versionless ID of the Key Vault Secret. |
<!-- END_TF_DOCS -->