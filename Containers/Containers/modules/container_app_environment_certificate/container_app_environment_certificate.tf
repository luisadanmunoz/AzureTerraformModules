#############################################################################
# CONTAINER APP ENVIRONMENT CERTIFICATE
#############################################################################
resource "azurerm_container_app_environment_certificate" "container_app_environment_certificate" {
  name                         = var.container_app_environment_certificate_name
  container_app_environment_id = var.container_app_environment_id
  certificate_blob_base64      = var.certificate_blob_base64
  certificate_password         = var.certificate_password
  tags                         = var.tags

  dynamic "certificate_key_vault" {
    for_each = var.certificate_key_vault != null ? [var.certificate_key_vault] : []

    content {
      identity            = try(certificate_key_vault.value["identity"], null)
      key_vault_secret_id = certificate_key_vault.value["key_vault_secret_id"]
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

  lifecycle {
    precondition {
      condition     = (var.certificate_blob_base64 != null) != (var.certificate_key_vault != null)
      error_message = "Exactly one of certificate_blob_base64 or certificate_key_vault must be provided."
    }

    precondition {
      condition = (
        var.certificate_blob_base64 == null ||
        var.certificate_password != null
      )
      error_message = "certificate_password is required when certificate_blob_base64 is provided."
    }
  }
}
