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
| [azurerm_netapp_account.netapp_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_active_directory"></a> [active\_directory](#input\_active\_directory) | value to set the active directory | <pre>object({<br/>    dns_servers                       = list(string)<br/>    domain                            = string<br/>    smb_server_name                   = string<br/>    username                          = string<br/>    password                          = string<br/>    aes_encryption_enabled            = optional(bool)<br/>    kerberos_ad_name                  = optional(string)<br/>    kerberos_kdc_ip                   = optional(string)<br/>    ldap_over_tls_enabled             = optional(bool)<br/>    ldap_signing_enabled              = optional(bool)<br/>    local_nfs_users_with_ldap_allowed = optional(bool)<br/>    organizational_unit               = optional(string)<br/>    server_root_ca_certificate        = optional(string)<br/>    site_name                         = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | value to set the identity | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_netapp_account_name"></a> [netapp\_account\_name](#input\_netapp\_account\_name) | value to set the netapp account name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT NETAPP ACCOUNT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->