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
| <a name="module_private_dns_blob"></a> [private\_dns\_blob](#module\_private\_dns\_blob) | ../../ | n/a |
| <a name="module_private_dns_internal"></a> [private\_dns\_internal](#module\_private\_dns\_internal) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_virtual_network.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_blob_dns_zone_id"></a> [blob\_dns\_zone\_id](#output\_blob\_dns\_zone\_id) | n/a |
| <a name="output_internal_a_record_fqdns"></a> [internal\_a\_record\_fqdns](#output\_internal\_a\_record\_fqdns) | n/a |
| <a name="output_internal_dns_zone_id"></a> [internal\_dns\_zone\_id](#output\_internal\_dns\_zone\_id) | n/a |
<!-- END_TF_DOCS -->