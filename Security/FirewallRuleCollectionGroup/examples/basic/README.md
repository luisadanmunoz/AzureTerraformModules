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
| <a name="module_rcg_application"></a> [rcg\_application](#module\_rcg\_application) | ../../ | n/a |
| <a name="module_rcg_nat"></a> [rcg\_nat](#module\_rcg\_nat) | ../../ | n/a |
| <a name="module_rcg_network"></a> [rcg\_network](#module\_rcg\_network) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_firewall.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) | resource |
| [azurerm_firewall_policy.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy) | resource |
| [azurerm_public_ip.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_application_rule_collection_group_id"></a> [application\_rule\_collection\_group\_id](#output\_application\_rule\_collection\_group\_id) | n/a |
| <a name="output_nat_rule_collection_group_id"></a> [nat\_rule\_collection\_group\_id](#output\_nat\_rule\_collection\_group\_id) | n/a |
| <a name="output_network_rule_collection_group_id"></a> [network\_rule\_collection\_group\_id](#output\_network\_rule\_collection\_group\_id) | n/a |
<!-- END_TF_DOCS -->