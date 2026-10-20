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
| [azurerm_managed_disk.managed_disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create_option"></a> [create\_option](#input\_create\_option) | value to set the create option | `string` | n/a | yes |
| <a name="input_disk_access_id"></a> [disk\_access\_id](#input\_disk\_access\_id) | value to set the disk access id | `string` | `null` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | value to set the disk encryption set id | `string` | `null` | no |
| <a name="input_disk_iops_read_only"></a> [disk\_iops\_read\_only](#input\_disk\_iops\_read\_only) | value to set the disk iops read only | `number` | `null` | no |
| <a name="input_disk_iops_read_write"></a> [disk\_iops\_read\_write](#input\_disk\_iops\_read\_write) | value to set the disk iops read write | `number` | `null` | no |
| <a name="input_disk_mbps_read_only"></a> [disk\_mbps\_read\_only](#input\_disk\_mbps\_read\_only) | value to set the disk mbps read only | `number` | `null` | no |
| <a name="input_disk_mbps_read_write"></a> [disk\_mbps\_read\_write](#input\_disk\_mbps\_read\_write) | value to set the disk mbps read write | `number` | `null` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | value to set the disk size gb | `number` | `null` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | value to set the edge zone | `string` | `null` | no |
| <a name="input_encryption_settings"></a> [encryption\_settings](#input\_encryption\_settings) | value to set the encryption settings | <pre>object({<br/>    disk_encryption_key = object({<br/>      secret_url      = string<br/>      source_vault_id = string<br/>    })<br/>    key_encryption_key = optional(object({<br/>      key_url         = string<br/>      source_vault_id = string<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_gallery_image_reference_id"></a> [gallery\_image\_reference\_id](#input\_gallery\_image\_reference\_id) | value to set the gallery image reference id | `string` | `null` | no |
| <a name="input_hyper_v_generation"></a> [hyper\_v\_generation](#input\_hyper\_v\_generation) | value to set the hyper v generation | `string` | `null` | no |
| <a name="input_image_reference_id"></a> [image\_reference\_id](#input\_image\_reference\_id) | value to set the image reference id | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_logical_sector_size"></a> [logical\_sector\_size](#input\_logical\_sector\_size) | value to set the logical sector size | `number` | `null` | no |
| <a name="input_managed_disk_name"></a> [managed\_disk\_name](#input\_managed\_disk\_name) | value to set the managed disk name | `string` | n/a | yes |
| <a name="input_max_shares"></a> [max\_shares](#input\_max\_shares) | value to set the max shares | `number` | `null` | no |
| <a name="input_network_access_policy"></a> [network\_access\_policy](#input\_network\_access\_policy) | value to set the network access policy | `string` | `null` | no |
| <a name="input_on_demand_bursting_enabled"></a> [on\_demand\_bursting\_enabled](#input\_on\_demand\_bursting\_enabled) | value to set the on demand bursting enabled | `bool` | `null` | no |
| <a name="input_optimized_frequent_attach_enabled"></a> [optimized\_frequent\_attach\_enabled](#input\_optimized\_frequent\_attach\_enabled) | value to set the optimized frequent attach enabled | `bool` | `null` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | value to set the os type | `string` | `null` | no |
| <a name="input_performance_plus_enabled"></a> [performance\_plus\_enabled](#input\_performance\_plus\_enabled) | value to set the performance plus enabled | `bool` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | value to set the public network access enabled | `bool` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_secure_vm_disk_encryption_set_id"></a> [secure\_vm\_disk\_encryption\_set\_id](#input\_secure\_vm\_disk\_encryption\_set\_id) | value to set the secure vm disk encryption set id | `string` | `null` | no |
| <a name="input_security_type"></a> [security\_type](#input\_security\_type) | value to set the security type | `string` | `null` | no |
| <a name="input_source_resource_id"></a> [source\_resource\_id](#input\_source\_resource\_id) | value to set the source resource id | `string` | `null` | no |
| <a name="input_source_uri"></a> [source\_uri](#input\_source\_uri) | value to set the source uri | `string` | `null` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | value to set the storage account id | `string` | `null` | no |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | value to set the storage account type | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_trusted_launch_enabled"></a> [trusted\_launch\_enabled](#input\_trusted\_launch\_enabled) | value to set the trusted launch enabled | `bool` | `null` | no |
| <a name="input_upload_size_bytes"></a> [upload\_size\_bytes](#input\_upload\_size\_bytes) | value to set the upload size bytes | `number` | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | value to set the zone | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT MANAGED DISK ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->