<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_public_ip.public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allocation_method"></a> [allocation\_method](#input\_allocation\_method) | value to set the allocation method | `string` | n/a | yes |
| <a name="input_domain_name_label"></a> [domain\_name\_label](#input\_domain\_name\_label) | value to set the domain name label | `string` | `null` | no |
| <a name="input_idle_timeout_in_minutes"></a> [idle\_timeout\_in\_minutes](#input\_idle\_timeout\_in\_minutes) | value to set the idle timeout | `number` | `4` | no |
| <a name="input_ip_version"></a> [ip\_version](#input\_ip\_version) | value to set the ip version | `string` | `"IPv4"` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_public_ip_name"></a> [public\_ip\_name](#input\_public\_ip\_name) | value to set the public ip name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_reverse_fqdn"></a> [reverse\_fqdn](#input\_reverse\_fqdn) | value to set the reverse fqdn | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | value to set the sku | `string` | `"Standard"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | value to set the sku tier | `string` | `"Regional"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | value to set the zones | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT PUBLIC IP ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->