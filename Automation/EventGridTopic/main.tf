# ==============================================================================
# Azure Event Grid Topic
# ==============================================================================

resource "azurerm_eventgrid_topic" "this" {
  count = var.create ? 1 : 0

  name                          = local.resource_name
  resource_group_name           = var.resource_group_name # DEPENDENCY: azurerm_resource_group
  location                      = var.location
  input_schema                  = var.input_schema
  public_network_access_enabled = var.public_network_access_enabled
  local_auth_enabled            = var.local_auth_enabled

  tags = local.tags

  # Dynamic block for input mapping fields (only for CustomEventSchema)
  dynamic "input_mapping_fields" {
    for_each = var.input_mapping_fields != null ? [var.input_mapping_fields] : []

    content {
      id           = input_mapping_fields.value.id
      topic        = input_mapping_fields.value.topic
      event_time   = input_mapping_fields.value.event_time
      event_type   = input_mapping_fields.value.event_type
      subject      = input_mapping_fields.value.subject
      data_version = input_mapping_fields.value.data_version
    }
  }

  # Dynamic block for input mapping default values (only for CustomEventSchema)
  dynamic "input_mapping_default_values" {
    for_each = var.input_mapping_default_values != null ? [var.input_mapping_default_values] : []

    content {
      event_type   = input_mapping_default_values.value.event_type
      subject      = input_mapping_default_values.value.subject
      data_version = input_mapping_default_values.value.data_version
    }
  }

  # Dynamic block for inbound IP rules
  dynamic "inbound_ip_rule" {
    for_each = var.inbound_ip_rule

    content {
      ip_mask = inbound_ip_rule.value.ip_mask
      action  = inbound_ip_rule.value.action
    }
  }

  # Dynamic block for identity
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
}
