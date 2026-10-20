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
| <a name="module_scaling_plan"></a> [scaling\_plan](#module\_scaling\_plan) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_virtual_desktop_host_pool.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_scaling_plan_id"></a> [scaling\_plan\_id](#output\_scaling\_plan\_id) | The ID of the Scaling Plan |
| <a name="output_scaling_plan_name"></a> [scaling\_plan\_name](#output\_scaling\_plan\_name) | The name of the Scaling Plan |
| <a name="output_schedule_names"></a> [schedule\_names](#output\_schedule\_names) | The schedule names |
<!-- END_TF_DOCS -->