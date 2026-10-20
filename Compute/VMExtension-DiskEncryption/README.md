# VMExtension-DiskEncryption

Terraform module for Azure Disk Encryption (ADE) on VMs.

## Features

- Linux and Windows support
- BEK (BitLocker Encryption Key) only
- KEK (Key Encryption Key) for added security
- Encrypt OS, Data, or All volumes

## Usage

### BEK-only Encryption

```hcl
module "disk_encryption" {
  source = "./Compute/VMExtension-DiskEncryption"

  virtual_machine_id    = module.vm.id
  os_type               = "Windows"
  key_vault_url         = azurerm_key_vault.main.vault_uri
  key_vault_resource_id = azurerm_key_vault.main.id
  volume_type           = "All"
}
```

### With KEK

```hcl
module "disk_encryption" {
  source = "./Compute/VMExtension-DiskEncryption"

  virtual_machine_id     = module.vm.id
  os_type                = "Linux"
  key_vault_url          = azurerm_key_vault.main.vault_uri
  key_vault_resource_id  = azurerm_key_vault.main.id
  key_encryption_key_url = azurerm_key_vault_key.kek.id
  volume_type            = "All"
}
```

## Requirements

- Key Vault with:
  - enabledForDiskEncryption = true
  - Soft delete enabled
  - Proper access policies for VM identity

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| virtual_machine_id | VM ID | `string` | n/a | yes |
| os_type | Linux or Windows | `string` | n/a | yes |
| key_vault_url | Key Vault URL | `string` | n/a | yes |
| key_vault_resource_id | Key Vault ID | `string` | n/a | yes |
| key_encryption_key_url | KEK URL | `string` | `null` | no |
| volume_type | OS, Data, or All | `string` | `"All"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Extension ID |
| volume_type | Volume type encrypted |

## Notes

- Consider using DiskEncryptionSet (CMK) for new deployments
- ADE is for legacy or specific compliance requirements
