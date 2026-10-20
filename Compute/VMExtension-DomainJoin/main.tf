################################################################################
# AD Domain Join Extension
################################################################################

# DEPENDENCY: Virtual Machine must exist
# DEPENDENCY: Domain Controller must be reachable

resource "azurerm_virtual_machine_extension" "this" {
  count = var.create ? 1 : 0

  name                       = var.name
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = local.publisher
  type                       = local.type
  type_handler_version       = local.type_handler_version
  auto_upgrade_minor_version = var.auto_upgrade_minor_version

  settings           = local.settings
  protected_settings = local.protected_settings

  tags = local.tags
}
