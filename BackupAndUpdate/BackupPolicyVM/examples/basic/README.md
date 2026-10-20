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
| <a name="module_policy_critical"></a> [policy\_critical](#module\_policy\_critical) | ../../ | n/a |
| <a name="module_policy_longterm"></a> [policy\_longterm](#module\_policy\_longterm) | ../../ | n/a |
| <a name="module_policy_standard"></a> [policy\_standard](#module\_policy\_standard) | ../../ | n/a |

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
| <a name="output_critical_policy_id"></a> [critical\_policy\_id](#output\_critical\_policy\_id) | Critical (hourly) policy ID |
| <a name="output_longterm_policy_id"></a> [longterm\_policy\_id](#output\_longterm\_policy\_id) | Long-term policy ID |
| <a name="output_standard_policy_id"></a> [standard\_policy\_id](#output\_standard\_policy\_id) | Standard policy ID |
<!-- END_TF_DOCS -->