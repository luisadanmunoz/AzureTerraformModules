locals {
  is_linux   = var.os_type == "Linux"
  is_windows = var.os_type == "Windows"

  # Linux extension
  linux_publisher            = "Microsoft.Azure.Extensions"
  linux_type                 = "CustomScript"
  linux_type_handler_version = "2.1"

  # Windows extension
  windows_publisher            = "Microsoft.Compute"
  windows_type                 = "CustomScriptExtension"
  windows_type_handler_version = "1.10"

  # Settings
  settings = jsonencode({
    fileUris = length(var.file_uris) > 0 ? var.file_uris : null
  })

  # Protected settings for Linux
  linux_protected_settings = jsonencode({
    commandToExecute       = var.command_to_execute
    script                 = var.script
    storageAccountName     = var.storage_account_name
    storageAccountKey      = var.storage_account_key
    managedIdentity        = var.managed_identity_client_id != null ? { clientId = var.managed_identity_client_id } : null
  })

  # Protected settings for Windows
  windows_protected_settings = jsonencode({
    commandToExecute       = var.command_to_execute
    storageAccountName     = var.storage_account_name
    storageAccountKey      = var.storage_account_key
    managedIdentity        = var.managed_identity_client_id != null ? { clientId = var.managed_identity_client_id } : null
  })

  default_tags = {
    "terraform-managed" = "true"
    "module"            = "VMExtension-CustomScript"
  }
  tags = merge(local.default_tags, var.tags)
}
