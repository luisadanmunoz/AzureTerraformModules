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
| <a name="module_ag_critical"></a> [ag\_critical](#module\_ag\_critical) | ../../ | n/a |
| <a name="module_ag_email"></a> [ag\_email](#module\_ag\_email) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_critical_ag_id"></a> [critical\_ag\_id](#output\_critical\_ag\_id) | The ID of the critical action group. |
| <a name="output_email_ag_id"></a> [email\_ag\_id](#output\_email\_ag\_id) | The ID of the email action group. |
<!-- END_TF_DOCS -->