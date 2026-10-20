# Key Vault Certificate

Terraform module for Azure Key Vault Certificate.

## Features

- Self-signed certificate generation
- CA-signed certificate requests
- Import existing PFX/PKCS#12 certificates
- Automatic certificate rotation with lifetime actions
- Subject Alternative Names (SANs) support
- Configurable key properties and X.509 attributes

## Usage

### Self-Signed Certificate

```hcl
module "certificate" {
  source = "./Security/KeyVaultCertificate"

  name         = "app-self-signed"
  key_vault_id = module.keyvault.id

  certificate_policy = {
    issuer_parameters = {
      name = "Self"
    }
    key_properties = {
      exportable = true
      key_type   = "RSA"
      key_size   = 2048
      reuse_key  = true
    }
    secret_properties = {
      content_type = "application/x-pkcs12"
    }
    lifetime_action = [
      {
        action = {
          action_type = "AutoRenew"
        }
        trigger = {
          days_before_expiry = 30
        }
      }
    ]
    x509_certificate_properties = {
      subject            = "CN=app.example.com"
      validity_in_months = 12
      key_usage = [
        "digitalSignature",
        "keyEncipherment",
      ]
      subject_alternative_names = {
        dns_names = ["app.example.com", "*.app.example.com"]
      }
    }
  }

  tags = {
    Application = "MyApp"
  }
}
```

### Import Existing PFX Certificate

```hcl
module "imported_cert" {
  source = "./Security/KeyVaultCertificate"

  name         = "imported-cert"
  key_vault_id = module.keyvault.id

  certificate = {
    contents = filebase64("./certs/mycert.pfx")
    password = var.pfx_password
  }

  certificate_policy = {
    issuer_parameters = {
      name = "Unknown"
    }
    key_properties = {
      exportable = true
      key_type   = "RSA"
      key_size   = 2048
      reuse_key  = false
    }
    secret_properties = {
      content_type = "application/x-pkcs12"
    }
    x509_certificate_properties = {
      subject            = "CN=mysite.example.com"
      validity_in_months = 12
      key_usage = [
        "digitalSignature",
        "keyEncipherment",
      ]
    }
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
| name | Certificate name | `string` | n/a | yes |
| key_vault_id | Key Vault ID | `string` | n/a | yes |
| create | Controls resource creation | `bool` | `true` | no |
| certificate | PFX certificate to import (contents, password) | `object` | `null` | no |
| certificate_policy | Certificate policy configuration | `object` | `null` | no |
| tags | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Certificate ID (with version) |
| name | Certificate name |
| version | Current version |
| versionless_id | ID without version |
| certificate_data | Raw certificate data in PEM format |
| certificate_data_base64 | Base64 encoded certificate data |
| thumbprint | X509 thumbprint in hex format |
| secret_id | Associated Key Vault Secret ID |
| resource_manager_id | Resource Manager ID |
| resource_manager_versionless_id | Versionless Resource Manager ID |

## Best Practices

1. **Use auto-renewal** - Configure lifetime actions to automatically renew certificates before expiry
2. **Set appropriate key size** - Use RSA 2048 or higher for production workloads
3. **Use SANs** - Add Subject Alternative Names for multi-domain certificates
4. **Secure PFX imports** - Store PFX passwords as Key Vault secrets, not in code
5. **Monitor expiration** - Set up alerts for certificates nearing expiration
