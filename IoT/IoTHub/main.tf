################################################################################
# Azure IoT Hub
################################################################################

resource "azurerm_iothub" "this" {
  count = var.create ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = var.sku_name
    capacity = var.sku_capacity
  }

  event_hub_partition_count     = var.event_hub_partition_count
  event_hub_retention_in_days   = var.event_hub_retention_in_days
  public_network_access_enabled = var.public_network_access_enabled
  min_tls_version               = var.min_tls_version
  local_authentication_enabled  = var.local_authentication_enabled

  dynamic "cloud_to_device" {
    for_each = var.cloud_to_device != null ? [var.cloud_to_device] : []
    content {
      max_delivery_count = cloud_to_device.value.max_delivery_count
      default_ttl        = cloud_to_device.value.default_ttl

      dynamic "feedback" {
        for_each = cloud_to_device.value.feedback != null ? [cloud_to_device.value.feedback] : []
        content {
          time_to_live       = feedback.value.time_to_live
          max_delivery_count = feedback.value.max_delivery_count
          lock_duration      = feedback.value.lock_duration
        }
      }
    }
  }

  dynamic "file_upload" {
    for_each = var.file_upload != null ? [var.file_upload] : []
    content {
      connection_string   = file_upload.value.connection_string
      container_name      = file_upload.value.container_name
      sas_ttl             = file_upload.value.sas_ttl
      notifications       = file_upload.value.notifications
      lock_duration       = file_upload.value.lock_duration
      default_ttl         = file_upload.value.default_ttl
      max_delivery_count  = file_upload.value.max_delivery_count
      authentication_type = file_upload.value.authentication_type
      identity_id         = file_upload.value.identity_id
    }
  }

  dynamic "network_rule_set" {
    for_each = var.network_rule_sets
    content {
      default_action                     = network_rule_set.value.default_action
      apply_to_builtin_eventhub_endpoint = network_rule_set.value.apply_to_builtin_eventhub_endpoint

      dynamic "ip_rule" {
        for_each = network_rule_set.value.ip_rules
        content {
          name    = ip_rule.value.name
          ip_mask = ip_rule.value.ip_mask
          action  = ip_rule.value.action
        }
      }
    }
  }

  dynamic "endpoint" {
    for_each = var.endpoints
    content {
      type                       = endpoint.value.type
      name                       = endpoint.value.name
      authentication_type        = endpoint.value.authentication_type
      identity_id                = endpoint.value.identity_id
      endpoint_uri               = endpoint.value.endpoint_uri
      entity_path                = endpoint.value.entity_path
      connection_string          = endpoint.value.connection_string
      batch_frequency_in_seconds = endpoint.value.batch_frequency_in_seconds
      max_chunk_size_in_bytes    = endpoint.value.max_chunk_size_in_bytes
      container_name             = endpoint.value.container_name
      encoding                   = endpoint.value.encoding
      file_name_format           = endpoint.value.file_name_format
      resource_group_name        = endpoint.value.resource_group_name
    }
  }

  dynamic "route" {
    for_each = var.routes
    content {
      name           = route.value.name
      source         = route.value.source
      condition      = route.value.condition
      endpoint_names = route.value.endpoint_names
      enabled        = route.value.enabled
    }
  }

  dynamic "fallback_route" {
    for_each = var.fallback_route != null ? [var.fallback_route] : []
    content {
      source         = fallback_route.value.source
      condition      = fallback_route.value.condition
      endpoint_names = fallback_route.value.endpoint_names
      enabled        = fallback_route.value.enabled
    }
  }

  dynamic "enrichment" {
    for_each = var.enrichments
    content {
      key            = enrichment.value.key
      value          = enrichment.value.value
      endpoint_names = enrichment.value.endpoint_names
    }
  }

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_ids
    }
  }

  tags = local.tags
}
