#############################################################################
# AI FOUNDRY PROJECT
#############################################################################
resource "azurerm_ai_foundry_project" "ai_foundry_project" {
  name                           = var.ai_foundry_project_name
  location                       = var.location
  ai_services_hub_id             = var.ai_services_hub_id
  description                    = var.description
  friendly_name                  = var.friendly_name
  high_business_impact_enabled   = var.high_business_impact_enabled
  primary_user_assigned_identity = var.primary_user_assigned_identity
  tags                           = var.tags

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = try(identity.value["identity_ids"], null)
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
