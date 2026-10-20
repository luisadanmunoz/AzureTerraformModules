#############################################################################
# KEY VAULT SECRET
#############################################################################
resource "azurerm_key_vault_secret" "key_vault_secret" {
  name             = var.key_vault_secret_name
  key_vault_id     = var.key_vault_id
  value            = var.value
  value_wo         = var.value_wo
  value_wo_version = var.value_wo_version
  content_type     = var.content_type
  not_before_date  = var.not_before_date
  expiration_date  = var.expiration_date
  tags             = var.tags

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
        (var.value != null && var.value_wo == null) ||
        (var.value == null && var.value_wo != null)
      )
      error_message = "Exactly one of value or value_wo must be specified."
    }

    precondition {
      condition     = var.value_wo == null || var.value_wo_version != null
      error_message = "value_wo_version must be specified when value_wo is used."
    }
  }
}
