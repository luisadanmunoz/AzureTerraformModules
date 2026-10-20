#############################################################################
# COGNITIVE DEPLOYMENT
#############################################################################
resource "azurerm_cognitive_deployment" "cognitive_deployment" {
  name                       = var.cognitive_deployment_name
  cognitive_account_id       = var.cognitive_account_id
  dynamic_throttling_enabled = var.dynamic_throttling_enabled
  rai_policy_name            = var.rai_policy_name
  version_upgrade_option     = var.version_upgrade_option

  model {
    format  = var.model["format"]
    name    = var.model["name"]
    version = try(var.model["version"], null)
  }

  sku {
    name     = var.sku["name"]
    capacity = try(var.sku["capacity"], null)
    family   = try(var.sku["family"], null)
    size     = try(var.sku["size"], null)
    tier     = try(var.sku["tier"], null)
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
