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
| <a name="module_storage_sync"></a> [storage\_sync](#module\_storage\_sync) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_share.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cloud_endpoint_ids"></a> [cloud\_endpoint\_ids](#output\_cloud\_endpoint\_ids) | Map of Cloud Endpoint keys to their IDs |
| <a name="output_storage_sync_id"></a> [storage\_sync\_id](#output\_storage\_sync\_id) | The ID of the created Storage Sync Service |
| <a name="output_storage_sync_name"></a> [storage\_sync\_name](#output\_storage\_sync\_name) | The name of the created Storage Sync Service |
| <a name="output_sync_group_ids"></a> [sync\_group\_ids](#output\_sync\_group\_ids) | Map of Sync Group keys to their IDs |
<!-- END_TF_DOCS -->