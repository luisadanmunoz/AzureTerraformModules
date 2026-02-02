################################################################################
# Load Balancer
################################################################################

resource "azurerm_lb" "this" {
  count = var.create ? 1 : 0

  name                = local.lb_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  sku_tier            = var.sku_tier
  edge_zone           = var.edge_zone

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configurations
    content {
      name                          = frontend_ip_configuration.key
      public_ip_address_id          = frontend_ip_configuration.value.public_ip_address_id
      public_ip_prefix_id           = frontend_ip_configuration.value.public_ip_prefix_id
      subnet_id                     = frontend_ip_configuration.value.subnet_id
      private_ip_address            = frontend_ip_configuration.value.private_ip_address
      private_ip_address_allocation = frontend_ip_configuration.value.subnet_id != null ? frontend_ip_configuration.value.private_ip_address_allocation : null
      private_ip_address_version    = frontend_ip_configuration.value.private_ip_address_version
      zones                         = frontend_ip_configuration.value.zones
    }
  }

  tags = local.tags
}

################################################################################
# Backend Address Pools
################################################################################

resource "azurerm_lb_backend_address_pool" "this" {
  for_each = var.create ? var.backend_address_pools : {}

  name               = each.key
  loadbalancer_id    = azurerm_lb.this[0].id
  virtual_network_id = each.value.virtual_network_id
}

################################################################################
# Health Probes
################################################################################

resource "azurerm_lb_probe" "this" {
  for_each = var.create ? var.probes : {}

  name                = each.key
  loadbalancer_id     = azurerm_lb.this[0].id
  protocol            = each.value.protocol
  port                = each.value.port
  request_path        = each.value.protocol != "Tcp" ? each.value.request_path : null
  interval_in_seconds = each.value.interval_in_seconds
  number_of_probes    = each.value.number_of_probes
  probe_threshold     = each.value.probe_threshold
}

################################################################################
# Load Balancing Rules
################################################################################

resource "azurerm_lb_rule" "this" {
  for_each = var.create ? var.lb_rules : {}

  name                           = each.key
  loadbalancer_id                = azurerm_lb.this[0].id
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  backend_address_pool_ids       = [for name in each.value.backend_address_pool_names : azurerm_lb_backend_address_pool.this[name].id]
  probe_id                       = each.value.probe_name != null ? azurerm_lb_probe.this[each.value.probe_name].id : null
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  enable_floating_ip             = each.value.enable_floating_ip
  idle_timeout_in_minutes        = each.value.idle_timeout_in_minutes
  load_distribution              = each.value.load_distribution
  disable_outbound_snat          = each.value.disable_outbound_snat
  enable_tcp_reset               = var.sku == "Standard" ? each.value.enable_tcp_reset : null
}

################################################################################
# NAT Rules
################################################################################

resource "azurerm_lb_nat_rule" "this" {
  for_each = var.create ? var.nat_rules : {}

  name                           = each.key
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.this[0].id
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_port_start            = each.value.frontend_port_start
  frontend_port_end              = each.value.frontend_port_end
  backend_address_pool_id        = each.value.backend_address_pool_id
  idle_timeout_in_minutes        = each.value.idle_timeout_in_minutes
  enable_floating_ip             = each.value.enable_floating_ip
  enable_tcp_reset               = var.sku == "Standard" ? each.value.enable_tcp_reset : null
}

################################################################################
# Outbound Rules (Standard SKU only)
################################################################################

resource "azurerm_lb_outbound_rule" "this" {
  for_each = var.create && var.sku == "Standard" ? var.outbound_rules : {}

  name                     = each.key
  loadbalancer_id          = azurerm_lb.this[0].id
  backend_address_pool_id  = azurerm_lb_backend_address_pool.this[each.value.backend_address_pool_name].id
  protocol                 = each.value.protocol
  allocated_outbound_ports = each.value.allocated_outbound_ports
  idle_timeout_in_minutes  = each.value.idle_timeout_in_minutes
  enable_tcp_reset         = each.value.enable_tcp_reset

  dynamic "frontend_ip_configuration" {
    for_each = each.value.frontend_ip_configuration_names
    content {
      name = frontend_ip_configuration.value
    }
  }
}

################################################################################
# Diagnostic Settings
################################################################################

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = local.create_diagnostic_settings ? 1 : 0

  name                       = var.diagnostic_settings.name
  target_resource_id         = azurerm_lb.this[0].id
  log_analytics_workspace_id = var.diagnostic_settings.log_analytics_workspace_id
  storage_account_id         = var.diagnostic_settings.storage_account_id

  dynamic "metric" {
    for_each = var.diagnostic_settings.metric_categories
    content {
      category = metric.value
      enabled  = true
    }
  }
}
