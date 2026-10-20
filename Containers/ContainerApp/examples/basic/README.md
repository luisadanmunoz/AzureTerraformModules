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
| <a name="module_api"></a> [api](#module\_api) | ../../ | n/a |
| <a name="module_webapp"></a> [webapp](#module\_webapp) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_container_app_environment.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment) | resource |
| [azurerm_log_analytics_workspace.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_api_principal_id"></a> [api\_principal\_id](#output\_api\_principal\_id) | n/a |
| <a name="output_api_url"></a> [api\_url](#output\_api\_url) | n/a |
| <a name="output_webapp_url"></a> [webapp\_url](#output\_webapp\_url) | n/a |
<!-- END_TF_DOCS -->