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
| <a name="module_sap_device"></a> [sap\_device](#module\_sap\_device) | ../../ | n/a |
| <a name="module_sap_registry_manager"></a> [sap\_registry\_manager](#module\_sap\_registry\_manager) | ../../ | n/a |
| <a name="module_sap_service"></a> [sap\_service](#module\_sap\_service) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_device_policy_id"></a> [device\_policy\_id](#output\_device\_policy\_id) | The ID of the device policy. |
| <a name="output_registry_manager_policy_id"></a> [registry\_manager\_policy\_id](#output\_registry\_manager\_policy\_id) | The ID of the registry manager policy. |
| <a name="output_service_policy_connection_string"></a> [service\_policy\_connection\_string](#output\_service\_policy\_connection\_string) | The connection string for the service policy. |
| <a name="output_service_policy_id"></a> [service\_policy\_id](#output\_service\_policy\_id) | The ID of the service policy. |
<!-- END_TF_DOCS -->