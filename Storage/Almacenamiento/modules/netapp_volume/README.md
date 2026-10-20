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
| [azurerm_netapp_volume.netapp_volume](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_volume) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_accept_grow_capacity_pool_for_short_term_clone_split"></a> [accept\_grow\_capacity\_pool\_for\_short\_term\_clone\_split](#input\_accept\_grow\_capacity\_pool\_for\_short\_term\_clone\_split) | value to set the accept grow capacity pool for short term clone split | `string` | `null` | no |
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | value to set the account name | `string` | n/a | yes |
| <a name="input_azure_vmware_data_store_enabled"></a> [azure\_vmware\_data\_store\_enabled](#input\_azure\_vmware\_data\_store\_enabled) | value to set the azure vmware data store enabled | `bool` | `null` | no |
| <a name="input_cool_access"></a> [cool\_access](#input\_cool\_access) | value to set the cool access | <pre>object({<br/>    coolness_period_in_days = number<br/>    retrieval_policy        = string<br/>    tiering_policy          = string<br/>  })</pre> | `null` | no |
| <a name="input_create_from_snapshot_resource_id"></a> [create\_from\_snapshot\_resource\_id](#input\_create\_from\_snapshot\_resource\_id) | value to set the create from snapshot resource id | `string` | `null` | no |
| <a name="input_data_protection_advanced_ransomware"></a> [data\_protection\_advanced\_ransomware](#input\_data\_protection\_advanced\_ransomware) | value to set the data protection advanced ransomware | <pre>object({<br/>    protection_enabled = bool<br/>  })</pre> | `null` | no |
| <a name="input_data_protection_backup_policy"></a> [data\_protection\_backup\_policy](#input\_data\_protection\_backup\_policy) | value to set the data protection backup policy | <pre>object({<br/>    backup_policy_id = string<br/>    backup_vault_id  = string<br/>    policy_enabled   = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_data_protection_replication"></a> [data\_protection\_replication](#input\_data\_protection\_replication) | value to set the data protection replication | <pre>object({<br/>    remote_volume_location    = string<br/>    remote_volume_resource_id = string<br/>    replication_frequency     = string<br/>    endpoint_type             = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_export_policy_rules"></a> [export\_policy\_rules](#input\_export\_policy\_rules) | value to set the export policy rules | <pre>list(object({<br/>    allowed_clients                = list(string)<br/>    rule_index                     = number<br/>    kerberos_5_read_only_enabled   = optional(bool)<br/>    kerberos_5_read_write_enabled  = optional(bool)<br/>    kerberos_5i_read_only_enabled  = optional(bool)<br/>    kerberos_5i_read_write_enabled = optional(bool)<br/>    kerberos_5p_read_only_enabled  = optional(bool)<br/>    kerberos_5p_read_write_enabled = optional(bool)<br/>    protocol                       = optional(list(string))<br/>    protocols_enabled              = optional(list(string))<br/>    root_access_enabled            = optional(bool)<br/>    unix_read_only                 = optional(bool)<br/>    unix_read_write                = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_kerberos_enabled"></a> [kerberos\_enabled](#input\_kerberos\_enabled) | value to set the kerberos enabled | `bool` | `null` | no |
| <a name="input_large_volume_enabled"></a> [large\_volume\_enabled](#input\_large\_volume\_enabled) | value to set the large volume enabled | `bool` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_netapp_volume_name"></a> [netapp\_volume\_name](#input\_netapp\_volume\_name) | value to set the netapp volume name | `string` | n/a | yes |
| <a name="input_network_features"></a> [network\_features](#input\_network\_features) | value to set the network features | `string` | `null` | no |
| <a name="input_pool_name"></a> [pool\_name](#input\_pool\_name) | value to set the pool name | `string` | n/a | yes |
| <a name="input_protocols"></a> [protocols](#input\_protocols) | value to set the protocols | `list(string)` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_security_style"></a> [security\_style](#input\_security\_style) | value to set the security style | `string` | `null` | no |
| <a name="input_service_level"></a> [service\_level](#input\_service\_level) | value to set the service level | `string` | n/a | yes |
| <a name="input_smb3_protocol_encryption_enabled"></a> [smb3\_protocol\_encryption\_enabled](#input\_smb3\_protocol\_encryption\_enabled) | value to set the smb3 protocol encryption enabled | `bool` | `null` | no |
| <a name="input_smb_access_based_enumeration_enabled"></a> [smb\_access\_based\_enumeration\_enabled](#input\_smb\_access\_based\_enumeration\_enabled) | value to set the smb access based enumeration enabled | `bool` | `null` | no |
| <a name="input_smb_continuous_availability_enabled"></a> [smb\_continuous\_availability\_enabled](#input\_smb\_continuous\_availability\_enabled) | value to set the smb continuous availability enabled | `bool` | `null` | no |
| <a name="input_smb_non_browsable_enabled"></a> [smb\_non\_browsable\_enabled](#input\_smb\_non\_browsable\_enabled) | value to set the smb non browsable enabled | `bool` | `null` | no |
| <a name="input_snapshot_directory_visible"></a> [snapshot\_directory\_visible](#input\_snapshot\_directory\_visible) | value to set the snapshot directory visible | `bool` | `null` | no |
| <a name="input_snapshot_policy_id"></a> [snapshot\_policy\_id](#input\_snapshot\_policy\_id) | value to set the snapshot policy id | `string` | `null` | no |
| <a name="input_storage_quota_in_gb"></a> [storage\_quota\_in\_gb](#input\_storage\_quota\_in\_gb) | value to set the storage quota in gb | `number` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | value to set the subnet id | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_throughput_in_mibps"></a> [throughput\_in\_mibps](#input\_throughput\_in\_mibps) | value to set the throughput in mibps | `number` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_volume_path"></a> [volume\_path](#input\_volume\_path) | value to set the volume path | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | value to set the zone | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT NETAPP VOLUME ############################################################################ |
| <a name="output_mount_ip_addresses"></a> [mount\_ip\_addresses](#output\_mount\_ip\_addresses) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->