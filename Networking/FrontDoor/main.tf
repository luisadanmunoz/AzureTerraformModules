################################################################################
# Front Door Profile (CDN-based)
################################################################################

resource "azurerm_cdn_frontdoor_profile" "this" {
  count = var.create ? 1 : 0

  name                     = local.afd_name
  resource_group_name      = var.resource_group_name
  sku_name                 = var.sku_name
  response_timeout_seconds = var.response_timeout_seconds

  tags = local.tags
}

################################################################################
# Front Door Endpoints
################################################################################

resource "azurerm_cdn_frontdoor_endpoint" "this" {
  for_each = var.create ? local.endpoint_map : {}

  name                     = each.value.name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this[0].id
  enabled                  = each.value.enabled

  tags = local.tags
}

################################################################################
# Front Door Origin Groups
################################################################################

resource "azurerm_cdn_frontdoor_origin_group" "this" {
  for_each = var.create ? local.origin_group_map : {}

  name                     = each.value.name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this[0].id
  session_affinity_enabled = each.value.session_affinity_enabled

  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = each.value.restore_traffic_time_to_healed_or_new_endpoint_in_minutes

  load_balancing {
    additional_latency_in_milliseconds = each.value.load_balancing.additional_latency_in_milliseconds
    sample_size                        = each.value.load_balancing.sample_size
    successful_samples_required        = each.value.load_balancing.successful_samples_required
  }

  dynamic "health_probe" {
    for_each = each.value.health_probe != null ? [each.value.health_probe] : []
    content {
      interval_in_seconds = health_probe.value.interval_in_seconds
      path                = health_probe.value.path
      protocol            = health_probe.value.protocol
      request_type        = health_probe.value.request_type
    }
  }
}

################################################################################
# Front Door Origins
################################################################################

resource "azurerm_cdn_frontdoor_origin" "this" {
  for_each = var.create ? { for o in var.origins : o.name => o } : {}

  name                           = each.value.name
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.this[each.value.origin_group_name].id
  host_name                      = each.value.host_name
  http_port                      = each.value.http_port
  https_port                     = each.value.https_port
  origin_host_header             = each.value.origin_host_header != null ? each.value.origin_host_header : each.value.host_name
  priority                       = each.value.priority
  weight                         = each.value.weight
  enabled                        = each.value.enabled
  certificate_name_check_enabled = each.value.certificate_name_check_enabled

  dynamic "private_link" {
    for_each = each.value.private_link != null ? [each.value.private_link] : []
    content {
      request_message        = private_link.value.request_message
      target_type            = private_link.value.target_type
      location               = private_link.value.location
      private_link_target_id = private_link.value.private_link_target_id
    }
  }
}

################################################################################
# Front Door Routes
################################################################################

resource "azurerm_cdn_frontdoor_route" "this" {
  for_each = var.create ? { for r in var.routes : r.name => r } : {}

  name                          = each.value.name
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.this[each.value.endpoint_name].id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.this[each.value.origin_group_name].id

  cdn_frontdoor_origin_ids = [
    for origin_name in each.value.origin_names :
    azurerm_cdn_frontdoor_origin.this[origin_name].id
  ]

  patterns_to_match      = each.value.patterns_to_match
  supported_protocols    = each.value.supported_protocols
  forwarding_protocol    = each.value.forwarding_protocol
  https_redirect_enabled = each.value.https_redirect_enabled
  link_to_default_domain = each.value.link_to_default_domain

  dynamic "cache" {
    for_each = each.value.cache != null ? [each.value.cache] : []
    content {
      query_string_caching_behavior = cache.value.query_string_caching_behavior
      query_strings                 = length(cache.value.query_strings) > 0 ? cache.value.query_strings : null
      compression_enabled           = cache.value.compression_enabled
      content_types_to_compress     = length(cache.value.content_types_to_compress) > 0 ? cache.value.content_types_to_compress : null
    }
  }

  depends_on = [
    azurerm_cdn_frontdoor_origin.this,
    azurerm_cdn_frontdoor_origin_group.this,
  ]
}

################################################################################
# Front Door Custom Domains
################################################################################

resource "azurerm_cdn_frontdoor_custom_domain" "this" {
  for_each = var.create ? { for cd in var.custom_domains : cd.name => cd } : {}

  name                     = each.value.name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this[0].id
  host_name                = each.value.host_name

  tls {
    certificate_type        = each.value.tls.certificate_type
    minimum_tls_version     = each.value.tls.minimum_tls_version
    cdn_frontdoor_secret_id = each.value.tls.cdn_frontdoor_secret_id
  }
}

################################################################################
# Front Door Security Policies
################################################################################

resource "azurerm_cdn_frontdoor_security_policy" "this" {
  for_each = var.create ? { for sp in var.security_policies : sp.name => sp } : {}

  name                     = each.value.name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this[0].id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = each.value.firewall_policy_id

      association {
        patterns_to_match = each.value.patterns_to_match

        dynamic "domain" {
          for_each = azurerm_cdn_frontdoor_endpoint.this
          content {
            cdn_frontdoor_domain_id = domain.value.id
          }
        }

        dynamic "domain" {
          for_each = azurerm_cdn_frontdoor_custom_domain.this
          content {
            cdn_frontdoor_domain_id = domain.value.id
          }
        }
      }
    }
  }
}

################################################################################
# Diagnostic Settings
################################################################################

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = local.create_diagnostic_settings ? 1 : 0

  name                           = var.diagnostic_settings.name
  target_resource_id             = azurerm_cdn_frontdoor_profile.this[0].id
  log_analytics_workspace_id     = var.diagnostic_settings.log_analytics_workspace_id
  storage_account_id             = var.diagnostic_settings.storage_account_id
  eventhub_authorization_rule_id = var.diagnostic_settings.eventhub_authorization_rule_id

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
