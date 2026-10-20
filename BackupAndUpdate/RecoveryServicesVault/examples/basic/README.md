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
| <a name="module_recovery_vault_basic"></a> [recovery\_vault\_basic](#module\_recovery\_vault\_basic) | ../../ | n/a |
| <a name="module_recovery_vault_prod"></a> [recovery\_vault\_prod](#module\_recovery\_vault\_prod) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_log_analytics_workspace.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_basic_vault_id"></a> [basic\_vault\_id](#output\_basic\_vault\_id) | The ID of the basic Recovery Services Vault |
| <a name="output_basic_vault_name"></a> [basic\_vault\_name](#output\_basic\_vault\_name) | The name of the basic Recovery Services Vault |
| <a name="output_prod_vault_id"></a> [prod\_vault\_id](#output\_prod\_vault\_id) | The ID of the production Recovery Services Vault |
| <a name="output_prod_vault_name"></a> [prod\_vault\_name](#output\_prod\_vault\_name) | The name of the production Recovery Services Vault |
<!-- END_TF_DOCS -->