#############################################################################
# CONTAINER APP ENVIRONMENT CUSTOM DOMAIN
#############################################################################
resource "azurerm_container_app_environment_custom_domain" "container_app_environment_custom_domain" {
  container_app_environment_id = var.container_app_environment_id
  certificate_blob_base64      = var.certificate_blob_base64
  certificate_password         = var.certificate_password
  dns_suffix                   = var.dns_suffix

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
