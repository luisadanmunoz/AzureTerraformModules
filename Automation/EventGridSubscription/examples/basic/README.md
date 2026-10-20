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
| <a name="module_disabled_subscription"></a> [disabled\_subscription](#module\_disabled\_subscription) | ../../ | n/a |
| <a name="module_filtered_subscription"></a> [filtered\_subscription](#module\_filtered\_subscription) | ../../ | n/a |
| <a name="module_webhook_subscription"></a> [webhook\_subscription](#module\_webhook\_subscription) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_disabled_subscription_id"></a> [disabled\_subscription\_id](#output\_disabled\_subscription\_id) | The ID of the disabled subscription (should be null) |
| <a name="output_filtered_subscription_id"></a> [filtered\_subscription\_id](#output\_filtered\_subscription\_id) | The ID of the filtered subscription |
| <a name="output_webhook_subscription_id"></a> [webhook\_subscription\_id](#output\_webhook\_subscription\_id) | The ID of the webhook subscription |
| <a name="output_webhook_subscription_name"></a> [webhook\_subscription\_name](#output\_webhook\_subscription\_name) | The name of the webhook subscription |
<!-- END_TF_DOCS -->