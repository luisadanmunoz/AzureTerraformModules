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
| <a name="module_iot_hub"></a> [iot\_hub](#module\_iot\_hub) | ../../../IoTHub | n/a |
| <a name="module_iot_hub_dps_basic"></a> [iot\_hub\_dps\_basic](#module\_iot\_hub\_dps\_basic) | ../../ | n/a |
| <a name="module_iot_hub_dps_linked"></a> [iot\_hub\_dps\_linked](#module\_iot\_hub\_dps\_linked) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_basic_dps_id"></a> [basic\_dps\_id](#output\_basic\_dps\_id) | The ID of the basic DPS. |
| <a name="output_basic_dps_id_scope"></a> [basic\_dps\_id\_scope](#output\_basic\_dps\_id\_scope) | The ID scope of the basic DPS. |
| <a name="output_linked_dps_device_provisioning_host_name"></a> [linked\_dps\_device\_provisioning\_host\_name](#output\_linked\_dps\_device\_provisioning\_host\_name) | The device provisioning host name of the linked DPS. |
<!-- END_TF_DOCS -->