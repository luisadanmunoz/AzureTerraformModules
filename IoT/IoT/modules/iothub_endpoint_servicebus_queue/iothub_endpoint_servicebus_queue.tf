#############################################################################
# IOT HUB ENDPOINT SERVICEBUS QUEUE
#############################################################################
resource "azurerm_iothub_endpoint_servicebus_queue" "iothub_endpoint_servicebus_queue" {
  name                = var.iothub_endpoint_servicebus_queue_name
  resource_group_name = var.resource_group_name
  iothub_id           = var.iothub_id
  authentication_type = var.authentication_type
  connection_string   = var.connection_string
  endpoint_uri        = var.endpoint_uri
  entity_path         = var.entity_path
  identity_id         = var.identity_id
  subscription_id     = var.subscription_id

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }

  lifecycle {
    precondition {
      condition = (
        coalesce(var.authentication_type, "keyBased") != "identityBased" ||
        (var.endpoint_uri != null && var.entity_path != null)
      )
      error_message = "endpoint_uri and entity_path are required when authentication_type is identityBased."
    }

    precondition {
      condition = (
        coalesce(var.authentication_type, "keyBased") == "identityBased" ||
        var.connection_string != null
      )
      error_message = "connection_string is required when authentication_type is keyBased."
    }
  }
}
