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
| <a name="module_hc_api"></a> [hc\_api](#module\_hc\_api) | ../../ | n/a |
| <a name="module_hc_database"></a> [hc\_database](#module\_hc\_database) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_relay_namespace.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/relay_namespace) | resource |
| [azurerm_resource_group.relay](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_api_hc_id"></a> [api\_hc\_id](#output\_api\_hc\_id) | n/a |
| <a name="output_database_hc_id"></a> [database\_hc\_id](#output\_database\_hc\_id) | n/a |
<!-- END_TF_DOCS -->