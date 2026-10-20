#############################################################################
# AI FOUNDRY
#############################################################################
resource "azurerm_ai_foundry" "ai_foundry" {
  name                           = var.ai_foundry_name
  resource_group_name            = var.resource_group_name
  location                       = var.location
  storage_account_id             = var.storage_account_id
  key_vault_id                   = var.key_vault_id
  application_insights_id        = var.application_insights_id
  container_registry_id          = var.container_registry_id
  description                    = var.description
  friendly_name                  = var.friendly_name
  high_business_impact_enabled   = var.high_business_impact_enabled
  primary_user_assigned_identity = var.primary_user_assigned_identity
  public_network_access          = var.public_network_access
  tags                           = var.tags

  identity {
    type         = var.identity["type"]
    identity_ids = try(var.identity["identity_ids"], null)
  }

  dynamic "encryption" {
    for_each = var.encryption != null ? [var.encryption] : []

    content {
      key_id                    = encryption.value["key_id"]
      key_vault_id              = encryption.value["key_vault_id"]
      user_assigned_identity_id = try(encryption.value["user_assigned_identity_id"], null)
    }
  }

  dynamic "managed_network" {
    for_each = var.managed_network != null ? [var.managed_network] : []

    content {
      isolation_mode = try(managed_network.value["isolation_mode"], null)
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
      condition = (
        try(var.identity["type"], null) != "UserAssigned" ||
        (var.encryption == null || try(var.encryption["user_assigned_identity_id"], null) != null)
      )
      error_message = "When identity.type is UserAssigned and encryption is configured, encryption.user_assigned_identity_id must be set."
    }
  }
}
