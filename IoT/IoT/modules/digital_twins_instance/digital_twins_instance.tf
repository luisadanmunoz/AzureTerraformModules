#############################################################################
# DIGITAL TWINS INSTANCE
#############################################################################
resource "azurerm_digital_twins_instance" "digital_twins_instance" {
  name                = var.digital_twins_instance_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

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

  lifecycle {
    precondition {
      condition = (
        var.identity == null ||
        can(regex("UserAssigned", var.identity["type"])) == false ||
        try(length(var.identity["identity_ids"]) > 0, false)
      )
      error_message = "identity_ids is required when identity.type includes UserAssigned."
    }
  }
}
