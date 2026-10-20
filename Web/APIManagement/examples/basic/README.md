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
| <a name="module_apim_consumption"></a> [apim\_consumption](#module\_apim\_consumption) | ../../ | n/a |
| <a name="module_apim_developer"></a> [apim\_developer](#module\_apim\_developer) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_consumption_apim_id"></a> [consumption\_apim\_id](#output\_consumption\_apim\_id) | The ID of the consumption APIM. |
| <a name="output_developer_apim_gateway_url"></a> [developer\_apim\_gateway\_url](#output\_developer\_apim\_gateway\_url) | The gateway URL of the developer APIM. |
| <a name="output_developer_apim_portal_url"></a> [developer\_apim\_portal\_url](#output\_developer\_apim\_portal\_url) | The developer portal URL. |
<!-- END_TF_DOCS -->