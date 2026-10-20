# Recovery Services Vault Module

Terraform module for creating and managing Azure Recovery Services Vaults.

## Description

This module creates a Recovery Services Vault for Azure Backup and Site Recovery with support for:

- **Storage Redundancy**: GeoRedundant, LocallyRedundant, ZoneRedundant
- **Cross-Region Restore**: Restore backups to secondary region
- **Soft Delete**: Protect against accidental deletion (14 days retention)
- **Immutability**: Prevent backup deletion (compliance)
- **Customer Managed Keys**: Encrypt backups with your own keys
- **Monitoring & Alerts**: Built-in alerting for job failures
- **Diagnostic Settings**: Send logs to Log Analytics, Storage, Event Hub

## Usage

### Basic Vault

```hcl
module "recovery_vault" {
  source = "./BackupAndUpdate/RecoveryServicesVault"

  resource_group_name = "rg-backup-prod-001"
  location            = "westeurope"
  name                = "rsv-backup-prod-001"

  storage_mode_type   = "GeoRedundant"
  soft_delete_enabled = true

  tags = {
    Environment = "Production"
  }
}
```

### With Cross-Region Restore

```hcl
module "recovery_vault" {
  source = "./BackupAndUpdate/RecoveryServicesVault"

  resource_group_name = "rg-backup-prod-001"
  location            = "westeurope"

  workload    = "enterprise"
  environment = "prod"

  storage_mode_type            = "GeoRedundant"
  cross_region_restore_enabled = true
  soft_delete_enabled          = true

  tags = {
    Environment = "Production"
    DR          = "Enabled"
  }
}
```

### With Immutability (Compliance)

```hcl
module "recovery_vault_compliant" {
  source = "./BackupAndUpdate/RecoveryServicesVault"

  resource_group_name = "rg-backup-prod-001"
  location            = "westeurope"
  name                = "rsv-compliant-prod-001"

  storage_mode_type   = "GeoRedundant"
  soft_delete_enabled = true
  immutability        = "Locked"  # Cannot be changed once locked!

  tags = {
    Environment = "Production"
    Compliance  = "Required"
  }
}
```

### With Customer Managed Key (CMK)

```hcl
module "recovery_vault_cmk" {
  source = "./BackupAndUpdate/RecoveryServicesVault"

  resource_group_name = "rg-backup-prod-001"
  location            = "westeurope"

  storage_mode_type   = "GeoRedundant"
  soft_delete_enabled = true

  # System Assigned Identity for CMK
  identity = {
    type = "SystemAssigned"
  }

  encryption = {
    key_id                            = module.key_vault_key.id
    infrastructure_encryption_enabled = true
    use_system_assigned_identity      = true
  }

  tags = {
    Environment = "Production"
    Encryption  = "CMK"
  }
}
```

### With Diagnostic Settings

```hcl
module "recovery_vault" {
  source = "./BackupAndUpdate/RecoveryServicesVault"

  resource_group_name = "rg-backup-prod-001"
  location            = "westeurope"

  storage_mode_type   = "GeoRedundant"
  soft_delete_enabled = true

  diagnostic_settings = {
    name                       = "diag-rsv-prod"
    log_analytics_workspace_id = module.log_analytics.id
    log_categories = [
      "CoreAzureBackup",
      "AddonAzureBackupJobs",
      "AddonAzureBackupAlerts",
      "AzureBackupReport"
    ]
  }

  tags = {
    Environment = "Production"
  }
}
```

### Private Access Only

```hcl
module "recovery_vault_private" {
  source = "./BackupAndUpdate/RecoveryServicesVault"

  resource_group_name = "rg-backup-prod-001"
  location            = "westeurope"

  storage_mode_type             = "GeoRedundant"
  soft_delete_enabled           = true
  public_network_access_enabled = false  # Requires Private Endpoint

  tags = {
    Environment  = "Production"
    NetworkMode  = "Private"
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
| location | The Azure Region | `string` | n/a | yes |
| name | The name of the Vault | `string` | `null` | no |
| sku | SKU: Standard or RS0 | `string` | `"Standard"` | no |
| storage_mode_type | Storage redundancy type | `string` | `"GeoRedundant"` | no |
| cross_region_restore_enabled | Enable CRR (GRS only) | `bool` | `false` | no |
| soft_delete_enabled | Enable soft delete | `bool` | `true` | no |
| immutability | Immutability: Disabled, Unlocked, Locked | `string` | `"Disabled"` | no |
| public_network_access_enabled | Enable public access | `bool` | `true` | no |
| identity | Identity configuration | `object` | `null` | no |
| encryption | CMK encryption configuration | `object` | `null` | no |
| monitoring | Alerting configuration | `object` | `{}` | no |
| diagnostic_settings | Diagnostic settings | `object` | `null` | no |
| tags | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Vault |
| name | The name of the Vault |
| sku | The SKU of the Vault |
| storage_mode_type | The storage mode type |
| identity | Identity information |
| principal_id | System Assigned Identity Principal ID |

## Dependencies

- Resource Group must exist
- Key Vault Key must exist (if using CMK)
- Log Analytics Workspace must exist (if using diagnostics)

## Related Modules

- [BackupPolicyVM](../BackupPolicyVM) - Create backup policies for VMs
- [BackupPolicyFileShare](../BackupPolicyFileShare) - Create backup policies for File Shares
- [BackupProtectedVM](../BackupProtectedVM) - Protect VMs with backup

## Storage Mode Comparison

| Mode | Description | CRR Support |
|------|-------------|-------------|
| GeoRedundant (GRS) | Replicated to paired region | Yes |
| LocallyRedundant (LRS) | 3 copies in same datacenter | No |
| ZoneRedundant (ZRS) | Replicated across availability zones | No |

## Notes

- Soft delete retains deleted backups for 14 days
- Immutability "Locked" is permanent and cannot be changed
- CMK requires identity with Key Vault access
- Cross-Region Restore only works with GeoRedundant storage

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
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_recovery_services_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_classic_vmware_replication_enabled"></a> [classic\_vmware\_replication\_enabled](#input\_classic\_vmware\_replication\_enabled) | (Optional) Enable classic VMware replication. Default: false. | `bool` | `false` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Recovery Services Vault. | `bool` | `true` | no |
| <a name="input_cross_region_restore_enabled"></a> [cross\_region\_restore\_enabled](#input\_cross\_region\_restore\_enabled) | (Optional) Enable cross-region restore. Only for GeoRedundant. Default: false. | `bool` | `false` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | (Optional) Diagnostic settings for the Vault.<br/>- name: Name of the diagnostic setting.<br/>- log\_analytics\_workspace\_id: Log Analytics Workspace ID.<br/>- storage\_account\_id: Storage Account ID for archival.<br/>- eventhub\_authorization\_rule\_id: Event Hub authorization rule ID.<br/>- eventhub\_name: Event Hub name.<br/>- log\_categories: List of log categories to enable. | <pre>object({<br/>    name                           = optional(string, "diag-rsv")<br/>    log_analytics_workspace_id     = optional(string, null)<br/>    storage_account_id             = optional(string, null)<br/>    eventhub_authorization_rule_id = optional(string, null)<br/>    eventhub_name                  = optional(string, null)<br/>    log_categories = optional(list(string), [<br/>      "CoreAzureBackup",<br/>      "AddonAzureBackupJobs",<br/>      "AddonAzureBackupAlerts",<br/>      "AddonAzureBackupPolicy",<br/>      "AddonAzureBackupStorage",<br/>      "AddonAzureBackupProtectedInstance",<br/>      "AzureBackupReport",<br/>      "AzureSiteRecoveryJobs",<br/>      "AzureSiteRecoveryEvents",<br/>      "AzureSiteRecoveryReplicatedItems"<br/>    ])<br/>  })</pre> | `null` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | (Optional) Customer Managed Key encryption configuration.<br/>- key\_id: The Key Vault Key ID.<br/>- infrastructure\_encryption\_enabled: Enable infrastructure encryption.<br/>- use\_system\_assigned\_identity: Use system or user assigned identity.<br/>- user\_assigned\_identity\_id: User assigned identity for key access. | <pre>object({<br/>    key_id                             = string<br/>    infrastructure_encryption_enabled  = optional(bool, false)<br/>    use_system_assigned_identity       = optional(bool, true)<br/>    user_assigned_identity_id          = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Identity configuration for CMK encryption.<br/>- type: Identity type. Values: SystemAssigned, UserAssigned.<br/>- identity\_ids: List of User Assigned Identity IDs. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_immutability"></a> [immutability](#input\_immutability) | (Optional) Immutability setting. Values: Disabled, Unlocked, Locked. Default: Disabled. | `string` | `"Disabled"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Vault should exist. | `string` | n/a | yes |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | (Optional) Monitoring and alerting configuration.<br/>- alerts\_for\_all\_job\_failures\_enabled: Alert on job failures.<br/>- alerts\_for\_critical\_operation\_failures\_enabled: Alert on critical failures. | <pre>object({<br/>    alerts_for_all_job_failures_enabled            = optional(bool, true)<br/>    alerts_for_critical_operation_failures_enabled = optional(bool, true)<br/>  })</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Recovery Services Vault. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'rsv'. | `string` | `"rsv"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Enable public network access. Default: true. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) The SKU of the Vault. Values: Standard, RS0. Default: Standard. | `string` | `"Standard"` | no |
| <a name="input_soft_delete_enabled"></a> [soft\_delete\_enabled](#input\_soft\_delete\_enabled) | (Optional) Enable soft delete for backup items. Default: true. | `bool` | `true` | no |
| <a name="input_storage_mode_type"></a> [storage\_mode\_type](#input\_storage\_mode\_type) | (Optional) The storage type. Values: GeoRedundant, LocallyRedundant, ZoneRedundant. Default: GeoRedundant. | `string` | `"GeoRedundant"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"backup"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Recovery Services Vault. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity of the Vault. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Recovery Services Vault. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID of the System Assigned Identity. |
| <a name="output_sku"></a> [sku](#output\_sku) | The SKU of the Vault. |
| <a name="output_storage_mode_type"></a> [storage\_mode\_type](#output\_storage\_mode\_type) | The storage mode type of the Vault. |
<!-- END_TF_DOCS -->