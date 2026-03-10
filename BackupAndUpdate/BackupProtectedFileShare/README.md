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
