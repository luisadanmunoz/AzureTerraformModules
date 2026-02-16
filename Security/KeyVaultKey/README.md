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
