#############################################################################
# RESOURCE LOCK
#############################################################################
resource "azurerm_management_lock" "resource_lock" {
  name       = var.lock_name
  scope      = var.scope
  lock_level = var.lock_level
  notes      = var.notes
}
