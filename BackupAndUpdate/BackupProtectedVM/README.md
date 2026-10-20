# Backup Protected VM Module

Terraform module for enabling Azure Backup protection on Virtual Machines.

## Description

This module enables backup protection for VMs with support for:

- **Policy Assignment**: Apply backup policies to VMs
- **Disk Selection**: Include or exclude specific disks
- **Multiple VMs**: Use for_each to protect multiple VMs

## Usage

### Basic VM Protection

```hcl
module "vm_backup" {
  source = "./BackupAndUpdate/BackupProtectedVM"

  resource_group_name = "rg-backup-prod-001"
  recovery_vault_name = module.recovery_vault.name
  backup_policy_id    = module.backup_policy.id
  source_vm_id        = module.virtual_machine.id
}
```

### Multiple VMs with Same Policy

```hcl
variable "vm_ids" {
  default = [
    "/subscriptions/xxx/resourceGroups/rg-app/providers/Microsoft.Compute/virtualMachines/vm-app-001",
    "/subscriptions/xxx/resourceGroups/rg-app/providers/Microsoft.Compute/virtualMachines/vm-app-002",
    "/subscriptions/xxx/resourceGroups/rg-app/providers/Microsoft.Compute/virtualMachines/vm-app-003",
  ]
}

module "vm_backups" {
  source   = "./BackupAndUpdate/BackupProtectedVM"
  for_each = toset(var.vm_ids)

  resource_group_name = "rg-backup-prod-001"
  recovery_vault_name = module.recovery_vault.name
  backup_policy_id    = module.backup_policy.id
  source_vm_id        = each.value
}
```

### Exclude Data Disks

```hcl
module "vm_backup_osonly" {
  source = "./BackupAndUpdate/BackupProtectedVM"

  resource_group_name = "rg-backup-prod-001"
  recovery_vault_name = module.recovery_vault.name
  backup_policy_id    = module.backup_policy.id
  source_vm_id        = module.virtual_machine.id

  # Exclude data disks (LUN 0, 1, 2)
  exclude_disk_luns = [0, 1, 2]
}
```

### Include Only Specific Disks

```hcl
module "vm_backup_selective" {
  source = "./BackupAndUpdate/BackupProtectedVM"

  resource_group_name = "rg-backup-prod-001"
  recovery_vault_name = module.recovery_vault.name
  backup_policy_id    = module.backup_policy.id
  source_vm_id        = module.virtual_machine.id

  # Only backup OS disk and LUN 0 data disk
  include_disk_luns = [0]  # OS disk is always included
}
```

### Complete Backup Setup

```hcl
# 1. Recovery Services Vault
module "recovery_vault" {
  source = "./BackupAndUpdate/RecoveryServicesVault"

  resource_group_name = azurerm_resource_group.backup.name
  location            = azurerm_resource_group.backup.location
  storage_mode_type   = "GeoRedundant"
}

# 2. Backup Policy
module "backup_policy" {
  source = "./BackupAndUpdate/BackupPolicyVM"

  resource_group_name = azurerm_resource_group.backup.name
  recovery_vault_name = module.recovery_vault.name

  backup = {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily = 30
}

# 3. Protect VMs
module "vm_backup" {
  source   = "./BackupAndUpdate/BackupProtectedVM"
  for_each = toset(var.vm_ids_to_protect)

  resource_group_name = azurerm_resource_group.backup.name
  recovery_vault_name = module.recovery_vault.name
  backup_policy_id    = module.backup_policy.id
  source_vm_id        = each.value
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
| resource_group_name | Resource Group containing the Vault | `string` | n/a | yes |
| recovery_vault_name | Name of the Recovery Vault | `string` | n/a | yes |
| backup_policy_id | ID of the Backup Policy | `string` | n/a | yes |
| source_vm_id | ID of the VM to protect | `string` | n/a | yes |
| include_disk_luns | Disk LUNs to include | `list(number)` | `null` | no |
| exclude_disk_luns | Disk LUNs to exclude | `list(number)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Backup Protected VM |
| source_vm_id | The VM ID |
| vm_name | The VM name |
| backup_policy_id | The applied policy ID |

## Dependencies

- Resource Group must exist
- Recovery Services Vault must exist
- Backup Policy must exist
- VM must exist and be in the same region as the vault

## Notes

- VM and Vault must be in the same Azure region
- First backup runs after the policy's scheduled time
- Use `exclude_disk_luns` for VMs with non-critical data disks
- OS disk is always backed up (cannot be excluded)
- Soft delete protection applies to backup data
