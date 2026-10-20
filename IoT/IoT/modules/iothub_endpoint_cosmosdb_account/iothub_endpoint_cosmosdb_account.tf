#############################################################################
# IOT HUB ENDPOINT COSMOSDB ACCOUNT
#############################################################################
resource "azurerm_iothub_endpoint_cosmosdb_account" "iothub_endpoint_cosmosdb_account" {
  name                   = var.iothub_endpoint_cosmosdb_account_name
  resource_group_name    = var.resource_group_name
  iothub_id              = var.iothub_id
  container_name         = var.container_name
  database_name          = var.database_name
  endpoint_uri           = var.endpoint_uri
  authentication_type    = var.authentication_type
  identity_id            = var.identity_id
  partition_key_name     = var.partition_key_name
  partition_key_template = var.partition_key_template
  primary_key            = var.primary_key
  secondary_key          = var.secondary_key
  subscription_id        = var.subscription_id

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
        (var.primary_key == null && var.secondary_key == null)
      )
      error_message = "primary_key and secondary_key must be null when authentication_type is identityBased."
    }

    precondition {
      condition = (
        coalesce(var.authentication_type, "keyBased") == "identityBased" ||
        (var.primary_key != null || var.secondary_key != null)
      )
      error_message = "primary_key or secondary_key is required when authentication_type is keyBased."
    }
  }
}
