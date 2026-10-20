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
| [azurerm_backup_policy_vm.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_backup"></a> [backup](#input\_backup) | (Required) Backup schedule configuration.<br/>- frequency: Backup frequency. Values: Hourly, Daily, Weekly.<br/>- time: Time of backup in 24h format (e.g., "23:00"). Required for Daily/Weekly.<br/>- hour\_interval: Hours between backups (4, 6, 8, 12). Required for Hourly.<br/>- hour\_duration: Duration window in hours (4-24). Required for Hourly.<br/>- weekdays: Days for weekly backup. | <pre>object({<br/>    frequency     = string<br/>    time          = optional(string, "23:00")<br/>    hour_interval = optional(number, null)<br/>    hour_duration = optional(number, null)<br/>    weekdays      = optional(list(string), null)<br/>  })</pre> | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Backup Policy. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_instant_restore_resource_group"></a> [instant\_restore\_resource\_group](#input\_instant\_restore\_resource\_group) | (Optional) Resource group for instant restore snapshots.<br/>- prefix: Prefix for the resource group name.<br/>- suffix: Suffix for the resource group name. | <pre>object({<br/>    prefix = optional(string, null)<br/>    suffix = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_instant_restore_retention_days"></a> [instant\_restore\_retention\_days](#input\_instant\_restore\_retention\_days) | (Optional) Instant restore snapshot retention in days. 1-5 for V1, 1-30 for V2. Default: 2. | `number` | `2` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Backup Policy. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'bkpol'. | `string` | `"bkpol"` | no |
| <a name="input_policy_type"></a> [policy\_type](#input\_policy\_type) | (Optional) Policy type. Values: V1, V2. V2 supports hourly backups. Default: V2. | `string` | `"V2"` | no |
| <a name="input_recovery_vault_name"></a> [recovery\_vault\_name](#input\_recovery\_vault\_name) | (Required) The name of the Recovery Services Vault. DEPENDENCY: Vault must exist. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_retention_daily"></a> [retention\_daily](#input\_retention\_daily) | (Optional) Number of daily backups to retain. 7-9999. | `number` | `7` | no |
| <a name="input_retention_monthly"></a> [retention\_monthly](#input\_retention\_monthly) | (Optional) Monthly retention configuration.<br/>- count: Number of monthly backups to retain. 1-1188.<br/>- weekdays: Days of week to retain.<br/>- weeks: Weeks of month (First, Second, Third, Fourth, Last).<br/>- days: Specific days of month (1-31).<br/>- include\_last\_days: Include last day of month. | <pre>object({<br/>    count             = number<br/>    weekdays          = optional(list(string), null)<br/>    weeks             = optional(list(string), null)<br/>    days              = optional(list(number), null)<br/>    include_last_days = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_retention_weekly"></a> [retention\_weekly](#input\_retention\_weekly) | (Optional) Weekly retention configuration.<br/>- count: Number of weekly backups to retain. 1-5163.<br/>- weekdays: Days of week to retain. | <pre>object({<br/>    count    = number<br/>    weekdays = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_retention_yearly"></a> [retention\_yearly](#input\_retention\_yearly) | (Optional) Yearly retention configuration.<br/>- count: Number of yearly backups to retain. 1-99.<br/>- months: Months to retain backup.<br/>- weekdays: Days of week to retain.<br/>- weeks: Weeks of month.<br/>- days: Specific days of month.<br/>- include\_last\_days: Include last day of month. | <pre>object({<br/>    count             = number<br/>    months            = list(string)<br/>    weekdays          = optional(list(string), null)<br/>    weeks             = optional(list(string), null)<br/>    days              = optional(list(number), null)<br/>    include_last_days = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_tiering_policy"></a> [tiering\_policy](#input\_tiering\_policy) | (Optional) Tiering policy for Archive tier.<br/>- archive\_tier: Archive tier configuration.<br/>  - mode: TierRecommended or TierAfter.<br/>  - duration: Days/Weeks/Months after which to tier.<br/>  - duration\_type: Days, Weeks, or Months. | <pre>object({<br/>    archive_tier = optional(object({<br/>      mode          = string<br/>      duration      = optional(number, null)<br/>      duration_type = optional(string, null)<br/>    }), null)<br/>  })</pre> | `null` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | (Optional) The timezone for the backup schedule. Default: UTC. | `string` | `"UTC"` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"vm"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_backup_frequency"></a> [backup\_frequency](#output\_backup\_frequency) | The backup frequency. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Backup Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Backup Policy. |
| <a name="output_policy_type"></a> [policy\_type](#output\_policy\_type) | The type of the Backup Policy. |
| <a name="output_retention_daily_count"></a> [retention\_daily\_count](#output\_retention\_daily\_count) | The number of daily backups retained. |
<!-- END_TF_DOCS -->