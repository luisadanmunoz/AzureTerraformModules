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
| <a name="module_iot_hub_endpoint_storage"></a> [iot\_hub\_endpoint\_storage](#module\_iot\_hub\_endpoint\_storage) | ../../ | n/a |

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
| <a name="output_storage_endpoint_id"></a> [storage\_endpoint\_id](#output\_storage\_endpoint\_id) | The ID of the storage endpoint. |
| <a name="output_storage_endpoint_name"></a> [storage\_endpoint\_name](#output\_storage\_endpoint\_name) | The name of the storage endpoint. |
<!-- END_TF_DOCS -->