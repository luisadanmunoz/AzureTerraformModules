# Backup Policy File Share Module

Terraform module for creating Azure Backup policies for Azure File Shares.

## Description

This module creates a File Share Backup Policy with support for:

- **Backup Frequencies**: Hourly or Daily
- **Retention Policies**: Daily, Weekly, Monthly, Yearly
- **Snapshot-based**: Uses Azure Files snapshots for fast backup/restore

## Usage

### Basic Daily Backup Policy

```hcl
module "backup_policy_fileshare" {
  source = "./BackupAndUpdate/BackupPolicyFileShare"

  resource_group_name = "rg-backup-prod-001"
  recovery_vault_name = module.recovery_vault.name

  workload    = "files"
  environment = "prod"

  backup = {
    frequency = "Daily"
    time      = "22:00"
  }

  retention_daily = 30
}
```

### Hourly Backup for Critical File Shares

```hcl
module "backup_policy_fileshare_hourly" {
  source = "./BackupAndUpdate/BackupPolicyFileShare"

  resource_group_name = "rg-backup-prod-001"
  recovery_vault_name = module.recovery_vault.name
  name                = "bkpol-fileshare-hourly"

  timezone = "UTC"

  backup = {
    frequency = "Hourly"
    hourly = {
      interval        = 4   # Every 4 hours
      start_time      = "08:00"
      window_duration = 12  # 12-hour backup window
    }
  }

  retention_daily = 30

  retention_weekly = {
    count    = 12
    weekdays = ["Sunday"]
  }
}
```

### Full Enterprise Policy

```hcl
module "backup_policy_fileshare_enterprise" {
  source = "./BackupAndUpdate/BackupPolicyFileShare"

  resource_group_name = "rg-backup-prod-001"
  recovery_vault_name = module.recovery_vault.name
  name                = "bkpol-fileshare-enterprise"

  timezone = "Romance Standard Time"

  backup = {
    frequency = "Daily"
    time      = "01:00"
  }

  retention_daily = 30

  retention_weekly = {
    count    = 12
    weekdays = ["Sunday"]
  }

  retention_monthly = {
    count    = 12
    weekdays = ["Sunday"]
    weeks    = ["First"]
  }

  retention_yearly = {
    count    = 7
    months   = ["January"]
    weekdays = ["Sunday"]
    weeks    = ["First"]
  }
}
```

### Using Specific Days of Month

```hcl
module "backup_policy_fileshare_monthly" {
  source = "./BackupAndUpdate/BackupPolicyFileShare"

  resource_group_name = "rg-backup-prod-001"
  recovery_vault_name = module.recovery_vault.name

  backup = {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily = 14

  # Keep backups on 1st and 15th of each month
  retention_monthly = {
    count = 24
    days  = [1, 15]
  }

  # Keep year-end backup
  retention_yearly = {
    count             = 7
    months            = ["December"]
    include_last_days = true  # Last day of December
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the resource | `bool` | `true` | no |
| resource_group_name | The name of the Resource Group | `string` | n/a | yes |
| recovery_vault_name | The name of the Recovery Vault | `string` | n/a | yes |
| name | The name of the Policy | `string` | `null` | no |
| timezone | Timezone for schedules | `string` | `"UTC"` | no |
| backup | Backup schedule configuration | `object` | n/a | yes |
| retention_daily | Daily retention count (1-200) | `number` | `30` | no |
| retention_weekly | Weekly retention config | `object` | `null` | no |
| retention_monthly | Monthly retention config | `object` | `null` | no |
| retention_yearly | Yearly retention config (1-10) | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Backup Policy |
| name | The name of the Backup Policy |
| backup_frequency | The backup frequency |
| retention_daily_count | Daily retention count |

## Dependencies

- Resource Group must exist
- Recovery Services Vault must exist

## Related Modules

- [RecoveryServicesVault](../RecoveryServicesVault) - Create the vault first
- [BackupProtectedFileShare](../BackupProtectedFileShare) - Apply policy to file shares

## Comparison with VM Policy

| Feature | VM Policy | File Share Policy |
|---------|-----------|-------------------|
| Daily Retention | 7-9999 | 1-200 |
| Yearly Retention | 1-99 | 1-10 |
| Archive Tier | Yes | No |
| Instant Restore | Yes | No (snapshots) |

## Notes

- File Share backup uses Azure Files snapshots
- Snapshots are stored with the file share (not in the vault)
- Storage account must be registered with the vault before protecting shares
- Only Premium and Standard file shares are supported (not NFS)

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
| [azurerm_backup_policy_file_share.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_file_share) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_backup"></a> [backup](#input\_backup) | (Required) Backup schedule configuration.<br/>- frequency: Backup frequency. Values: Hourly, Daily.<br/>- time: Time of backup in 24h format (e.g., "23:00"). Required for Daily.<br/>- hourly: Hourly backup configuration.<br/>  - interval: Hours between backups (4, 6, 8, 12).<br/>  - start\_time: Start time in 24h format.<br/>  - window\_duration: Backup window in hours. | <pre>object({<br/>    frequency = string<br/>    time      = optional(string, "23:00")<br/>    hourly = optional(object({<br/>      interval        = number<br/>      start_time      = string<br/>      window_duration = number<br/>    }), null)<br/>  })</pre> | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Backup Policy. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Backup Policy. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'bkpol'. | `string` | `"bkpol"` | no |
| <a name="input_recovery_vault_name"></a> [recovery\_vault\_name](#input\_recovery\_vault\_name) | (Required) The name of the Recovery Services Vault. DEPENDENCY: Vault must exist. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_retention_daily"></a> [retention\_daily](#input\_retention\_daily) | (Required) Number of daily backups to retain. 1-200. | `number` | `30` | no |
| <a name="input_retention_monthly"></a> [retention\_monthly](#input\_retention\_monthly) | (Optional) Monthly retention configuration.<br/>- count: Number of monthly backups to retain. 1-120.<br/>- weekdays: Days of week to retain.<br/>- weeks: Weeks of month (First, Second, Third, Fourth, Last).<br/>- days: Specific days of month (1-31).<br/>- include\_last\_days: Include last day of month. | <pre>object({<br/>    count             = number<br/>    weekdays          = optional(list(string), null)<br/>    weeks             = optional(list(string), null)<br/>    days              = optional(list(number), null)<br/>    include_last_days = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_retention_weekly"></a> [retention\_weekly](#input\_retention\_weekly) | (Optional) Weekly retention configuration.<br/>- count: Number of weekly backups to retain. 1-200.<br/>- weekdays: Days of week to retain. | <pre>object({<br/>    count    = number<br/>    weekdays = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_retention_yearly"></a> [retention\_yearly](#input\_retention\_yearly) | (Optional) Yearly retention configuration.<br/>- count: Number of yearly backups to retain. 1-10.<br/>- months: Months to retain backup.<br/>- weekdays: Days of week to retain.<br/>- weeks: Weeks of month.<br/>- days: Specific days of month.<br/>- include\_last\_days: Include last day of month. | <pre>object({<br/>    count             = number<br/>    months            = list(string)<br/>    weekdays          = optional(list(string), null)<br/>    weeks             = optional(list(string), null)<br/>    days              = optional(list(number), null)<br/>    include_last_days = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | (Optional) The timezone for the backup schedule. Default: UTC. | `string` | `"UTC"` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"fileshare"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_backup_frequency"></a> [backup\_frequency](#output\_backup\_frequency) | The backup frequency. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Backup Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Backup Policy. |
| <a name="output_retention_daily_count"></a> [retention\_daily\_count](#output\_retention\_daily\_count) | The number of daily backups retained. |
<!-- END_TF_DOCS -->