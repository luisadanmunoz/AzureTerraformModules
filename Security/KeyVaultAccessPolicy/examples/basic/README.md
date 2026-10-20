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
| <a name="module_admin_policy"></a> [admin\_policy](#module\_admin\_policy) | ../../ | n/a |
| <a name="module_app_policy"></a> [app\_policy](#module\_app\_policy) | ../../ | n/a |
| <a name="module_readonly_policy"></a> [readonly\_policy](#module\_readonly\_policy) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_key_vault.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_admin_policy_id"></a> [admin\_policy\_id](#output\_admin\_policy\_id) | n/a |
| <a name="output_app_policy_id"></a> [app\_policy\_id](#output\_app\_policy\_id) | n/a |
| <a name="output_readonly_policy_id"></a> [readonly\_policy\_id](#output\_readonly\_policy\_id) | n/a |
<!-- END_TF_DOCS -->