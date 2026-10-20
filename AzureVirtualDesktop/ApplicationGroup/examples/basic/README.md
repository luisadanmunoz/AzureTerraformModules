<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_app_group_desktop"></a> [app\_group\_desktop](#module\_app\_group\_desktop) | ../../ | n/a |
| <a name="module_app_group_remoteapp"></a> [app\_group\_remoteapp](#module\_app\_group\_remoteapp) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_virtual_desktop_host_pool.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_desktop_app_group_id"></a> [desktop\_app\_group\_id](#output\_desktop\_app\_group\_id) | The ID of the Desktop Application Group |
| <a name="output_remoteapp_group_id"></a> [remoteapp\_group\_id](#output\_remoteapp\_group\_id) | The ID of the RemoteApp Application Group |
<!-- END_TF_DOCS -->