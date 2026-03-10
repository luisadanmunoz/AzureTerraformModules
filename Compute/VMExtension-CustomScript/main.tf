################################################################################
# Custom Script Extension
################################################################################

# DEPENDENCY: Virtual Machine must exist

resource "azurerm_virtual_machine_extension" "this" {
  count = var.create ? 1 : 0

  name                       = var.name
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = local.is_linux ? local.linux_publisher : local.windows_publisher
  type                       = local.is_linux ? local.linux_type : local.windows_type
  type_handler_version       = local.is_linux ? local.linux_type_handler_version : local.windows_type_handler_version
  auto_upgrade_minor_version = var.auto_upgrade_minor_version
  automatic_upgrade_enabled  = var.automatic_upgrade_enabled

  settings           = local.settings
  protected_settings = local.is_linux ? local.linux_protected_settings : local.windows_protected_settings

  tags = local.tags
}
