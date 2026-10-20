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
| <a name="module_environment_basic"></a> [environment\_basic](#module\_environment\_basic) | ../../ | n/a |
| <a name="module_environment_dedicated"></a> [environment\_dedicated](#module\_environment\_dedicated) | ../../ | n/a |
| <a name="module_environment_vnet"></a> [environment\_vnet](#module\_environment\_vnet) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_log_analytics_workspace.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.container_apps](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_basic_default_domain"></a> [basic\_default\_domain](#output\_basic\_default\_domain) | n/a |
| <a name="output_basic_environment_id"></a> [basic\_environment\_id](#output\_basic\_environment\_id) | n/a |
| <a name="output_dedicated_environment_id"></a> [dedicated\_environment\_id](#output\_dedicated\_environment\_id) | n/a |
| <a name="output_vnet_environment_id"></a> [vnet\_environment\_id](#output\_vnet\_environment\_id) | n/a |
| <a name="output_vnet_static_ip"></a> [vnet\_static\_ip](#output\_vnet\_static\_ip) | n/a |
<!-- END_TF_DOCS -->