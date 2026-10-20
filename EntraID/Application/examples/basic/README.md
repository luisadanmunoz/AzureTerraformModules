<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.45.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.45.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_app_api"></a> [app\_api](#module\_app\_api) | ../../ | n/a |
| <a name="module_app_client"></a> [app\_client](#module\_app\_client) | ../../ | n/a |
| <a name="module_app_spa"></a> [app\_spa](#module\_app\_spa) | ../../ | n/a |
| <a name="module_app_web"></a> [app\_web](#module\_app\_web) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_api_app_role_ids"></a> [api\_app\_role\_ids](#output\_api\_app\_role\_ids) | App role IDs for the API |
| <a name="output_api_client_id"></a> [api\_client\_id](#output\_api\_client\_id) | Client ID of the API |
| <a name="output_api_scope_ids"></a> [api\_scope\_ids](#output\_api\_scope\_ids) | OAuth2 scope IDs for the API |
| <a name="output_client_app_client_id"></a> [client\_app\_client\_id](#output\_client\_app\_client\_id) | Client ID of the client application |
| <a name="output_spa_client_id"></a> [spa\_client\_id](#output\_spa\_client\_id) | Client ID of the SPA |
| <a name="output_web_app_client_id"></a> [web\_app\_client\_id](#output\_web\_app\_client\_id) | Client ID of the web application |
<!-- END_TF_DOCS -->