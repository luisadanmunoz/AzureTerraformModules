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
| [azurerm_cognitive_account.cognitive_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cognitive_account_name"></a> [cognitive\_account\_name](#input\_cognitive\_account\_name) | value to set the cognitive account name | `string` | n/a | yes |
| <a name="input_custom_question_answering_search_service_id"></a> [custom\_question\_answering\_search\_service\_id](#input\_custom\_question\_answering\_search\_service\_id) | value to set the custom question answering search service id | `string` | `null` | no |
| <a name="input_custom_question_answering_search_service_key"></a> [custom\_question\_answering\_search\_service\_key](#input\_custom\_question\_answering\_search\_service\_key) | value to set the custom question answering search service key | `string` | `null` | no |
| <a name="input_custom_subdomain_name"></a> [custom\_subdomain\_name](#input\_custom\_subdomain\_name) | value to set the custom subdomain name | `string` | `null` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | value to set the customer managed key | <pre>object({<br/>    key_vault_key_id   = string<br/>    identity_client_id = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_dynamic_throttling_enabled"></a> [dynamic\_throttling\_enabled](#input\_dynamic\_throttling\_enabled) | value to set the dynamic throttling enabled flag | `bool` | `null` | no |
| <a name="input_fqdns"></a> [fqdns](#input\_fqdns) | value to set the fqdns | `list(string)` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | value to set the identity | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | value to set the kind | `string` | n/a | yes |
| <a name="input_local_auth_enabled"></a> [local\_auth\_enabled](#input\_local\_auth\_enabled) | value to set the local auth enabled flag | `bool` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_metrics_advisor_aad_client_id"></a> [metrics\_advisor\_aad\_client\_id](#input\_metrics\_advisor\_aad\_client\_id) | value to set the metrics advisor aad client id | `string` | `null` | no |
| <a name="input_metrics_advisor_aad_tenant_id"></a> [metrics\_advisor\_aad\_tenant\_id](#input\_metrics\_advisor\_aad\_tenant\_id) | value to set the metrics advisor aad tenant id | `string` | `null` | no |
| <a name="input_metrics_advisor_super_user_name"></a> [metrics\_advisor\_super\_user\_name](#input\_metrics\_advisor\_super\_user\_name) | value to set the metrics advisor super user name | `string` | `null` | no |
| <a name="input_metrics_advisor_website_name"></a> [metrics\_advisor\_website\_name](#input\_metrics\_advisor\_website\_name) | value to set the metrics advisor website name | `string` | `null` | no |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | value to set the network acls | <pre>object({<br/>    bypass         = optional(string)<br/>    default_action = string<br/>    ip_rules       = optional(list(string))<br/>    virtual_network_rules = optional(list(object({<br/>      subnet_id                            = string<br/>      ignore_missing_vnet_service_endpoint = optional(bool)<br/>    })))<br/>  })</pre> | `null` | no |
| <a name="input_network_injection"></a> [network\_injection](#input\_network\_injection) | value to set the network injection | <pre>object({<br/>    scenario  = string<br/>    subnet_id = string<br/>  })</pre> | `null` | no |
| <a name="input_outbound_network_access_restricted"></a> [outbound\_network\_access\_restricted](#input\_outbound\_network\_access\_restricted) | value to set the outbound network access restricted flag | `bool` | `null` | no |
| <a name="input_project_management_enabled"></a> [project\_management\_enabled](#input\_project\_management\_enabled) | value to set the project management enabled flag | `bool` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | value to set the public network access enabled flag | `bool` | `null` | no |
| <a name="input_qna_runtime_endpoint"></a> [qna\_runtime\_endpoint](#input\_qna\_runtime\_endpoint) | value to set the qna runtime endpoint | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | value to set the sku name | `string` | n/a | yes |
| <a name="input_storage"></a> [storage](#input\_storage) | value to set the storage | <pre>object({<br/>    storage_account_id = string<br/>    identity_client_id = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT COGNITIVE ACCOUNT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->