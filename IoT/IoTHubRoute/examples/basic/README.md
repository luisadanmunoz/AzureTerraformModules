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
| <a name="module_iot_hub_endpoint"></a> [iot\_hub\_endpoint](#module\_iot\_hub\_endpoint) | ../../../IoTHubEndpoint | n/a |
| <a name="module_iot_hub_route_critical"></a> [iot\_hub\_route\_critical](#module\_iot\_hub\_route\_critical) | ../../ | n/a |
| <a name="module_iot_hub_route_telemetry"></a> [iot\_hub\_route\_telemetry](#module\_iot\_hub\_route\_telemetry) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_critical_route_id"></a> [critical\_route\_id](#output\_critical\_route\_id) | The ID of the critical alerts route. |
| <a name="output_telemetry_route_id"></a> [telemetry\_route\_id](#output\_telemetry\_route\_id) | The ID of the telemetry route. |
<!-- END_TF_DOCS -->