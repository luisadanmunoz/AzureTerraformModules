#############################################################################
# BUDGET
#############################################################################
check "budget_scope_required" {
  assert {
    condition = (
      (var.scope_type == "management_group" && var.management_group_id != null) ||
      (var.scope_type == "subscription" && var.subscription_id != null) ||
      (var.scope_type == "resource_group" && var.resource_group_id != null)
    )
    error_message = "Provide the matching scope id for the selected budget scope_type."
  }
}

resource "azurerm_consumption_budget_management_group" "budget_management_group" {
  count = var.scope_type == "management_group" ? 1 : 0

  name                = var.budget_name
  management_group_id = var.management_group_id
  amount              = var.amount
  time_grain          = var.time_grain

  time_period {
    start_date = var.start_date
    end_date   = var.end_date
  }

  dynamic "notification" {
    for_each = var.notifications

    content {
      enabled        = notification.value.enabled
      operator       = notification.value.operator
      threshold      = notification.value.threshold
      threshold_type = try(notification.value.threshold_type, "Actual")
      contact_emails = try(notification.value.contact_emails, [])
    }
  }
}

resource "azurerm_consumption_budget_subscription" "budget_subscription" {
  count = var.scope_type == "subscription" ? 1 : 0

  name            = var.budget_name
  subscription_id = var.subscription_id
  amount          = var.amount
  time_grain      = var.time_grain

  time_period {
    start_date = var.start_date
    end_date   = var.end_date
  }

  dynamic "notification" {
    for_each = var.notifications

    content {
      enabled        = notification.value.enabled
      operator       = notification.value.operator
      threshold      = notification.value.threshold
      threshold_type = try(notification.value.threshold_type, "Actual")
      contact_emails = try(notification.value.contact_emails, [])
    }
  }
}

resource "azurerm_consumption_budget_resource_group" "budget_resource_group" {
  count = var.scope_type == "resource_group" ? 1 : 0

  name              = var.budget_name
  resource_group_id = var.resource_group_id
  amount            = var.amount
  time_grain        = var.time_grain

  time_period {
    start_date = var.start_date
    end_date   = var.end_date
  }

  dynamic "notification" {
    for_each = var.notifications

    content {
      enabled        = notification.value.enabled
      operator       = notification.value.operator
      threshold      = notification.value.threshold
      threshold_type = try(notification.value.threshold_type, "Actual")
      contact_emails = try(notification.value.contact_emails, [])
    }
  }
}
