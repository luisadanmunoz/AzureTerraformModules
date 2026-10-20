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
| <a name="module_api"></a> [api](#module\_api) | ../../ | n/a |
| <a name="module_nginx"></a> [nginx](#module\_nginx) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_api_fqdn"></a> [api\_fqdn](#output\_api\_fqdn) | n/a |
| <a name="output_nginx_fqdn"></a> [nginx\_fqdn](#output\_nginx\_fqdn) | n/a |
| <a name="output_nginx_ip"></a> [nginx\_ip](#output\_nginx\_ip) | n/a |
<!-- END_TF_DOCS -->