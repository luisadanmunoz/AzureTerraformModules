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
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | value to set the access tier | `string` | `null` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | value to set the account kind | `string` | `null` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | value to set the account replication type | `string` | n/a | yes |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | value to set the account tier | `string` | n/a | yes |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | value to set the allow nested items to be public | `bool` | `null` | no |
| <a name="input_blob_properties"></a> [blob\_properties](#input\_blob\_properties) | value to set the blob properties | <pre>object({<br/>    change_feed_enabled           = optional(bool)<br/>    change_feed_retention_in_days = optional(number)<br/>    last_access_time_enabled      = optional(bool)<br/>    versioning_enabled            = optional(bool)<br/>    container_delete_retention_policy = optional(object({<br/>      days = optional(number)<br/>    }))<br/>    delete_retention_policy = optional(object({<br/>      days                     = optional(number)<br/>      permanent_delete_enabled = optional(bool)<br/>    }))<br/>    restore_policy = optional(object({<br/>      days = number<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_cross_tenant_replication_enabled"></a> [cross\_tenant\_replication\_enabled](#input\_cross\_tenant\_replication\_enabled) | value to set the cross tenant replication enabled | `bool` | `null` | no |
| <a name="input_custom_domain"></a> [custom\_domain](#input\_custom\_domain) | value to set the custom domain | <pre>object({<br/>    name          = string<br/>    use_subdomain = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_default_to_oauth_authentication"></a> [default\_to\_oauth\_authentication](#input\_default\_to\_oauth\_authentication) | value to set the default to oauth authentication | `bool` | `null` | no |
| <a name="input_https_traffic_only_enabled"></a> [https\_traffic\_only\_enabled](#input\_https\_traffic\_only\_enabled) | value to set the https traffic only enabled | `bool` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | value to set the identity | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_infrastructure_encryption_enabled"></a> [infrastructure\_encryption\_enabled](#input\_infrastructure\_encryption\_enabled) | value to set the infrastructure encryption enabled | `bool` | `null` | no |
| <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled) | value to set the is hns enabled | `bool` | `null` | no |
| <a name="input_large_file_share_enabled"></a> [large\_file\_share\_enabled](#input\_large\_file\_share\_enabled) | value to set the large file share enabled | `bool` | `null` | no |
| <a name="input_local_user_enabled"></a> [local\_user\_enabled](#input\_local\_user\_enabled) | value to set the local user enabled | `bool` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | value to set the min tls version | `string` | `null` | no |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | value to set the network rules | <pre>object({<br/>    default_action             = string<br/>    bypass                     = optional(list(string))<br/>    ip_rules                   = optional(list(string))<br/>    virtual_network_subnet_ids = optional(list(string))<br/>    private_link_access = optional(list(object({<br/>      endpoint_resource_id = string<br/>      endpoint_tenant_id   = optional(string)<br/>    })))<br/>  })</pre> | `null` | no |
| <a name="input_nfsv3_enabled"></a> [nfsv3\_enabled](#input\_nfsv3\_enabled) | value to set the nfsv3 enabled | `bool` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | value to set the public network access enabled | `bool` | `null` | no |
| <a name="input_queue_properties"></a> [queue\_properties](#input\_queue\_properties) | value to set the queue properties | <pre>object({<br/>    cors_rules = optional(list(object({<br/>      allowed_headers    = list(string)<br/>      allowed_methods    = list(string)<br/>      allowed_origins    = list(string)<br/>      exposed_headers    = list(string)<br/>      max_age_in_seconds = number<br/>    })))<br/>    logging = optional(object({<br/>      delete                = bool<br/>      read                  = bool<br/>      retention_policy_days = optional(number)<br/>      version               = string<br/>      write                 = bool<br/>    }))<br/>    hour_metrics = optional(object({<br/>      enabled               = bool<br/>      include_apis          = optional(bool)<br/>      retention_policy_days = optional(number)<br/>      version               = string<br/>    }))<br/>    minute_metrics = optional(object({<br/>      enabled               = bool<br/>      include_apis          = optional(bool)<br/>      retention_policy_days = optional(number)<br/>      version               = string<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_routing"></a> [routing](#input\_routing) | value to set the routing | <pre>object({<br/>    choice                      = optional(string)<br/>    publish_internet_endpoints  = optional(bool)<br/>    publish_microsoft_endpoints = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_sas_policy"></a> [sas\_policy](#input\_sas\_policy) | value to set the sas policy | <pre>object({<br/>    expiration_period = string<br/>    expiration_action = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_sftp_enabled"></a> [sftp\_enabled](#input\_sftp\_enabled) | value to set the sftp enabled | `bool` | `null` | no |
| <a name="input_share_properties"></a> [share\_properties](#input\_share\_properties) | value to set the share properties | <pre>object({<br/>    cors_rules = optional(list(object({<br/>      allowed_headers    = list(string)<br/>      allowed_methods    = list(string)<br/>      allowed_origins    = list(string)<br/>      exposed_headers    = list(string)<br/>      max_age_in_seconds = number<br/>    })))<br/>    retention_policy = optional(object({<br/>      days = optional(number)<br/>    }))<br/>    smb = optional(object({<br/>      authentication_types            = optional(list(string))<br/>      channel_encryption_type         = optional(list(string))<br/>      kerberos_ticket_encryption_type = optional(list(string))<br/>      multichannel_enabled            = optional(bool)<br/>      versions                        = optional(list(string))<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | value to set the shared access key enabled | `bool` | `null` | no |
| <a name="input_static_website"></a> [static\_website](#input\_static\_website) | value to set the static website | <pre>object({<br/>    index_document     = optional(string)<br/>    error_404_document = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | value to set the storage account name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT STORAGE ACCOUNT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | n/a |
| <a name="output_primary_dfs_endpoint"></a> [primary\_dfs\_endpoint](#output\_primary\_dfs\_endpoint) | n/a |
| <a name="output_primary_file_endpoint"></a> [primary\_file\_endpoint](#output\_primary\_file\_endpoint) | n/a |
<!-- END_TF_DOCS -->