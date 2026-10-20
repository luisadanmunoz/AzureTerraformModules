# Key Vault Key

Terraform module for Azure Key Vault Key.

## Features

- RSA and EC key type support (including HSM-backed)
- Configurable key size and elliptic curve
- Key operations permissions (encrypt, decrypt, sign, verify, wrap, unwrap)
- Expiration and activation dates
- Automatic rotation policy
- Public key export (PEM and OpenSSH formats)

## Usage

### Basic RSA Key

```hcl
module "rsa_key" {
  source = "./Security/KeyVaultKey"

  name         = "rsa-encryption-key"
  key_vault_id = module.keyvault.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = ["decrypt", "encrypt", "wrapKey", "unwrapKey"]
}
```

### EC Signing Key

```hcl
module "ec_key" {
  source = "./Security/KeyVaultKey"

  name         = "ec-signing-key"
  key_vault_id = module.keyvault.id
  key_type     = "EC"
  curve        = "P-256"

  key_opts = ["sign", "verify"]

  tags = {
    Purpose = "Signing"
  }
}
```

### Key with Rotation Policy

```hcl
module "rotating_key" {
  source = "./Security/KeyVaultKey"

  name         = "auto-rotating-key"
  key_vault_id = module.keyvault.id
  key_type     = "RSA"
  key_size     = 4096

  expiration_date = "2026-12-31T23:59:59Z"

  rotation_policy = {
    expire_after         = "P90D"
    notify_before_expiry = "P30D"
    automatic = {
      time_before_expiry = "P30D"
    }
  }

  tags = {
    Rotation = "Automatic"
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
| name | Key name | `string` | n/a | yes |
| key_vault_id | Key Vault ID | `string` | n/a | yes |
| key_type | Key type (RSA, RSA-HSM, EC, EC-HSM, oct) | `string` | n/a | yes |
| create | Create resources | `bool` | `true` | no |
| key_size | RSA key size in bits | `number` | `2048` | no |
| curve | EC curve name | `string` | `null` | no |
| key_opts | Permitted key operations | `list(string)` | `["decrypt","encrypt","sign","unwrapKey","verify","wrapKey"]` | no |
| expiration_date | Expiration date (ISO 8601) | `string` | `null` | no |
| not_before_date | Activation date (ISO 8601) | `string` | `null` | no |
| rotation_policy | Rotation policy configuration | `object` | `null` | no |
| tags | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Key ID (with version) |
| name | Key name |
| version | Current version |
| versionless_id | ID without version |
| resource_id | Resource ID |
| resource_versionless_id | Versionless Resource ID |
| public_key_pem | PEM-encoded public key |
| public_key_openssh | OpenSSH-encoded public key |
| n | RSA modulus |
| e | RSA public exponent |

## Best Practices

1. **Use HSM-backed keys for production** - Use RSA-HSM or EC-HSM for hardware-protected keys
2. **Set expiration dates** - Ensure keys are rotated on a regular schedule
3. **Enable rotation policies** - Automate key rotation to reduce operational overhead
4. **Restrict key operations** - Only grant the minimum required key operations
5. **Use EC keys for signing** - Prefer EC keys (P-256 or P-384) for digital signatures

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
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_curve"></a> [curve](#input\_curve) | The EC curve name (P-256, P-256K, P-384, P-521). Only applicable for EC key types. | `string` | `null` | no |
| <a name="input_expiration_date"></a> [expiration\_date](#input\_expiration\_date) | The expiration date of the key in UTC (ISO 8601 format). | `string` | `null` | no |
| <a name="input_key_opts"></a> [key\_opts](#input\_key\_opts) | A list of key operations permitted for this key. | `list(string)` | <pre>[<br/>  "decrypt",<br/>  "encrypt",<br/>  "sign",<br/>  "unwrapKey",<br/>  "verify",<br/>  "wrapKey"<br/>]</pre> | no |
| <a name="input_key_size"></a> [key\_size](#input\_key\_size) | The size of the RSA key in bits (2048, 3072, 4096). Only applicable for RSA key types. | `number` | `2048` | no |
| <a name="input_key_type"></a> [key\_type](#input\_key\_type) | The type of the Key Vault Key (RSA, RSA-HSM, EC, EC-HSM, oct). | `string` | n/a | yes |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | The ID of the Key Vault where the key will be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Key Vault Key. | `string` | n/a | yes |
| <a name="input_not_before_date"></a> [not\_before\_date](#input\_not\_before\_date) | The date before which the key is not valid in UTC (ISO 8601 format). | `string` | `null` | no |
| <a name="input_rotation_policy"></a> [rotation\_policy](#input\_rotation\_policy) | The rotation policy for the key. | <pre>object({<br/>    expire_after         = optional(string)<br/>    notify_before_expiry = optional(string)<br/>    automatic = optional(object({<br/>      time_after_creation = optional(string)<br/>      time_before_expiry  = optional(string)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the key. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_e"></a> [e](#output\_e) | The RSA public exponent of the Key Vault Key. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Key Vault Key. |
| <a name="output_n"></a> [n](#output\_n) | The RSA modulus of the Key Vault Key. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Key Vault Key. |
| <a name="output_public_key_openssh"></a> [public\_key\_openssh](#output\_public\_key\_openssh) | The OpenSSH-encoded public key of the Key Vault Key. |
| <a name="output_public_key_pem"></a> [public\_key\_pem](#output\_public\_key\_pem) | The PEM-encoded public key of the Key Vault Key. |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The Resource ID of the Key Vault Key. |
| <a name="output_resource_versionless_id"></a> [resource\_versionless\_id](#output\_resource\_versionless\_id) | The versionless Resource ID of the Key Vault Key. |
| <a name="output_version"></a> [version](#output\_version) | The current version of the Key Vault Key. |
| <a name="output_versionless_id"></a> [versionless\_id](#output\_versionless\_id) | The versionless ID of the Key Vault Key. |
<!-- END_TF_DOCS -->