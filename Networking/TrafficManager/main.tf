################################################################################
# Traffic Manager Profile
################################################################################

resource "azurerm_traffic_manager_profile" "this" {
  count = var.create ? 1 : 0

  name                   = local.tm_name
  resource_group_name    = var.resource_group_name
  profile_status         = var.profile_status
  traffic_routing_method = var.traffic_routing_method
  max_return             = var.traffic_routing_method == "MultiValue" ? var.max_return : null
  traffic_view_enabled   = var.traffic_view_enabled

  dns_config {
    relative_name = local.dns_relative_name
    ttl           = var.dns_config_ttl
  }

  monitor_config {
    protocol                     = var.monitor_config.protocol
    port                         = var.monitor_config.port
    path                         = var.monitor_config.protocol != "TCP" ? var.monitor_config.path : null
    interval_in_seconds          = var.monitor_config.interval_in_seconds
    timeout_in_seconds           = var.monitor_config.timeout_in_seconds
    tolerated_number_of_failures = var.monitor_config.tolerated_number_of_failures
    expected_status_code_ranges  = var.monitor_config.expected_status_code_ranges

    dynamic "custom_header" {
      for_each = var.monitor_config.custom_header != null ? var.monitor_config.custom_header : []
      content {
        name  = custom_header.value.name
        value = custom_header.value.value
      }
    }
  }

  tags = local.tags
}

################################################################################
# Azure Endpoints
################################################################################

resource "azurerm_traffic_manager_azure_endpoint" "this" {
  for_each = var.create ? local.azure_endpoints : {}

  name               = each.key
  profile_id         = azurerm_traffic_manager_profile.this[0].id
  target_resource_id = each.value.target_resource_id
  weight             = each.value.weight
  priority           = each.value.priority
  enabled            = each.value.enabled
  geo_mappings       = each.value.geo_mappings

  dynamic "subnet" {
    for_each = each.value.subnet != null ? each.value.subnet : []
    content {
      first = subnet.value.first
      last  = subnet.value.last
      scope = subnet.value.scope
    }
  }

  dynamic "custom_header" {
    for_each = each.value.custom_header != null ? each.value.custom_header : []
    content {
      name  = custom_header.value.name
      value = custom_header.value.value
    }
  }
}

################################################################################
# External Endpoints
################################################################################

resource "azurerm_traffic_manager_external_endpoint" "this" {
  for_each = var.create ? local.external_endpoints : {}

  name              = each.key
  profile_id        = azurerm_traffic_manager_profile.this[0].id
  target            = each.value.target
  weight            = each.value.weight
  priority          = each.value.priority
  endpoint_location = each.value.endpoint_location
  enabled           = each.value.enabled
  geo_mappings      = each.value.geo_mappings

  dynamic "subnet" {
    for_each = each.value.subnet != null ? each.value.subnet : []
    content {
      first = subnet.value.first
      last  = subnet.value.last
      scope = subnet.value.scope
    }
  }

  dynamic "custom_header" {
    for_each = each.value.custom_header != null ? each.value.custom_header : []
    content {
      name  = custom_header.value.name
      value = custom_header.value.value
    }
  }
}

################################################################################
# Nested Endpoints
################################################################################

resource "azurerm_traffic_manager_nested_endpoint" "this" {
  for_each = var.create ? local.nested_endpoints : {}

  name                    = each.key
  profile_id              = azurerm_traffic_manager_profile.this[0].id
  target_resource_id      = each.value.target_resource_id
  weight                  = each.value.weight
  priority                = each.value.priority
  endpoint_location       = each.value.endpoint_location
  minimum_child_endpoints = each.value.min_child_endpoints != null ? each.value.min_child_endpoints : 1
  minimum_required_child_endpoints_ipv4 = each.value.min_child_endpoints_ipv4
  minimum_required_child_endpoints_ipv6 = each.value.min_child_endpoints_ipv6
  enabled                 = each.value.enabled
  geo_mappings            = each.value.geo_mappings

  dynamic "subnet" {
    for_each = each.value.subnet != null ? each.value.subnet : []
    content {
      first = subnet.value.first
      last  = subnet.value.last
      scope = subnet.value.scope
    }
  }

  dynamic "custom_header" {
    for_each = each.value.custom_header != null ? each.value.custom_header : []
    content {
      name  = custom_header.value.name
      value = custom_header.value.value
    }
  }
}

################################################################################
# Diagnostic Settings
################################################################################

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = local.create_diagnostic_settings ? 1 : 0

  name                           = var.diagnostic_settings.name
  target_resource_id             = azurerm_traffic_manager_profile.this[0].id
  log_analytics_workspace_id     = var.diagnostic_settings.log_analytics_workspace_id
  storage_account_id             = var.diagnostic_settings.storage_account_id
  eventhub_authorization_rule_id = var.diagnostic_settings.eventhub_authorization_rule_id
  eventhub_name                  = var.diagnostic_settings.eventhub_name

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
