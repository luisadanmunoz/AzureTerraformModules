<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_policy_daily"></a> [policy\_daily](#module\_policy\_daily) | ../../ | n/a |
| <a name="module_policy_hourly"></a> [policy\_hourly](#module\_policy\_hourly) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_recovery_services_vault.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_daily_policy_id"></a> [daily\_policy\_id](#output\_daily\_policy\_id) | Daily policy ID |
| <a name="output_hourly_policy_id"></a> [hourly\_policy\_id](#output\_hourly\_policy\_id) | Hourly policy ID |
<!-- END_TF_DOCS -->