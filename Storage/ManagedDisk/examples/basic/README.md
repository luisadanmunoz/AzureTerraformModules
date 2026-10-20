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
| <a name="module_premium_disk"></a> [premium\_disk](#module\_premium\_disk) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_disk_id"></a> [disk\_id](#output\_disk\_id) | The ID of the Premium Managed Disk. |
| <a name="output_disk_name"></a> [disk\_name](#output\_disk\_name) | The name of the Premium Managed Disk. |
| <a name="output_disk_size_gb"></a> [disk\_size\_gb](#output\_disk\_size\_gb) | The size of the Premium Managed Disk in GB. |
| <a name="output_disk_storage_account_type"></a> [disk\_storage\_account\_type](#output\_disk\_storage\_account\_type) | The storage account type of the Managed Disk. |
<!-- END_TF_DOCS -->