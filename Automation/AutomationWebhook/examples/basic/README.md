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
| <a name="module_automation_webhooks"></a> [automation\_webhooks](#module\_automation\_webhooks) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_automation_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_account) | resource |
| [azurerm_automation_runbook.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_runbook) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_webhook_expiry_times"></a> [webhook\_expiry\_times](#output\_webhook\_expiry\_times) | n/a |
| <a name="output_webhook_ids"></a> [webhook\_ids](#output\_webhook\_ids) | n/a |
| <a name="output_webhook_uris"></a> [webhook\_uris](#output\_webhook\_uris) | n/a |
<!-- END_TF_DOCS -->