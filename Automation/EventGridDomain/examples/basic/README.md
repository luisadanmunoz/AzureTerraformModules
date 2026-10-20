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
| <a name="module_eventgrid_domain"></a> [eventgrid\_domain](#module\_eventgrid\_domain) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_domain_endpoint"></a> [domain\_endpoint](#output\_domain\_endpoint) | The endpoint of the Event Grid Domain |
| <a name="output_domain_id"></a> [domain\_id](#output\_domain\_id) | The ID of the Event Grid Domain |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | The name of the Event Grid Domain |
| <a name="output_domain_topic_ids"></a> [domain\_topic\_ids](#output\_domain\_topic\_ids) | Map of domain topic names to their IDs |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID of the system-assigned managed identity |
<!-- END_TF_DOCS -->