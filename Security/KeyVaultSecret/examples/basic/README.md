<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_api_key"></a> [api\_key](#module\_api\_key) | ../../ | n/a |
| <a name="module_connection_string"></a> [connection\_string](#module\_connection\_string) | ../../ | n/a |
| <a name="module_db_password"></a> [db\_password](#module\_db\_password) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_key_vault.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.secrets_officer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [random_password.db](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_api_key_versionless_id"></a> [api\_key\_versionless\_id](#output\_api\_key\_versionless\_id) | n/a |
| <a name="output_db_password_id"></a> [db\_password\_id](#output\_db\_password\_id) | n/a |
<!-- END_TF_DOCS -->