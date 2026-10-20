#############################################################################
# KEY VAULT KEY
#############################################################################
resource "azurerm_key_vault_key" "key_vault_key" {
  name            = var.key_vault_key_name
  key_vault_id    = var.key_vault_id
  key_type        = var.key_type
  key_size        = var.key_size
  curve           = var.curve
  key_opts        = var.key_opts
  not_before_date = var.not_before_date
  expiration_date = var.expiration_date
  tags            = var.tags

  dynamic "rotation_policy" {
    for_each = var.rotation_policy != null ? [var.rotation_policy] : []

    content {
      expire_after         = try(rotation_policy.value["expire_after"], null)
      notify_before_expiry = try(rotation_policy.value["notify_before_expiry"], null)

      dynamic "automatic" {
        for_each = try(rotation_policy.value["automatic"], null) != null ? [rotation_policy.value["automatic"]] : []

        content {
          time_after_creation = try(automatic.value["time_after_creation"], null)
          time_before_expiry  = try(automatic.value["time_before_expiry"], null)
        }
      }
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
