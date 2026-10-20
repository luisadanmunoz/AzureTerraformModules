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
| <a name="module_eventgrid_system_topic"></a> [eventgrid\_system\_topic](#module\_eventgrid\_system\_topic) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.uploads](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_event_subscription_ids"></a> [event\_subscription\_ids](#output\_event\_subscription\_ids) | Map of event subscription names to their IDs |
| <a name="output_metric_arm_resource_id"></a> [metric\_arm\_resource\_id](#output\_metric\_arm\_resource\_id) | The Metric ARM Resource ID for monitoring |
| <a name="output_system_topic_id"></a> [system\_topic\_id](#output\_system\_topic\_id) | The ID of the Event Grid System Topic |
| <a name="output_system_topic_name"></a> [system\_topic\_name](#output\_system\_topic\_name) | The name of the Event Grid System Topic |
| <a name="output_system_topic_principal_id"></a> [system\_topic\_principal\_id](#output\_system\_topic\_principal\_id) | The Principal ID of the System Assigned Managed Identity |
<!-- END_TF_DOCS -->