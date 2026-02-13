# Backup Policy VM Module

Terraform module for creating Azure Backup policies for Virtual Machines.

## Description

This module creates a VM Backup Policy with support for:

- **Backup Frequencies**: Hourly (V2 only), Daily, Weekly
- **Retention Policies**: Daily, Weekly, Monthly, Yearly
- **Instant Restore**: Quick recovery from local snapshots
- **Archive Tiering**: Move backups to archive tier for cost savings
- **Policy Types**: V1 (legacy) or V2 (enhanced with hourly backups)

## Usage

### Basic Daily Backup Policy

```hcl
module "backup_policy" {
  source = "./BackupAndUpdate/BackupPolicyVM"

  resource_group_name = "rg-backup-prod-001"
  recovery_vault_name = module.recovery_vault.name

  workload    = "standard"
  environment = "prod"

  backup = {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily = 30

  tags = {
    Environment = "Production"
  }
}
```

### Hourly Backup (Enhanced V2)

```hcl
module "backup_policy_hourly" {
  source = "./BackupAndUpdate/BackupPolicyVM"

  resource_group_name = "rg-backup-prod-001"
  recovery_vault_name = module.recovery_vault.name
  name                = "bkpol-critical-hourly"

  policy_type = "V2"
  timezone    = "Romance Standard Time"

  backup = {
    frequency     = "Hourly"
    hour_interval = 4  # Every 4 hours
    hour_duration = 24 # 24-hour window
  }

  instant_restore_retention_days = 5  # V2 supports up to 30 days

  retention_daily = 30

  retention_weekly = {
    count    = 12
    weekdays = ["Sunday"]
  }
}
```

### Full Enterprise Policy

```hcl
module "backup_policy_enterprise" {
  source = "./BackupAndUpdate/BackupPolicyVM"

  resource_group_name = "rg-backup-prod-001"
  recovery_vault_name = module.recovery_vault.name
  name                = "bkpol-enterprise-full"

  policy_type = "V2"
  timezone    = "UTC"

  backup = {
    frequency = "Daily"
    time      = "02:00"  # 2 AM
  }

  instant_restore_retention_days = 7

  # Daily retention
  retention_daily = 30

  # Weekly retention - keep Sundays for 12 weeks
  retention_weekly = {
    count    = 12
    weekdays = ["Sunday"]
  }

  # Monthly retention - keep first Sunday for 12 months
  retention_monthly = {
    count    = 12
    weekdays = ["Sunday"]
    weeks    = ["First"]
  }

  # Yearly retention - keep first Sunday of January for 7 years
  retention_yearly = {
    count    = 7
    months   = ["January"]
    weekdays = ["Sunday"]
    weeks    = ["First"]
  }
}
```

### With Archive Tiering

```hcl
module "backup_policy_archive" {
  source = "./BackupAndUpdate/BackupPolicyVM"

  resource_group_name = "rg-backup-prod-001"
  recovery_vault_name = module.recovery_vault.name
  name                = "bkpol-archive-tier"

  backup = {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily = 30

  retention_monthly = {
    count = 60
    weeks = ["First"]
    weekdays = ["Sunday"]
  }

  # Move to archive after 90 days
  tiering_policy = {
    archive_tier = {
      mode          = "TierAfter"
      duration      = 90
      duration_type = "Days"
    }
  }
}
```

### Weekly Backup Only

```hcl
module "backup_policy_weekly" {
  source = "./BackupAndUpdate/BackupPolicyVM"

  resource_group_name = "rg-backup-prod-001"
  recovery_vault_name = module.recovery_vault.name

  workload = "dev"

  backup = {
    frequency = "Weekly"
    time      = "03:00"
    weekdays  = ["Sunday"]
  }

  retention_daily = 7

  retention_weekly = {
    count    = 4
    weekdays = ["Sunday"]
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
| policy_type | V1 or V2 (V2 for hourly) | `string` | `"V2"` | no |
| timezone | Timezone for schedules | `string` | `"UTC"` | no |
| instant_restore_retention_days | Snapshot retention days | `number` | `2` | no |
| backup | Backup schedule configuration | `object` | n/a | yes |
| retention_daily | Daily retention count | `number` | `7` | no |
| retention_weekly | Weekly retention config | `object` | `null` | no |
| retention_monthly | Monthly retention config | `object` | `null` | no |
| retention_yearly | Yearly retention config | `object` | `null` | no |
| tiering_policy | Archive tiering config | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Backup Policy |
| name | The name of the Backup Policy |
| policy_type | The policy type (V1/V2) |
| backup_frequency | The backup frequency |
| retention_daily_count | Daily retention count |

## Dependencies

- Resource Group must exist
- Recovery Services Vault must exist

## Related Modules

- [RecoveryServicesVault](../RecoveryServicesVault) - Create the vault first
- [BackupProtectedVM](../BackupProtectedVM) - Apply this policy to VMs

## Policy Type Comparison

| Feature | V1 | V2 |
|---------|----|----|
| Daily Backup | Yes | Yes |
| Weekly Backup | Yes | Yes |
| Hourly Backup | No | Yes |
| Instant Restore Days | 1-5 | 1-30 |
| Multiple Backups/Day | No | Yes |

## Notes

- V2 policies require vault storage mode to be set before first backup
- Hourly backups require V2 policy type
- Archive tiering can significantly reduce storage costs
- Instant restore uses local snapshots for faster recovery
