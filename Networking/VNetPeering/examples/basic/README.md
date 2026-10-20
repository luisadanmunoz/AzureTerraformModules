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
| <a name="module_hub_to_spoke_peering"></a> [hub\_to\_spoke\_peering](#module\_hub\_to\_spoke\_peering) | ../../ | n/a |
| <a name="module_spoke_to_hub_peering"></a> [spoke\_to\_hub\_peering](#module\_spoke\_to\_hub\_peering) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.spoke](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_virtual_network.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network.spoke](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_hub_to_spoke_peering_id"></a> [hub\_to\_spoke\_peering\_id](#output\_hub\_to\_spoke\_peering\_id) | n/a |
| <a name="output_spoke_to_hub_peering_id"></a> [spoke\_to\_hub\_peering\_id](#output\_spoke\_to\_hub\_peering\_id) | n/a |
<!-- END_TF_DOCS -->