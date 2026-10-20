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
| [azurerm_key_vault_certificate.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_certificate"></a> [certificate](#input\_certificate) | A PFX certificate to import. Use this to import an existing certificate. | <pre>object({<br/>    contents = string<br/>    password = optional(string, "")<br/>  })</pre> | `null` | no |
| <a name="input_certificate_policy"></a> [certificate\_policy](#input\_certificate\_policy) | The certificate policy for generating or managing the certificate. | <pre>object({<br/>    issuer_parameters = object({<br/>      name = string<br/>    })<br/>    key_properties = object({<br/>      exportable = bool<br/>      key_type   = string<br/>      key_size   = number<br/>      reuse_key  = bool<br/>    })<br/>    secret_properties = object({<br/>      content_type = string<br/>    })<br/>    lifetime_action = optional(list(object({<br/>      action = object({<br/>        action_type = string<br/>      })<br/>      trigger = object({<br/>        days_before_expiry  = optional(number)<br/>        lifetime_percentage = optional(number)<br/>      })<br/>    })), [])<br/>    x509_certificate_properties = object({<br/>      subject            = string<br/>      validity_in_months = number<br/>      key_usage          = list(string)<br/>      extended_key_usage = optional(list(string), [])<br/>      subject_alternative_names = optional(object({<br/>        dns_names = optional(list(string), [])<br/>        emails    = optional(list(string), [])<br/>        upns      = optional(list(string), [])<br/>      }))<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | The ID of the Key Vault where the certificate will be stored. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Key Vault Certificate. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the certificate. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_certificate_data"></a> [certificate\_data](#output\_certificate\_data) | The raw certificate data in PEM format. |
| <a name="output_certificate_data_base64"></a> [certificate\_data\_base64](#output\_certificate\_data\_base64) | The Base64 encoded certificate data in PEM format. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Key Vault Certificate. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Key Vault Certificate. |
| <a name="output_resource_manager_id"></a> [resource\_manager\_id](#output\_resource\_manager\_id) | The Resource Manager ID of the Key Vault Certificate. |
| <a name="output_resource_manager_versionless_id"></a> [resource\_manager\_versionless\_id](#output\_resource\_manager\_versionless\_id) | The versionless Resource Manager ID of the Key Vault Certificate. |
| <a name="output_secret_id"></a> [secret\_id](#output\_secret\_id) | The ID of the associated Key Vault Secret. |
| <a name="output_thumbprint"></a> [thumbprint](#output\_thumbprint) | The X509 thumbprint of the certificate in hex format. |
| <a name="output_version"></a> [version](#output\_version) | The current version of the Key Vault Certificate. |
| <a name="output_versionless_id"></a> [versionless\_id](#output\_versionless\_id) | The versionless ID of the Key Vault Certificate. |
<!-- END_TF_DOCS -->