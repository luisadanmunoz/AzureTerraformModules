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
