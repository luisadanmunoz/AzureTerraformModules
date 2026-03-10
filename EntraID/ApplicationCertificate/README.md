# Azure Entra ID Application Certificate

Terraform module for creating and managing Azure Entra ID (formerly Azure AD) Application Certificates for certificate-based authentication.

## Features

- **Certificate Authentication**: Configure X.509 certificates for secure app authentication
- **Multiple Encodings**: Support for PEM, Base64, and Hex-encoded certificates
- **Expiration Control**: Configure start and end dates for certificate validity
- **Relative Expiration**: Set expiration using relative time durations
- **Key Types**: Support for asymmetric X.509 and symmetric keys

## Usage

### Basic Certificate (PEM Encoded)

```hcl
module "app" {
  source = "path/to/EntraID/Application"

  display_name = "my-application"
}

module "app_cert" {
  source = "path/to/EntraID/ApplicationCertificate"

  application_id = module.app.id
  value          = file("certificate.pem")
  encoding       = "pem"
}
```

### Self-Signed Certificate with TLS Provider

```hcl
resource "tls_private_key" "app" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "app" {
  private_key_pem = tls_private_key.app.private_key_pem

  subject {
    common_name  = "my-application"
    organization = "My Organization"
  }

  validity_period_hours = 8760  # 1 year

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}

module "app_cert" {
  source = "path/to/EntraID/ApplicationCertificate"

  application_id = module.app.id
  value          = tls_self_signed_cert.app.cert_pem
  encoding       = "pem"
}
```

### Certificate with Custom Validity Period

```hcl
module "app_cert_custom" {
  source = "path/to/EntraID/ApplicationCertificate"

  application_id    = module.app.id
  value             = file("certificate.pem")
  encoding          = "pem"
  end_date_relative = "8760h"  # 1 year
}
```

### Certificate from Key Vault

```hcl
data "azurerm_key_vault_certificate" "app" {
  name         = "app-certificate"
  key_vault_id = azurerm_key_vault.main.id
}

module "app_cert_kv" {
  source = "path/to/EntraID/ApplicationCertificate"

  application_id = module.app.id
  value          = data.azurerm_key_vault_certificate.app.certificate_data_base64
  encoding       = "base64"
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
| application_id | The resource ID of the application | `string` | n/a | yes |
| value | The certificate data (PEM, Base64, or Hex encoded) | `string` | n/a | yes |
| create | Whether to create the certificate | `bool` | `true` | no |
| encoding | Certificate encoding (pem, base64, hex) | `string` | `"pem"` | no |
| key_id | UUID to identify this certificate | `string` | `null` | no |
| start_date | Start date (RFC3339 format) | `string` | `null` | no |
| end_date | End date (RFC3339 format) | `string` | `null` | no |
| end_date_relative | Relative duration (e.g., "8760h") | `string` | `null` | no |
| type | Key type (AsymmetricX509Cert, Symmetric) | `string` | `"AsymmetricX509Cert"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Terraform resource ID |
| key_id | UUID identifying this certificate |
| start_date | Start date of validity |
| end_date | End date of validity |

## Best Practices

1. **Use Managed Certificates**: Store certificates in Azure Key Vault for centralized management
2. **Certificate Rotation**: Plan for certificate rotation before expiration
3. **RSA 2048+**: Use RSA 2048-bit keys or stronger for production
4. **Private Key Security**: Never commit private keys to version control
5. **Monitor Expiration**: Set up alerts for certificates approaching expiration
6. **Prefer Certificates**: Use certificates over client secrets for higher security
7. **Multiple Certificates**: Maintain overlapping certificates for zero-downtime rotation

## Security Considerations

- The certificate value is marked as sensitive
- Only upload the public certificate (not the private key) to Azure AD
- Store private keys securely in Azure Key Vault or HSM
- Use certificate-based authentication for service-to-service communication
- Consider using managed identities instead when possible
