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
| <a name="module_webapp"></a> [webapp](#module\_webapp) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_service_plan.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_webapp_default_hostname"></a> [webapp\_default\_hostname](#output\_webapp\_default\_hostname) | The default hostname of the Web App |
| <a name="output_webapp_id"></a> [webapp\_id](#output\_webapp\_id) | The ID of the Web App |
| <a name="output_webapp_identity_principal_id"></a> [webapp\_identity\_principal\_id](#output\_webapp\_identity\_principal\_id) | The principal ID of the Web App's managed identity |
| <a name="output_webapp_name"></a> [webapp\_name](#output\_webapp\_name) | The name of the Web App |
<!-- END_TF_DOCS -->