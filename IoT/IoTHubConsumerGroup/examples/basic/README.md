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
| <a name="module_consumer_group_analytics"></a> [consumer\_group\_analytics](#module\_consumer\_group\_analytics) | ../../ | n/a |
| <a name="module_consumer_group_processing"></a> [consumer\_group\_processing](#module\_consumer\_group\_processing) | ../../ | n/a |
| <a name="module_iot_hub"></a> [iot\_hub](#module\_iot\_hub) | ../../../IoTHub | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_analytics_consumer_group_id"></a> [analytics\_consumer\_group\_id](#output\_analytics\_consumer\_group\_id) | The ID of the analytics consumer group. |
| <a name="output_processing_consumer_group_id"></a> [processing\_consumer\_group\_id](#output\_processing\_consumer\_group\_id) | The ID of the processing consumer group. |
<!-- END_TF_DOCS -->