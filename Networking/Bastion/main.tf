################################################################################
# Public IP for Bastion
################################################################################

resource "azurerm_public_ip" "this" {
  count = local.create_public_ip ? 1 : 0

  name                = "pip-${local.bastion_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]

  tags = local.tags
}

################################################################################
# Bastion Host
################################################################################

resource "azurerm_bastion_host" "this" {
  count = var.create ? 1 : 0

  name                = local.bastion_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku        = var.sku
  scale_units = var.sku != "Basic" ? var.scale_units : 2

  copy_paste_enabled     = var.copy_paste_enabled
  file_copy_enabled      = var.sku != "Basic" ? var.file_copy_enabled : false
  ip_connect_enabled     = var.sku != "Basic" ? var.ip_connect_enabled : false
  shareable_link_enabled = var.sku != "Basic" ? var.shareable_link_enabled : false
  tunneling_enabled      = var.sku != "Basic" ? var.tunneling_enabled : false
  kerberos_enabled       = var.sku != "Basic" ? var.kerberos_enabled : false

  virtual_network_id        = var.sku == "Premium" ? var.virtual_network_id : null
  session_recording_enabled = var.sku == "Premium" ? var.session_recording_enabled : false

  ip_configuration {
    name                 = "ipconfig"
    subnet_id            = var.subnet_id
    public_ip_address_id = local.create_public_ip ? azurerm_public_ip.this[0].id : var.public_ip_id
  }

  tags = local.tags
}

################################################################################
# Diagnostic Settings
################################################################################

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = local.create_diagnostic_settings ? 1 : 0

  name                       = var.diagnostic_settings.name
  target_resource_id         = azurerm_bastion_host.this[0].id
  log_analytics_workspace_id = var.diagnostic_settings.log_analytics_workspace_id
  storage_account_id         = var.diagnostic_settings.storage_account_id

  dynamic "enabled_log" {
    for_each = var.diagnostic_settings.log_categories
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = var.diagnostic_settings.metric_categories
    content {
      category = metric.value
      enabled  = true
    }
  }
}
