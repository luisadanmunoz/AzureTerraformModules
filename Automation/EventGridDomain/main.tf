# -----------------------------------------------------------------------------
# Azure Event Grid Domain
# -----------------------------------------------------------------------------
resource "azurerm_eventgrid_domain" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  location            = var.location
  resource_group_name = var.resource_group_name

  input_schema                              = var.input_schema
  public_network_access_enabled             = var.public_network_access_enabled
  local_auth_enabled                        = var.local_auth_enabled
  auto_create_topic_with_first_subscription = var.auto_create_topic_with_first_subscription
  auto_delete_topic_with_last_subscription  = var.auto_delete_topic_with_last_subscription

  # Input mapping fields for CustomEventSchema
  dynamic "input_mapping_fields" {
    for_each = var.input_mapping_fields != null ? [var.input_mapping_fields] : []
    content {
      id           = input_mapping_fields.value.id
      topic        = input_mapping_fields.value.topic
      event_type   = input_mapping_fields.value.event_type
      event_time   = input_mapping_fields.value.event_time
      data_version = input_mapping_fields.value.data_version
      subject      = input_mapping_fields.value.subject
    }
  }

  # Input mapping default values for CustomEventSchema
  dynamic "input_mapping_default_values" {
    for_each = var.input_mapping_default_values != null ? [var.input_mapping_default_values] : []
    content {
      event_type   = input_mapping_default_values.value.event_type
      data_version = input_mapping_default_values.value.data_version
      subject      = input_mapping_default_values.value.subject
    }
  }

  # Inbound IP rules for network access control
  dynamic "inbound_ip_rule" {
    for_each = var.inbound_ip_rule
    content {
      ip_mask = inbound_ip_rule.value.ip_mask
      action  = inbound_ip_rule.value.action
    }
  }

  # Managed identity configuration
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  tags = local.tags
}

# -----------------------------------------------------------------------------
# Azure Event Grid Domain Topics
# DEPENDENCY: The Event Grid Domain must be created before domain topics.
# -----------------------------------------------------------------------------
resource "azurerm_eventgrid_domain_topic" "this" {
  for_each = var.create ? var.domain_topics : {}

  name                = each.value.name
  domain_name         = azurerm_eventgrid_domain.this[0].name
  resource_group_name = var.resource_group_name
}
