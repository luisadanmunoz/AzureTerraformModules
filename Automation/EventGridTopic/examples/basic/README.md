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
| <a name="module_eventgrid_topic"></a> [eventgrid\_topic](#module\_eventgrid\_topic) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_eventgrid_topic_endpoint"></a> [eventgrid\_topic\_endpoint](#output\_eventgrid\_topic\_endpoint) | The endpoint URI of the Event Grid Topic. |
| <a name="output_eventgrid_topic_id"></a> [eventgrid\_topic\_id](#output\_eventgrid\_topic\_id) | The ID of the Event Grid Topic. |
| <a name="output_eventgrid_topic_name"></a> [eventgrid\_topic\_name](#output\_eventgrid\_topic\_name) | The name of the Event Grid Topic. |
<!-- END_TF_DOCS -->