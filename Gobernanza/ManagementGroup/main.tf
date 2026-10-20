################################################################################
# Azure Management Group
################################################################################

resource "azurerm_management_group" "this" {
  count = var.create ? 1 : 0

  name                       = var.name
  display_name               = var.display_name
  parent_management_group_id = var.parent_management_group_id
  subscription_ids           = var.subscription_ids
}
