<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.45.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.45.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.0.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_cert_primary"></a> [cert\_primary](#module\_cert\_primary) | ../../ | n/a |
| <a name="module_cert_secondary"></a> [cert\_secondary](#module\_cert\_secondary) | ../../ | n/a |
| <a name="module_cert_self_signed"></a> [cert\_self\_signed](#module\_cert\_self\_signed) | ../../ | n/a |
| <a name="module_cert_short_lived"></a> [cert\_short\_lived](#module\_cert\_short\_lived) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azuread_application.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [tls_private_key.example](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.primary](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.secondary](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.short_lived](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.example](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [tls_self_signed_cert.primary](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [tls_self_signed_cert.secondary](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [tls_self_signed_cert.short_lived](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_application_client_id"></a> [application\_client\_id](#output\_application\_client\_id) | Client ID of the application |
| <a name="output_primary_cert_key_id"></a> [primary\_cert\_key\_id](#output\_primary\_cert\_key\_id) | Key ID of the primary certificate |
| <a name="output_secondary_cert_key_id"></a> [secondary\_cert\_key\_id](#output\_secondary\_cert\_key\_id) | Key ID of the secondary certificate |
| <a name="output_self_signed_cert_end_date"></a> [self\_signed\_cert\_end\_date](#output\_self\_signed\_cert\_end\_date) | Expiration date of the self-signed certificate |
| <a name="output_self_signed_cert_key_id"></a> [self\_signed\_cert\_key\_id](#output\_self\_signed\_cert\_key\_id) | Key ID of the self-signed certificate |
| <a name="output_short_lived_cert_key_id"></a> [short\_lived\_cert\_key\_id](#output\_short\_lived\_cert\_key\_id) | Key ID of the short-lived certificate |
<!-- END_TF_DOCS -->