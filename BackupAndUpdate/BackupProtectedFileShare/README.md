# BackupProtectedFileShare

Terraform module for enabling Azure Backup protection on Azure File Shares.

## Features

- Enable backup protection on Azure File Shares
- Automatic storage account container registration
- Support for custom backup policies
- Conditional creation with `create` flag

## Usage

```hcl
module "fileshare_backup" {
  source = "./BackupAndUpdate/BackupProtectedFileShare"

  resource_group_name       = "rg-backup-prod-001"
  recovery_vault_name       = "rsv-backup-prod-001"
  source_storage_account_id = "/subscriptions/.../storageAccounts/stprod001"
  source_file_share_name    = "share-data"
  backup_policy_id          = "/subscriptions/.../backupPolicies/policy-daily"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Dependencies

- Resource Group must exist
- Recovery Services Vault must exist
- Storage Account must exist
- File Share must exist
- Backup Policy (File Share) must exist

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the resource | `bool` | `true` | no |
| resource_group_name | Resource Group name where Recovery Vault exists | `string` | n/a | yes |
| recovery_vault_name | Name of the Recovery Services Vault | `string` | n/a | yes |
| source_storage_account_id | ID of the Storage Account | `string` | n/a | yes |
| source_file_share_name | Name of the File Share to protect | `string` | n/a | yes |
| backup_policy_id | ID of the Backup Policy | `string` | n/a | yes |
| tags | Tags to assign to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Backup Protected File Share |
| container_id | The ID of the Backup Container Storage Account |
| source_file_share_name | The name of the protected file share |
| backup_policy_id | The ID of the backup policy used |

## Notes

- The module automatically registers the Storage Account as a backup container
- File Shares must exist before enabling backup protection
- Soft delete is recommended on the Recovery Services Vault

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

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_backup_container_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_container_storage_account) | resource |
| [azurerm_backup_protected_file_share.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_file_share) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_backup_policy_id"></a> [backup\_policy\_id](#input\_backup\_policy\_id) | (Required) The ID of the backup policy to use. DEPENDENCY: Backup Policy must exist. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the backup protected file share. | `bool` | `true` | no |
| <a name="input_recovery_vault_name"></a> [recovery\_vault\_name](#input\_recovery\_vault\_name) | (Required) The name of the Recovery Services Vault. DEPENDENCY: Recovery Vault must exist. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Recovery Vault exists. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_source_file_share_name"></a> [source\_file\_share\_name](#input\_source\_file\_share\_name) | (Required) The name of the file share to backup. DEPENDENCY: File Share must exist. | `string` | n/a | yes |
| <a name="input_source_storage_account_id"></a> [source\_storage\_account\_id](#input\_source\_storage\_account\_id) | (Required) The ID of the Storage Account containing the file share. DEPENDENCY: Storage Account must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_backup_policy_id"></a> [backup\_policy\_id](#output\_backup\_policy\_id) | The ID of the backup policy used. |
| <a name="output_container_id"></a> [container\_id](#output\_container\_id) | The ID of the Backup Container Storage Account. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Backup Protected File Share. |
| <a name="output_source_file_share_name"></a> [source\_file\_share\_name](#output\_source\_file\_share\_name) | The name of the protected file share. |
<!-- END_TF_DOCS -->