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
| [azurerm_linux_virtual_machine.linux_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_additional_capabilities"></a> [additional\_capabilities](#input\_additional\_capabilities) | value to set the additional capabilities | <pre>object({<br/>    hibernation_enabled = optional(bool)<br/>    ultra_ssd_enabled   = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | value to set the admin password | `string` | `null` | no |
| <a name="input_admin_ssh_keys"></a> [admin\_ssh\_keys](#input\_admin\_ssh\_keys) | value to set the admin ssh keys | <pre>list(object({<br/>    username   = string<br/>    public_key = string<br/>  }))</pre> | `null` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | value to set the admin username | `string` | `null` | no |
| <a name="input_allow_extension_operations"></a> [allow\_extension\_operations](#input\_allow\_extension\_operations) | value to set the allow extension operations | `bool` | `null` | no |
| <a name="input_availability_set_id"></a> [availability\_set\_id](#input\_availability\_set\_id) | value to set the availability set id | `string` | `null` | no |
| <a name="input_boot_diagnostics"></a> [boot\_diagnostics](#input\_boot\_diagnostics) | value to set the boot diagnostics | <pre>object({<br/>    storage_account_uri = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_bypass_platform_safety_checks_on_user_schedule_enabled"></a> [bypass\_platform\_safety\_checks\_on\_user\_schedule\_enabled](#input\_bypass\_platform\_safety\_checks\_on\_user\_schedule\_enabled) | value to set the bypass platform safety checks on user schedule enabled | `bool` | `null` | no |
| <a name="input_capacity_reservation_group_id"></a> [capacity\_reservation\_group\_id](#input\_capacity\_reservation\_group\_id) | value to set the capacity reservation group id | `string` | `null` | no |
| <a name="input_computer_name"></a> [computer\_name](#input\_computer\_name) | value to set the computer name | `string` | `null` | no |
| <a name="input_custom_data"></a> [custom\_data](#input\_custom\_data) | value to set the custom data | `string` | `null` | no |
| <a name="input_dedicated_host_group_id"></a> [dedicated\_host\_group\_id](#input\_dedicated\_host\_group\_id) | value to set the dedicated host group id | `string` | `null` | no |
| <a name="input_dedicated_host_id"></a> [dedicated\_host\_id](#input\_dedicated\_host\_id) | value to set the dedicated host id | `string` | `null` | no |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | value to set the disable password authentication | `bool` | `null` | no |
| <a name="input_disk_controller_type"></a> [disk\_controller\_type](#input\_disk\_controller\_type) | value to set the disk controller type | `string` | `null` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | value to set the edge zone | `string` | `null` | no |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | value to set the encryption at host enabled | `bool` | `null` | no |
| <a name="input_eviction_policy"></a> [eviction\_policy](#input\_eviction\_policy) | value to set the eviction policy | `string` | `null` | no |
| <a name="input_extensions_time_budget"></a> [extensions\_time\_budget](#input\_extensions\_time\_budget) | value to set the extensions time budget | `string` | `null` | no |
| <a name="input_gallery_applications"></a> [gallery\_applications](#input\_gallery\_applications) | value to set the gallery applications | <pre>list(object({<br/>    version_id                                  = string<br/>    automatic_upgrade_enabled                   = optional(bool)<br/>    configuration_blob_uri                      = optional(string)<br/>    order                                       = optional(number)<br/>    tag                                         = optional(string)<br/>    treat_failure_as_deployment_failure_enabled = optional(bool)<br/>  }))</pre> | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | value to set the identity | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | value to set the license type | `string` | `null` | no |
| <a name="input_linux_virtual_machine_name"></a> [linux\_virtual\_machine\_name](#input\_linux\_virtual\_machine\_name) | value to set the linux virtual machine name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_max_bid_price"></a> [max\_bid\_price](#input\_max\_bid\_price) | value to set the max bid price | `number` | `null` | no |
| <a name="input_network_interface_ids"></a> [network\_interface\_ids](#input\_network\_interface\_ids) | value to set the network interface ids | `list(string)` | n/a | yes |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | value to set the os disk | <pre>object({<br/>    caching                          = string<br/>    disk_encryption_set_id           = optional(string)<br/>    disk_size_gb                     = optional(number)<br/>    name                             = optional(string)<br/>    secure_vm_disk_encryption_set_id = optional(string)<br/>    security_encryption_type         = optional(string)<br/>    storage_account_type             = optional(string)<br/>    write_accelerator_enabled        = optional(bool)<br/>    diff_disk_settings = optional(object({<br/>      option    = string<br/>      placement = optional(string)<br/>    }))<br/>  })</pre> | n/a | yes |
| <a name="input_os_image_notification"></a> [os\_image\_notification](#input\_os\_image\_notification) | value to set the os image notification | <pre>object({<br/>    timeout = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_patch_assessment_mode"></a> [patch\_assessment\_mode](#input\_patch\_assessment\_mode) | value to set the patch assessment mode | `string` | `null` | no |
| <a name="input_patch_mode"></a> [patch\_mode](#input\_patch\_mode) | value to set the patch mode | `string` | `null` | no |
| <a name="input_plan"></a> [plan](#input\_plan) | value to set the plan | <pre>object({<br/>    name      = string<br/>    product   = string<br/>    publisher = string<br/>  })</pre> | `null` | no |
| <a name="input_platform_fault_domain"></a> [platform\_fault\_domain](#input\_platform\_fault\_domain) | value to set the platform fault domain | `number` | `null` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | value to set the priority | `string` | `null` | no |
| <a name="input_provision_vm_agent"></a> [provision\_vm\_agent](#input\_provision\_vm\_agent) | value to set the provision vm agent | `bool` | `null` | no |
| <a name="input_proximity_placement_group_id"></a> [proximity\_placement\_group\_id](#input\_proximity\_placement\_group\_id) | value to set the proximity placement group id | `string` | `null` | no |
| <a name="input_reboot_setting"></a> [reboot\_setting](#input\_reboot\_setting) | value to set the reboot setting | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | value to set the secrets | <pre>list(object({<br/>    key_vault_id = string<br/>    certificates = list(object({<br/>      url = string<br/>    }))<br/>  }))</pre> | `null` | no |
| <a name="input_secure_boot_enabled"></a> [secure\_boot\_enabled](#input\_secure\_boot\_enabled) | value to set the secure boot enabled | `bool` | `null` | no |
| <a name="input_size"></a> [size](#input\_size) | value to set the size | `string` | n/a | yes |
| <a name="input_source_image_id"></a> [source\_image\_id](#input\_source\_image\_id) | value to set the source image id | `string` | `null` | no |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference) | value to set the source image reference | <pre>object({<br/>    publisher = string<br/>    offer     = string<br/>    sku       = string<br/>    version   = string<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_termination_notification"></a> [termination\_notification](#input\_termination\_notification) | value to set the termination notification | <pre>object({<br/>    enabled = bool<br/>    timeout = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | value to set the user data | `string` | `null` | no |
| <a name="input_virtual_machine_scale_set_id"></a> [virtual\_machine\_scale\_set\_id](#input\_virtual\_machine\_scale\_set\_id) | value to set the virtual machine scale set id | `string` | `null` | no |
| <a name="input_vtpm_enabled"></a> [vtpm\_enabled](#input\_vtpm\_enabled) | value to set the vtpm enabled | `bool` | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | value to set the zone | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT LINUX VIRTUAL MACHINE ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_os_managed_disk_id"></a> [os\_managed\_disk\_id](#output\_os\_managed\_disk\_id) | n/a |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | n/a |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | n/a |
| <a name="output_virtual_machine_id"></a> [virtual\_machine\_id](#output\_virtual\_machine\_id) | n/a |
<!-- END_TF_DOCS -->