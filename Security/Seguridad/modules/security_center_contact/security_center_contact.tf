#############################################################################
# SECURITY CENTER CONTACT
#############################################################################
resource "azurerm_security_center_contact" "security_center_contact" {
  name                = var.security_center_contact_name
  email               = var.email
  alert_notifications = var.alert_notifications
  alerts_to_admins    = var.alerts_to_admins
  phone               = var.phone

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
