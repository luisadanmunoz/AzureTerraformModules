<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |
| <a name="provider_pkcs12"></a> [pkcs12](#provider\_pkcs12) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.0.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_automation_certificates"></a> [automation\_certificates](#module\_automation\_certificates) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_automation_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_account) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [pkcs12_from_pem.example](https://registry.terraform.io/providers/hashicorp/pkcs12/latest/docs/resources/from_pem) | resource |
| [tls_private_key.example](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.example](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_certificate_expiry_dates"></a> [certificate\_expiry\_dates](#output\_certificate\_expiry\_dates) | n/a |
| <a name="output_certificate_ids"></a> [certificate\_ids](#output\_certificate\_ids) | n/a |
| <a name="output_certificate_thumbprints"></a> [certificate\_thumbprints](#output\_certificate\_thumbprints) | n/a |
<!-- END_TF_DOCS -->