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
| <a name="module_ec_signing_key"></a> [ec\_signing\_key](#module\_ec\_signing\_key) | ../../ | n/a |
| <a name="module_rotating_key"></a> [rotating\_key](#module\_rotating\_key) | ../../ | n/a |
| <a name="module_rsa_encryption_key"></a> [rsa\_encryption\_key](#module\_rsa\_encryption\_key) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_key_vault.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.crypto_officer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_ec_key_id"></a> [ec\_key\_id](#output\_ec\_key\_id) | n/a |
| <a name="output_rotating_key_versionless_id"></a> [rotating\_key\_versionless\_id](#output\_rotating\_key\_versionless\_id) | n/a |
| <a name="output_rsa_key_id"></a> [rsa\_key\_id](#output\_rsa\_key\_id) | n/a |
| <a name="output_rsa_public_key_pem"></a> [rsa\_public\_key\_pem](#output\_rsa\_public\_key\_pem) | n/a |
<!-- END_TF_DOCS -->