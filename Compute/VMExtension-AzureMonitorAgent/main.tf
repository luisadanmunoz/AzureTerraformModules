################################################################################
# Azure Monitor Agent Extension
################################################################################

# DEPENDENCY: Virtual Machine must exist
# DEPENDENCY: VM must have System or User Assigned Managed Identity

resource "azurerm_virtual_machine_extension" "this" {
  count = var.create ? 1 : 0

  name                       = var.name
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = local.publisher
  type                       = local.is_linux ? local.linux_type : local.windows_type
  type_handler_version       = local.type_handler_version
  auto_upgrade_minor_version = var.auto_upgrade_minor_version
  automatic_upgrade_enabled  = var.automatic_upgrade_enabled

  settings = local.settings

  tags = local.tags
}

################################################################################
# Data Collection Rule Association
################################################################################

# DEPENDENCY: Data Collection Rule must exist

resource "azurerm_monitor_data_collection_rule_association" "this" {
  count = var.create && var.data_collection_rule_id != null ? 1 : 0

  name                        = "dcr-${var.name}"
  target_resource_id          = var.virtual_machine_id
  data_collection_rule_id     = var.data_collection_rule_id
  data_collection_endpoint_id = var.data_collection_endpoint_id

  depends_on = [azurerm_virtual_machine_extension.this]
}
