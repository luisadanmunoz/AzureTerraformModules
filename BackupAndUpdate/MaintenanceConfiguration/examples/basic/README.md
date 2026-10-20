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
| <a name="module_host_maintenance"></a> [host\_maintenance](#module\_host\_maintenance) | ../../ | n/a |
| <a name="module_patch_config_monthly"></a> [patch\_config\_monthly](#module\_patch\_config\_monthly) | ../../ | n/a |
| <a name="module_patch_config_weekly"></a> [patch\_config\_weekly](#module\_patch\_config\_weekly) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_host_maintenance_id"></a> [host\_maintenance\_id](#output\_host\_maintenance\_id) | Host maintenance configuration ID |
| <a name="output_monthly_patch_config_id"></a> [monthly\_patch\_config\_id](#output\_monthly\_patch\_config\_id) | Monthly patch configuration ID |
| <a name="output_weekly_patch_config_id"></a> [weekly\_patch\_config\_id](#output\_weekly\_patch\_config\_id) | Weekly patch configuration ID |
<!-- END_TF_DOCS -->