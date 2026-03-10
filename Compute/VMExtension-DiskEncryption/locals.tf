locals {
  is_linux   = var.os_type == "Linux"
  is_windows = var.os_type == "Windows"

  publisher            = "Microsoft.Azure.Security"
  linux_type           = "AzureDiskEncryptionForLinux"
  windows_type         = "AzureDiskEncryption"
  type_handler_version = "2.2"

  settings = jsonencode({
    EncryptionOperation    = var.encryption_operation
    KeyVaultURL            = var.key_vault_url
    KeyVaultResourceId     = var.key_vault_resource_id
    KeyEncryptionKeyURL    = var.key_encryption_key_url
    KeyEncryptionAlgorithm = var.key_encryption_key_url != null ? "RSA-OAEP" : null
    VolumeType             = var.volume_type
  })

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "VMExtension-DiskEncryption"
  }
  tags = merge(local.default_tags, var.tags)
}
