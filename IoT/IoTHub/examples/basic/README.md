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
| <a name="module_iot_hub_advanced"></a> [iot\_hub\_advanced](#module\_iot\_hub\_advanced) | ../../ | n/a |
| <a name="module_iot_hub_basic"></a> [iot\_hub\_basic](#module\_iot\_hub\_basic) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_advanced_iot_hub_id"></a> [advanced\_iot\_hub\_id](#output\_advanced\_iot\_hub\_id) | The ID of the advanced IoT Hub. |
| <a name="output_advanced_iot_hub_principal_id"></a> [advanced\_iot\_hub\_principal\_id](#output\_advanced\_iot\_hub\_principal\_id) | The principal ID of the advanced IoT Hub managed identity. |
| <a name="output_basic_iot_hub_hostname"></a> [basic\_iot\_hub\_hostname](#output\_basic\_iot\_hub\_hostname) | The hostname of the basic IoT Hub. |
| <a name="output_basic_iot_hub_id"></a> [basic\_iot\_hub\_id](#output\_basic\_iot\_hub\_id) | The ID of the basic IoT Hub. |
<!-- END_TF_DOCS -->