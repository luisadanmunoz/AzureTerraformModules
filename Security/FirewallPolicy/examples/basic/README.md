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
| <a name="module_firewall_policy"></a> [firewall\_policy](#module\_firewall\_policy) | ../../ | n/a |
| <a name="module_firewall_policy_spoke"></a> [firewall\_policy\_spoke](#module\_firewall\_policy\_spoke) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_log_analytics_workspace.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_hub_policy_id"></a> [hub\_policy\_id](#output\_hub\_policy\_id) | n/a |
| <a name="output_hub_policy_name"></a> [hub\_policy\_name](#output\_hub\_policy\_name) | n/a |
| <a name="output_spoke_policy_id"></a> [spoke\_policy\_id](#output\_spoke\_policy\_id) | n/a |
| <a name="output_spoke_policy_name"></a> [spoke\_policy\_name](#output\_spoke\_policy\_name) | n/a |
<!-- END_TF_DOCS -->