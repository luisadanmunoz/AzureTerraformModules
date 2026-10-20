################################################################################
# Disk Encryption Set
################################################################################

# DEPENDENCY: Resource Group must exist
# DEPENDENCY: Key Vault Key must exist

resource "azurerm_disk_encryption_set" "this" {
  count = var.create ? 1 : 0

  name                      = local.resource_name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  key_vault_key_id          = var.key_vault_key_id
  encryption_type           = var.encryption_type
  auto_key_rotation_enabled = var.auto_key_rotation_enabled
  federated_client_id       = var.federated_client_id

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
  }

  tags = local.tags
}

################################################################################
# Key Vault Access Policy
################################################################################

# DEPENDENCY: Key Vault must exist (if creating access policy)

resource "azurerm_key_vault_access_policy" "this" {
  count = var.create && var.create_key_vault_access_policy && var.key_vault_id != null ? 1 : 0

  key_vault_id = var.key_vault_id
  tenant_id    = azurerm_disk_encryption_set.this[0].identity[0].tenant_id
  object_id    = azurerm_disk_encryption_set.this[0].identity[0].principal_id

  key_permissions = [
    "Get",
    "WrapKey",
    "UnwrapKey"
  ]
}
