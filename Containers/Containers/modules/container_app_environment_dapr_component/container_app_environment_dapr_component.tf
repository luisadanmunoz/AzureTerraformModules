#############################################################################
# CONTAINER APP ENVIRONMENT DAPR COMPONENT
#############################################################################
resource "azurerm_container_app_environment_dapr_component" "container_app_environment_dapr_component" {
  name                         = var.container_app_environment_dapr_component_name
  container_app_environment_id = var.container_app_environment_id
  component_type               = var.component_type
  version                      = var.component_version
  ignore_errors                = var.ignore_errors
  init_timeout                 = var.init_timeout
  scopes                       = var.scopes

  dynamic "metadata" {
    for_each = var.metadata != null ? var.metadata : []

    content {
      name        = metadata.value["name"]
      secret_name = try(metadata.value["secret_name"], null)
      value       = try(metadata.value["value"], null)
    }
  }

  dynamic "secret" {
    for_each = var.secret != null ? var.secret : []

    content {
      name                = secret.value["name"]
      value               = try(secret.value["value"], null)
      identity            = try(secret.value["identity"], null)
      key_vault_secret_id = try(secret.value["key_vault_secret_id"], null)
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
