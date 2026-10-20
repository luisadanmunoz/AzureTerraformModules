<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_netapp_volume"></a> [netapp\_volume](#module\_netapp\_volume) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_netapp_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account) | resource |
| [azurerm_netapp_pool.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.netapp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_mount_command"></a> [mount\_command](#output\_mount\_command) | Example mount command for the NFS volume |
| <a name="output_mount_ip_addresses"></a> [mount\_ip\_addresses](#output\_mount\_ip\_addresses) | IP addresses to use for mounting the volume |
| <a name="output_volume_id"></a> [volume\_id](#output\_volume\_id) | The ID of the NetApp Volume |
| <a name="output_volume_name"></a> [volume\_name](#output\_volume\_name) | The name of the NetApp Volume |
| <a name="output_volume_path"></a> [volume\_path](#output\_volume\_path) | The file path of the NetApp Volume |
<!-- END_TF_DOCS -->