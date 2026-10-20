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
| <a name="module_front_door_premium"></a> [front\_door\_premium](#module\_front\_door\_premium) | ../../ | n/a |
| <a name="module_front_door_standard"></a> [front\_door\_standard](#module\_front\_door\_standard) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_premium_front_door_id"></a> [premium\_front\_door\_id](#output\_premium\_front\_door\_id) | The ID of the premium Front Door. |
| <a name="output_standard_front_door_id"></a> [standard\_front\_door\_id](#output\_standard\_front\_door\_id) | The ID of the standard Front Door. |
<!-- END_TF_DOCS -->