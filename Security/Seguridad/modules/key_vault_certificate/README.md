<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_key_vault_certificate.key_vault_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_certificate"></a> [certificate](#input\_certificate) | value to set the certificate import block | <pre>object({<br/>    contents = string<br/>    password = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_certificate_policy"></a> [certificate\_policy](#input\_certificate\_policy) | value to set the certificate policy | <pre>object({<br/>    issuer_parameters = object({<br/>      name = string<br/>    })<br/>    key_properties = object({<br/>      exportable = bool<br/>      key_type   = string<br/>      reuse_key  = bool<br/>      curve      = optional(string)<br/>      key_size   = optional(number)<br/>    })<br/>    lifetime_actions = optional(list(object({<br/>      action = object({<br/>        action_type = string<br/>      })<br/>      trigger = object({<br/>        days_before_expiry  = optional(number)<br/>        lifetime_percentage = optional(number)<br/>      })<br/>    })))<br/>    secret_properties = object({<br/>      content_type = string<br/>    })<br/>    x509_certificate_properties = object({<br/>      subject            = string<br/>      validity_in_months = number<br/>      key_usage          = list(string)<br/>      extended_key_usage = optional(list(string))<br/>      subject_alternative_names = optional(object({<br/>        dns_names = optional(list(string))<br/>        emails    = optional(list(string))<br/>        upns      = optional(list(string))<br/>      }))<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_key_vault_certificate_name"></a> [key\_vault\_certificate\_name](#input\_key\_vault\_certificate\_name) | value to set the key vault certificate name | `string` | n/a | yes |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | value to set the key vault id | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT KEY VAULT CERTIFICATE ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_versionless_id"></a> [versionless\_id](#output\_versionless\_id) | n/a |
| <a name="output_versionless_secret_id"></a> [versionless\_secret\_id](#output\_versionless\_secret\_id) | n/a |
<!-- END_TF_DOCS -->