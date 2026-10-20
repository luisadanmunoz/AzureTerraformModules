#############################################################################
# SECURITY CENTER SUBSCRIPTION PRICING
#############################################################################
resource "azurerm_security_center_subscription_pricing" "security_center_subscription_pricing" {
  tier          = var.tier
  resource_type = var.resource_type
  subplan       = var.subplan

  dynamic "extension" {
    for_each = var.extensions

    content {
      name                            = extension.value["name"]
      additional_extension_properties = try(extension.value["additional_extension_properties"], null)
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
