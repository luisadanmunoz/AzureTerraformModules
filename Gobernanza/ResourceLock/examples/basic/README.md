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
| <a name="module_lock_critical_storage"></a> [lock\_critical\_storage](#module\_lock\_critical\_storage) | ../../ | n/a |
| <a name="module_lock_production_rg"></a> [lock\_production\_rg](#module\_lock\_production\_rg) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.production](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.critical](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_rg_lock_id"></a> [rg\_lock\_id](#output\_rg\_lock\_id) | n/a |
| <a name="output_storage_lock_id"></a> [storage\_lock\_id](#output\_storage\_lock\_id) | n/a |
<!-- END_TF_DOCS -->