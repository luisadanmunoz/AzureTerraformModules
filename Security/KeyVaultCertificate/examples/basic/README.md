<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_imported_cert"></a> [imported\_cert](#module\_imported\_cert) | ../../ | n/a |
| <a name="module_self_signed_cert"></a> [self\_signed\_cert](#module\_self\_signed\_cert) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_key_vault.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.certificates_officer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_pfx_content"></a> [pfx\_content](#input\_pfx\_content) | Base64 encoded PFX certificate content. | `string` | `""` | no |
| <a name="input_pfx_password"></a> [pfx\_password](#input\_pfx\_password) | Password for the PFX certificate. | `string` | `""` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_imported_cert_id"></a> [imported\_cert\_id](#output\_imported\_cert\_id) | n/a |
| <a name="output_self_signed_cert_id"></a> [self\_signed\_cert\_id](#output\_self\_signed\_cert\_id) | n/a |
| <a name="output_self_signed_cert_secret_id"></a> [self\_signed\_cert\_secret\_id](#output\_self\_signed\_cert\_secret\_id) | n/a |
| <a name="output_self_signed_cert_thumbprint"></a> [self\_signed\_cert\_thumbprint](#output\_self\_signed\_cert\_thumbprint) | n/a |
<!-- END_TF_DOCS -->