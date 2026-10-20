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
| [azurerm_virtual_machine_extension.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_auto_upgrade_minor_version"></a> [auto\_upgrade\_minor\_version](#input\_auto\_upgrade\_minor\_version) | (Optional) Auto upgrade minor version. Default: true. | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the extension. | `bool` | `true` | no |
| <a name="input_encryption_operation"></a> [encryption\_operation](#input\_encryption\_operation) | (Optional) Encryption operation. Values: EnableEncryption, DisableEncryption. Default: EnableEncryption. | `string` | `"EnableEncryption"` | no |
| <a name="input_key_encryption_key_url"></a> [key\_encryption\_key\_url](#input\_key\_encryption\_key\_url) | (Optional) The URL of the Key Encryption Key (KEK). If not provided, BEK-only encryption is used. | `string` | `null` | no |
| <a name="input_key_vault_resource_id"></a> [key\_vault\_resource\_id](#input\_key\_vault\_resource\_id) | (Required) The Resource ID of the Key Vault. | `string` | n/a | yes |
| <a name="input_key_vault_url"></a> [key\_vault\_url](#input\_key\_vault\_url) | (Required) The URL of the Key Vault. DEPENDENCY: Key Vault must exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Extension name. Default: AzureDiskEncryption. | `string` | `"AzureDiskEncryption"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | (Required) OS type. Values: Linux, Windows. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_virtual_machine_id"></a> [virtual\_machine\_id](#input\_virtual\_machine\_id) | (Required) The ID of the Virtual Machine. DEPENDENCY: VM must exist. | `string` | n/a | yes |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | (Optional) Volume type to encrypt. Values: OS, Data, All. Default: All. | `string` | `"All"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the VM Extension. |
| <a name="output_name"></a> [name](#output\_name) | The name of the VM Extension. |
| <a name="output_volume_type"></a> [volume\_type](#output\_volume\_type) | The volume type being encrypted. |
<!-- END_TF_DOCS -->