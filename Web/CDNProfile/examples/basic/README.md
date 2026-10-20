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
| <a name="module_cdn_microsoft"></a> [cdn\_microsoft](#module\_cdn\_microsoft) | ../../ | n/a |
| <a name="module_cdn_verizon"></a> [cdn\_verizon](#module\_cdn\_verizon) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_microsoft_cdn_id"></a> [microsoft\_cdn\_id](#output\_microsoft\_cdn\_id) | The ID of the Microsoft CDN profile. |
| <a name="output_verizon_cdn_id"></a> [verizon\_cdn\_id](#output\_verizon\_cdn\_id) | The ID of the Verizon CDN profile. |
<!-- END_TF_DOCS -->