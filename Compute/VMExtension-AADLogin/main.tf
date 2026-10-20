################################################################################
# Azure AD Login Extension
################################################################################

# DEPENDENCY: Virtual Machine must exist
# DEPENDENCY: VM must have System Assigned Managed Identity

resource "azurerm_virtual_machine_extension" "this" {
  count = var.create ? 1 : 0

  name                       = local.extension_name
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = local.is_linux ? local.linux_publisher : local.windows_publisher
  type                       = local.is_linux ? local.linux_type : local.windows_type
  type_handler_version       = local.is_linux ? local.linux_type_handler_version : local.windows_type_handler_version
  auto_upgrade_minor_version = var.auto_upgrade_minor_version

  tags = local.tags
}
