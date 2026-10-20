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
| [azurerm_backup_protected_vm.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_vm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_backup_policy_id"></a> [backup\_policy\_id](#input\_backup\_policy\_id) | (Required) The ID of the Backup Policy. DEPENDENCY: Backup Policy must exist. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to enable backup protection. | `bool` | `true` | no |
| <a name="input_exclude_disk_luns"></a> [exclude\_disk\_luns](#input\_exclude\_disk\_luns) | (Optional) List of disk LUNs to exclude from backup. | `list(number)` | `null` | no |
| <a name="input_include_disk_luns"></a> [include\_disk\_luns](#input\_include\_disk\_luns) | (Optional) List of disk LUNs to include in backup. If null, all disks are included. | `list(number)` | `null` | no |
| <a name="input_protection_state"></a> [protection\_state](#input\_protection\_state) | (Optional) The protection state. Values: Invalid, IRPending, Protected, etc. | `string` | `null` | no |
| <a name="input_recovery_vault_name"></a> [recovery\_vault\_name](#input\_recovery\_vault\_name) | (Required) The name of the Recovery Services Vault. DEPENDENCY: Vault must exist. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group containing the Vault. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_source_vm_id"></a> [source\_vm\_id](#input\_source\_vm\_id) | (Required) The ID of the VM to protect. DEPENDENCY: VM must exist. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_backup_policy_id"></a> [backup\_policy\_id](#output\_backup\_policy\_id) | The ID of the Backup Policy applied. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Backup Protected VM. |
| <a name="output_source_vm_id"></a> [source\_vm\_id](#output\_source\_vm\_id) | The ID of the protected VM. |
| <a name="output_vm_name"></a> [vm\_name](#output\_vm\_name) | The name of the protected VM. |
<!-- END_TF_DOCS -->