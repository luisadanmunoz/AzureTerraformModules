#############################################################################
# IOT HUB ENDPOINT STORAGE CONTAINER
#############################################################################
resource "azurerm_iothub_endpoint_storage_container" "iothub_endpoint_storage_container" {
  name                       = var.iothub_endpoint_storage_container_name
  resource_group_name        = var.resource_group_name
  container_name             = var.container_name
  iothub_id                  = var.iothub_id
  authentication_type        = var.authentication_type
  connection_string          = var.connection_string
  endpoint_uri               = var.endpoint_uri
  identity_id                = var.identity_id
  batch_frequency_in_seconds = var.batch_frequency_in_seconds
  encoding                   = var.encoding
  file_name_format           = var.file_name_format
  max_chunk_size_in_bytes    = var.max_chunk_size_in_bytes
  subscription_id            = var.subscription_id

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
        var.endpoint_uri != null
      )
      error_message = "endpoint_uri is required when authentication_type is identityBased."
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
