################################################################################
# Local Values
################################################################################

locals {
  # Determine scope based on scope_type
  scope = (
    var.scope_type == "management_group" ? var.management_group_id :
    var.scope_type == "resource_group" ? var.resource_group_id :
    var.scope_type == "resource" ? var.resource_id :
    var.subscription_id != null ? var.subscription_id : data.azurerm_subscription.current.id
  )
}

data "azurerm_subscription" "current" {}
