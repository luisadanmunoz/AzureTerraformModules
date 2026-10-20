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
| <a name="module_digital_twins_basic"></a> [digital\_twins\_basic](#module\_digital\_twins\_basic) | ../../ | n/a |
| <a name="module_digital_twins_with_identity"></a> [digital\_twins\_with\_identity](#module\_digital\_twins\_with\_identity) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_basic_digital_twins_host_name"></a> [basic\_digital\_twins\_host\_name](#output\_basic\_digital\_twins\_host\_name) | The hostname of the basic Digital Twins instance. |
| <a name="output_basic_digital_twins_id"></a> [basic\_digital\_twins\_id](#output\_basic\_digital\_twins\_id) | The ID of the basic Digital Twins instance. |
| <a name="output_identity_digital_twins_id"></a> [identity\_digital\_twins\_id](#output\_identity\_digital\_twins\_id) | The ID of the Digital Twins instance with identity. |
| <a name="output_identity_digital_twins_principal_id"></a> [identity\_digital\_twins\_principal\_id](#output\_identity\_digital\_twins\_principal\_id) | The principal ID of the Digital Twins managed identity. |
<!-- END_TF_DOCS -->