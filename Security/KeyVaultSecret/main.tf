################################################################################
# Azure Key Vault Secret
################################################################################

resource "azurerm_key_vault_secret" "this" {
  count = var.create ? 1 : 0

  name            = var.name
  key_vault_id    = var.key_vault_id
  value           = var.value
  content_type    = var.content_type
  not_before_date = var.not_before_date
  expiration_date = var.expiration_date
  tags            = local.tags
}
