#############################################################################
# CONTAINER APP CUSTOM DOMAIN
#############################################################################
resource "azurerm_container_app_custom_domain" "container_app_custom_domain" {
  name                                     = var.container_app_custom_domain_name
  container_app_id                         = var.container_app_id
  container_app_environment_certificate_id = var.container_app_environment_certificate_id
  certificate_binding_type                 = var.certificate_binding_type

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }

  lifecycle {
    precondition {
      condition = (
        var.container_app_environment_certificate_id == null ||
        var.certificate_binding_type != null
      )
      error_message = "certificate_binding_type is required when container_app_environment_certificate_id is provided."
    }
  }
}
