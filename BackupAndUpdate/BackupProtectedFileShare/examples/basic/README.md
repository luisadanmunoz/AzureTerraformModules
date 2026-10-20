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
| <a name="module_backup_data_share"></a> [backup\_data\_share](#module\_backup\_data\_share) | ../../ | n/a |
| <a name="module_backup_logs_share"></a> [backup\_logs\_share](#module\_backup\_logs\_share) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_backup_policy_file_share.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_file_share) | resource |
| [azurerm_recovery_services_vault.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_share.data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_storage_share.logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_data_share_backup_id"></a> [data\_share\_backup\_id](#output\_data\_share\_backup\_id) | Backup ID for data share |
| <a name="output_logs_share_backup_id"></a> [logs\_share\_backup\_id](#output\_logs\_share\_backup\_id) | Backup ID for logs share |
<!-- END_TF_DOCS -->