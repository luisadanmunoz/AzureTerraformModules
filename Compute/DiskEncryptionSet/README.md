# DiskEncryptionSet

Terraform module for creating Azure Disk Encryption Sets (Customer Managed Keys).

## Features

- Customer Managed Key encryption for disks
- Automatic key rotation
- System or User Assigned Identity
- Automatic Key Vault access policy creation
- Confidential VM encryption support

## Usage

```hcl
module "disk_encryption_set" {
  source = "./Compute/DiskEncryptionSet"

  resource_group_name = "rg-compute-prod-001"
  location            = "westeurope"

  workload    = "vm"
  environment = "prod"

  key_vault_key_id          = azurerm_key_vault_key.disk.id
  key_vault_id              = azurerm_key_vault.main.id
  auto_key_rotation_enabled = true
}

# Use with VirtualMachine module
module "vm" {
  source = "./Compute/VirtualMachine"

  os_disk = {
    disk_encryption_set_id = module.disk_encryption_set.id
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
| create | Controls creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | DES name | `string` | `null` | no |
| key_vault_key_id | Key Vault Key ID | `string` | n/a | yes |
| encryption_type | Encryption type | `string` | `"EncryptionAtRestWithCustomerKey"` | no |
| auto_key_rotation_enabled | Auto key rotation | `bool` | `true` | no |
| identity_type | Identity type | `string` | `"SystemAssigned"` | no |
| key_vault_id | Key Vault ID for access policy | `string` | `null` | no |
| tags | Tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The DES ID |
| name | The DES name |
| principal_id | System Assigned Identity Principal ID |
| tenant_id | Identity Tenant ID |

## Notes

- Key Vault must have soft delete and purge protection enabled
- The DES identity needs Get, WrapKey, UnwrapKey permissions on the key
