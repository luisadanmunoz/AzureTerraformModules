<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_netapp_pool"></a> [netapp\_pool](#module\_netapp\_pool) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_netapp_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_netapp_pool_id"></a> [netapp\_pool\_id](#output\_netapp\_pool\_id) | The ID of the created NetApp Capacity Pool |
| <a name="output_netapp_pool_name"></a> [netapp\_pool\_name](#output\_netapp\_pool\_name) | The name of the created NetApp Capacity Pool |
| <a name="output_netapp_pool_service_level"></a> [netapp\_pool\_service\_level](#output\_netapp\_pool\_service\_level) | The service level of the NetApp Capacity Pool |
| <a name="output_netapp_pool_size_in_tb"></a> [netapp\_pool\_size\_in\_tb](#output\_netapp\_pool\_size\_in\_tb) | The size of the NetApp Capacity Pool in TiB |
<!-- END_TF_DOCS -->