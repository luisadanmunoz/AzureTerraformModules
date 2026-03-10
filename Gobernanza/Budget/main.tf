################################################################################
# Azure Consumption Budget - Subscription
################################################################################

resource "azurerm_consumption_budget_subscription" "this" {
  count = var.create && var.scope_type == "subscription" ? 1 : 0

  name            = var.name
  subscription_id = local.scope
  amount          = var.amount
  time_grain      = var.time_grain

  time_period {
    start_date = var.time_period.start_date
    end_date   = var.time_period.end_date
  }

  dynamic "notification" {
    for_each = var.notifications
    content {
      enabled        = notification.value.enabled
      threshold      = notification.value.threshold
      threshold_type = notification.value.threshold_type
      operator       = notification.value.operator
      contact_emails = notification.value.contact_emails
      contact_groups = notification.value.contact_groups
      contact_roles  = notification.value.contact_roles
    }
  }

  dynamic "filter" {
    for_each = var.filter != null ? [var.filter] : []
    content {
      dynamic "dimension" {
        for_each = filter.value.dimensions
        content {
          name   = dimension.value.name
          values = dimension.value.values
        }
      }
      dynamic "tag" {
        for_each = filter.value.tags
        content {
          name   = tag.value.name
          values = tag.value.values
        }
      }
    }
  }
}

################################################################################
# Azure Consumption Budget - Resource Group
################################################################################

resource "azurerm_consumption_budget_resource_group" "this" {
  count = var.create && var.scope_type == "resource_group" ? 1 : 0

  name              = var.name
  resource_group_id = local.scope
  amount            = var.amount
  time_grain        = var.time_grain

  time_period {
    start_date = var.time_period.start_date
    end_date   = var.time_period.end_date
  }

  dynamic "notification" {
    for_each = var.notifications
    content {
      enabled        = notification.value.enabled
      threshold      = notification.value.threshold
      threshold_type = notification.value.threshold_type
      operator       = notification.value.operator
      contact_emails = notification.value.contact_emails
      contact_groups = notification.value.contact_groups
      contact_roles  = notification.value.contact_roles
    }
  }

  dynamic "filter" {
    for_each = var.filter != null ? [var.filter] : []
    content {
      dynamic "dimension" {
        for_each = filter.value.dimensions
        content {
          name   = dimension.value.name
          values = dimension.value.values
        }
      }
      dynamic "tag" {
        for_each = filter.value.tags
        content {
          name   = tag.value.name
          values = tag.value.values
        }
      }
    }
  }
}

################################################################################
# Azure Consumption Budget - Management Group
################################################################################

resource "azurerm_consumption_budget_management_group" "this" {
  count = var.create && var.scope_type == "management_group" ? 1 : 0

  name                = var.name
  management_group_id = local.scope
  amount              = var.amount
  time_grain          = var.time_grain

  time_period {
    start_date = var.time_period.start_date
    end_date   = var.time_period.end_date
  }

  dynamic "notification" {
    for_each = var.notifications
    content {
      enabled        = notification.value.enabled
      threshold      = notification.value.threshold
      threshold_type = notification.value.threshold_type
      operator       = notification.value.operator
      contact_emails = notification.value.contact_emails
      contact_groups = notification.value.contact_groups
      contact_roles  = notification.value.contact_roles
    }
  }

  dynamic "filter" {
    for_each = var.filter != null ? [var.filter] : []
    content {
      dynamic "dimension" {
        for_each = filter.value.dimensions
        content {
          name   = dimension.value.name
          values = dimension.value.values
        }
      }
      dynamic "tag" {
        for_each = filter.value.tags
        content {
          name   = tag.value.name
          values = tag.value.values
        }
      }
    }
  }
}
