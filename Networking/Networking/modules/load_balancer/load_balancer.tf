#############################################################################
# LOAD BALANCER
#############################################################################
resource "azurerm_lb" "load_balancer" {
  name                = var.load_balancer_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  sku_tier            = var.sku_tier
  edge_zone           = var.edge_zone
  tags                = var.tags

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configurations

    content {
      name                          = frontend_ip_configuration.value.name
      subnet_id                     = try(frontend_ip_configuration.value.subnet_id, null)
      private_ip_address            = try(frontend_ip_configuration.value.private_ip_address, null)
      private_ip_address_allocation = try(frontend_ip_configuration.value.private_ip_address_allocation, null)
      private_ip_address_version    = try(frontend_ip_configuration.value.private_ip_address_version, null)
      public_ip_address_id          = try(frontend_ip_configuration.value.public_ip_address_id, null)
      public_ip_prefix_id           = try(frontend_ip_configuration.value.public_ip_prefix_id, null)
      zones                         = try(frontend_ip_configuration.value.zones, null)
    }
  }
}

resource "azurerm_lb_backend_address_pool" "backend_address_pool" {
  for_each = {
    for backend_address_pool in var.backend_address_pools :
    backend_address_pool.name => backend_address_pool
  }

  name            = each.value.name
  loadbalancer_id = azurerm_lb.load_balancer.id
}

resource "azurerm_lb_probe" "probe" {
  for_each = {
    for probe in var.probes :
    probe.name => probe
  }

  name                = each.value.name
  loadbalancer_id     = azurerm_lb.load_balancer.id
  protocol            = each.value.protocol
  port                = each.value.port
  request_path        = try(each.value.request_path, null)
  interval_in_seconds = try(each.value.interval_in_seconds, null)
  number_of_probes    = try(each.value.number_of_probes, null)
}

resource "azurerm_lb_rule" "rule" {
  for_each = {
    for rule in var.rules :
    rule.name => rule
  }

  name                           = each.value.name
  loadbalancer_id                = azurerm_lb.load_balancer.id
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  backend_address_pool_ids = try(
    each.value.backend_address_pool_name,
    null
  ) != null ? [azurerm_lb_backend_address_pool.backend_address_pool[each.value.backend_address_pool_name].id] : null
  probe_id                = try(each.value.probe_name, null) != null ? azurerm_lb_probe.probe[each.value.probe_name].id : null
  enable_floating_ip      = try(each.value.enable_floating_ip, false)
  idle_timeout_in_minutes = try(each.value.idle_timeout_in_minutes, null)
  load_distribution       = try(each.value.load_distribution, "Default")
  disable_outbound_snat   = try(each.value.disable_outbound_snat, false)
  tcp_reset_enabled       = try(each.value.tcp_reset_enabled, false)
}
