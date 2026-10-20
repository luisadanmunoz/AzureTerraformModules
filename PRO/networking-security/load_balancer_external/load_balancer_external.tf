#############################################################################
# LOAD BALANCER
#############################################################################
resource "azurerm_lb" "lbe" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  frontend_ip_configuration {
    name                 = var.name_ip
    public_ip_address_id = var.public_ip_address_id
  }

  tags = var.tags
}
#############################################################################
# BACKEND
#############################################################################
resource "azurerm_lb_backend_address_pool" "lbe_backend_address_pool" {
  name            = "backend"
  loadbalancer_id = azurerm_lb.lbe.id
}
resource "azurerm_network_interface_backend_address_pool_association" "nic-pa-hub-01-nic-untrust" {
  network_interface_id    = var.network_interface_id_01
  ip_configuration_name   = var.ip_configuration_name_01
  backend_address_pool_id = azurerm_lb_backend_address_pool.lbe_backend_address_pool.id
}
resource "azurerm_network_interface_backend_address_pool_association" "nic-pa-hub-02-nic-untrust" {
  network_interface_id    = var.network_interface_id_02
  ip_configuration_name   = var.ip_configuration_name_02
  backend_address_pool_id = azurerm_lb_backend_address_pool.lbe_backend_address_pool.id
}
#############################################################################
# LOAD BALANCER - PROBE PORT 80
#############################################################################
resource "azurerm_lb_probe" "lbe_probe" {
  name            = "tcp-probe"
  protocol        = "Tcp"
  port            = 80
  loadbalancer_id = azurerm_lb.lbe.id
}
#############################################################################
# LOAD BALANCER - RULE
#############################################################################
resource "azurerm_lb_rule" "lb_rule" {
  name                           = "rule1"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.lbe.frontend_ip_configuration[0].name
  probe_id                       = azurerm_lb_probe.lbe_probe.id
  loadbalancer_id                = azurerm_lb.lbe.id
  //load_distribution              = var.lb_rule_load_distribution
  backend_address_pool_ids = var.backend_address_pool_ids
  //enable_floating_ip             = "true"
}
#############################################################################
# DIAGNOSTIC SETTINGS
#############################################################################
data "azurerm_monitor_diagnostic_categories" "diagnostic_setting" {
  resource_id = azurerm_lb.lbe.id
}
resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                       = var.name_diagnostic_setting
  target_resource_id         = azurerm_lb.lbe.id
  log_analytics_workspace_id = var.workspace_resource_id

  dynamic "enabled_log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.diagnostic_setting.log_category_types
    content {
      category = entry.value
      #enabled  = true
    }
  }
  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.diagnostic_setting.metrics
    content {
      category = entry.value
      enabled  = true
    }
  }

  lifecycle {
    ignore_changes = [log, metric]
  }
}