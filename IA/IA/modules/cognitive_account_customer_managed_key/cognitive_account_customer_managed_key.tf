#############################################################################
# COGNITIVE ACCOUNT CUSTOMER MANAGED KEY
#############################################################################
resource "azurerm_cognitive_account_customer_managed_key" "cognitive_account_customer_managed_key" {
  cognitive_account_id = var.cognitive_account_id
  key_vault_key_id     = var.key_vault_key_id
  identity_client_id   = var.identity_client_id

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
