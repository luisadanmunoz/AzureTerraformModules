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
| <a name="module_production_budget"></a> [production\_budget](#module\_production\_budget) | ../../ | n/a |
| <a name="module_project_budget"></a> [project\_budget](#module\_project\_budget) | ../../ | n/a |
| <a name="module_subscription_budget"></a> [subscription\_budget](#module\_subscription\_budget) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_production_budget_id"></a> [production\_budget\_id](#output\_production\_budget\_id) | n/a |
| <a name="output_project_budget_id"></a> [project\_budget\_id](#output\_project\_budget\_id) | n/a |
| <a name="output_subscription_budget_id"></a> [subscription\_budget\_id](#output\_subscription\_budget\_id) | n/a |
<!-- END_TF_DOCS -->