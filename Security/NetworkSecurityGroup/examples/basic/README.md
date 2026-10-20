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
| <a name="module_nsg_backend"></a> [nsg\_backend](#module\_nsg\_backend) | ../../ | n/a |
| <a name="module_nsg_web"></a> [nsg\_web](#module\_nsg\_web) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_nsg_backend_id"></a> [nsg\_backend\_id](#output\_nsg\_backend\_id) | ID of the backend NSG |
| <a name="output_nsg_web_id"></a> [nsg\_web\_id](#output\_nsg\_web\_id) | ID of the web NSG |
| <a name="output_nsg_web_rules"></a> [nsg\_web\_rules](#output\_nsg\_web\_rules) | Security rules in the web NSG |
<!-- END_TF_DOCS -->