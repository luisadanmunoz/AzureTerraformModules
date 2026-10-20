#############################################################################
# MANAGEMENT GROUP
#############################################################################
resource "azurerm_management_group" "management_group" {
  name                       = var.management_group_name
  display_name               = var.display_name
  parent_management_group_id = var.parent_management_group_id
  subscription_ids           = var.subscription_ids
}
