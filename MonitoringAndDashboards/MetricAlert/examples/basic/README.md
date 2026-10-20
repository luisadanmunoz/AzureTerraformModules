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
| <a name="module_action_group"></a> [action\_group](#module\_action\_group) | ../../../ActionGroup | n/a |
| <a name="module_alert_storage_availability"></a> [alert\_storage\_availability](#module\_alert\_storage\_availability) | ../../ | n/a |
| <a name="module_alert_storage_latency"></a> [alert\_storage\_latency](#module\_alert\_storage\_latency) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_availability_alert_id"></a> [availability\_alert\_id](#output\_availability\_alert\_id) | The ID of the availability alert. |
| <a name="output_latency_alert_id"></a> [latency\_alert\_id](#output\_latency\_alert\_id) | The ID of the latency alert. |
<!-- END_TF_DOCS -->