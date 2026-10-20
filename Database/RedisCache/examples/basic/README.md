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
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_enterprise_cache"></a> [enterprise\_cache](#module\_enterprise\_cache) | ../../ | n/a |
| <a name="module_session_cache"></a> [session\_cache](#module\_session\_cache) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.backup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_subnet.redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_enterprise_cache_connection_string"></a> [enterprise\_cache\_connection\_string](#output\_enterprise\_cache\_connection\_string) | n/a |
| <a name="output_enterprise_cache_hostname"></a> [enterprise\_cache\_hostname](#output\_enterprise\_cache\_hostname) | n/a |
| <a name="output_enterprise_cache_principal_id"></a> [enterprise\_cache\_principal\_id](#output\_enterprise\_cache\_principal\_id) | n/a |
| <a name="output_enterprise_cache_ssl_port"></a> [enterprise\_cache\_ssl\_port](#output\_enterprise\_cache\_ssl\_port) | n/a |
| <a name="output_session_cache_connection_string"></a> [session\_cache\_connection\_string](#output\_session\_cache\_connection\_string) | n/a |
| <a name="output_session_cache_hostname"></a> [session\_cache\_hostname](#output\_session\_cache\_hostname) | n/a |
| <a name="output_session_cache_ssl_port"></a> [session\_cache\_ssl\_port](#output\_session\_cache\_ssl\_port) | n/a |
<!-- END_TF_DOCS -->