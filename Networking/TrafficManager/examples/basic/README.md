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
| <a name="module_traffic_manager"></a> [traffic\_manager](#module\_traffic\_manager) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_public_ip.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_tm_fqdn"></a> [tm\_fqdn](#output\_tm\_fqdn) | n/a |
| <a name="output_tm_id"></a> [tm\_id](#output\_tm\_id) | n/a |
<!-- END_TF_DOCS -->