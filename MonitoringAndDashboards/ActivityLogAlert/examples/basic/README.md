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
| <a name="module_alert_resource_delete"></a> [alert\_resource\_delete](#module\_alert\_resource\_delete) | ../../ | n/a |
| <a name="module_alert_service_health"></a> [alert\_service\_health](#module\_alert\_service\_health) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_resource_delete_alert_id"></a> [resource\_delete\_alert\_id](#output\_resource\_delete\_alert\_id) | The ID of the resource deletion alert. |
| <a name="output_service_health_alert_id"></a> [service\_health\_alert\_id](#output\_service\_health\_alert\_id) | The ID of the service health alert. |
<!-- END_TF_DOCS -->