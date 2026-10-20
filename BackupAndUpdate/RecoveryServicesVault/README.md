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
