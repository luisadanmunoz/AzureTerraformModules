################################################################################
# Azure Disk Encryption Extension
################################################################################

# DEPENDENCY: Virtual Machine must exist
# DEPENDENCY: Key Vault must exist with proper access policies

resource "azurerm_virtual_machine_extension" "this" {
  count = var.create ? 1 : 0

  name                       = var.name
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = local.publisher
  type                       = local.is_linux ? local.linux_type : local.windows_type
  type_handler_version       = local.type_handler_version
  auto_upgrade_minor_version = var.auto_upgrade_minor_version

  settings = local.settings

  tags = local.tags
}
