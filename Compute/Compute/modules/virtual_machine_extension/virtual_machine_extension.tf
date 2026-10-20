#############################################################################
# VIRTUAL MACHINE EXTENSION
#############################################################################
resource "azurerm_virtual_machine_extension" "virtual_machine_extension" {
  name                        = var.virtual_machine_extension_name
  virtual_machine_id          = var.virtual_machine_id
  publisher                   = var.publisher
  type                        = var.type
  type_handler_version        = var.type_handler_version
  auto_upgrade_minor_version  = var.auto_upgrade_minor_version
  automatic_upgrade_enabled   = var.automatic_upgrade_enabled
  failure_suppression_enabled = var.failure_suppression_enabled
  provision_after_extensions  = var.provision_after_extensions
  settings                    = local.settings
  protected_settings          = local.protected_settings
  tags                        = var.tags

  dynamic "protected_settings_from_key_vault" {
    for_each = var.protected_settings_from_key_vault != null ? [var.protected_settings_from_key_vault] : []

    content {
      secret_url      = protected_settings_from_key_vault.value["secret_url"]
      source_vault_id = protected_settings_from_key_vault.value["source_vault_id"]
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
