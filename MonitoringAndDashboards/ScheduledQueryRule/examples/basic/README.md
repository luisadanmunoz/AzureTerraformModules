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
| <a name="module_alert_error_count"></a> [alert\_error\_count](#module\_alert\_error\_count) | ../../ | n/a |
| <a name="module_alert_heartbeat"></a> [alert\_heartbeat](#module\_alert\_heartbeat) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_log_analytics_workspace.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_error_alert_id"></a> [error\_alert\_id](#output\_error\_alert\_id) | The ID of the error count alert. |
| <a name="output_heartbeat_alert_id"></a> [heartbeat\_alert\_id](#output\_heartbeat\_alert\_id) | The ID of the heartbeat alert. |
<!-- END_TF_DOCS -->