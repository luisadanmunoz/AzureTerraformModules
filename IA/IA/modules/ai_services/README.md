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
| [azurerm_ai_services.ai_services](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ai_services) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_ai_services_name"></a> [ai\_services\_name](#input\_ai\_services\_name) | value to set the ai services name | `string` | n/a | yes |
| <a name="input_custom_subdomain_name"></a> [custom\_subdomain\_name](#input\_custom\_subdomain\_name) | value to set the custom subdomain name | `string` | `null` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | value to set the customer managed key | <pre>object({<br/>    identity_client_id = optional(string)<br/>    key_vault_key_id   = optional(string)<br/>    managed_hsm_key_id = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_fqdns"></a> [fqdns](#input\_fqdns) | value to set the fqdns | `list(string)` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | value to set the identity | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_local_authentication_enabled"></a> [local\_authentication\_enabled](#input\_local\_authentication\_enabled) | value to set the local authentication enabled flag | `bool` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | value to set the network acls | <pre>object({<br/>    bypass         = optional(string)<br/>    default_action = string<br/>    ip_rules       = optional(list(string))<br/>    virtual_network_rules = optional(list(object({<br/>      subnet_id                            = string<br/>      ignore_missing_vnet_service_endpoint = optional(bool)<br/>    })))<br/>  })</pre> | `null` | no |
| <a name="input_outbound_network_access_restricted"></a> [outbound\_network\_access\_restricted](#input\_outbound\_network\_access\_restricted) | value to set the outbound network access restricted flag | `bool` | `null` | no |
| <a name="input_public_network_access"></a> [public\_network\_access](#input\_public\_network\_access) | value to set the public network access | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | value to set the sku name | `string` | n/a | yes |
| <a name="input_storage"></a> [storage](#input\_storage) | value to set the storage | <pre>object({<br/>    storage_account_id = string<br/>    identity_client_id = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT AI SERVICES ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->