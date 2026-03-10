################################################################################
# Azure Management Lock - Resource Group Scope
################################################################################

resource "azurerm_management_lock" "resource_group" {
  count = var.create && var.scope_type == "resource_group" ? 1 : 0

  name       = var.name
  scope      = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.resource_group_name}"
  lock_level = var.lock_level
  notes      = var.notes
}

################################################################################
# Azure Management Lock - Resource Scope
################################################################################

resource "azurerm_management_lock" "resource" {
  count = var.create && var.scope_type == "resource" ? 1 : 0

  name       = var.name
  scope      = var.scope
  lock_level = var.lock_level
  notes      = var.notes
}

################################################################################
# Azure Management Lock - Subscription Scope
################################################################################

resource "azurerm_management_lock" "subscription" {
  count = var.create && var.scope_type == "subscription" ? 1 : 0

  name       = var.name
  scope      = var.subscription_id != null ? var.subscription_id : data.azurerm_subscription.current.id
  lock_level = var.lock_level
  notes      = var.notes
}

################################################################################
# Data Sources
################################################################################

data "azurerm_subscription" "current" {}
