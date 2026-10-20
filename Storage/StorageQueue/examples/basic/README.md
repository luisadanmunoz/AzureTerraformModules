<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_multiple_queues"></a> [multiple\_queues](#module\_multiple\_queues) | ../../ | n/a |
| <a name="module_single_queue"></a> [single\_queue](#module\_single\_queue) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_multiple_queue_ids"></a> [multiple\_queue\_ids](#output\_multiple\_queue\_ids) | Map of queue names to their IDs |
| <a name="output_multiple_queue_names"></a> [multiple\_queue\_names](#output\_multiple\_queue\_names) | Map of queue keys to their names |
| <a name="output_single_queue_id"></a> [single\_queue\_id](#output\_single\_queue\_id) | The ID of the single Storage Queue |
| <a name="output_single_queue_name"></a> [single\_queue\_name](#output\_single\_queue\_name) | The name of the single Storage Queue |
<!-- END_TF_DOCS -->