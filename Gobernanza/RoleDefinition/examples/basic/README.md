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
| <a name="module_cost_reader"></a> [cost\_reader](#module\_cost\_reader) | ../../ | n/a |
| <a name="module_devops_engineer"></a> [devops\_engineer](#module\_devops\_engineer) | ../../ | n/a |
| <a name="module_keyvault_secrets_reader"></a> [keyvault\_secrets\_reader](#module\_keyvault\_secrets\_reader) | ../../ | n/a |
| <a name="module_storage_processor"></a> [storage\_processor](#module\_storage\_processor) | ../../ | n/a |
| <a name="module_vm_operator"></a> [vm\_operator](#module\_vm\_operator) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cost_reader_id"></a> [cost\_reader\_id](#output\_cost\_reader\_id) | n/a |
| <a name="output_devops_engineer_id"></a> [devops\_engineer\_id](#output\_devops\_engineer\_id) | n/a |
| <a name="output_keyvault_reader_id"></a> [keyvault\_reader\_id](#output\_keyvault\_reader\_id) | n/a |
| <a name="output_storage_processor_id"></a> [storage\_processor\_id](#output\_storage\_processor\_id) | n/a |
| <a name="output_vm_operator_id"></a> [vm\_operator\_id](#output\_vm\_operator\_id) | n/a |
<!-- END_TF_DOCS -->