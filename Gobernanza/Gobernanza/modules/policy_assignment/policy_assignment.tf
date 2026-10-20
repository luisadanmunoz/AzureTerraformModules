#############################################################################
# POLICY ASSIGNMENT
#############################################################################
resource "azurerm_management_group_policy_assignment" "policy_assignment_management_group" {
  count = var.scope_type == "management_group" ? 1 : 0

  name                 = var.policy_assignment_name
  display_name         = var.display_name
  description          = var.description
  policy_definition_id = var.policy_definition_id
  management_group_id  = var.scope_id
  location             = var.location
  not_scopes           = var.not_scopes
  enforce              = var.enforce
  metadata             = var.metadata == null ? null : jsonencode(var.metadata)
  parameters           = var.parameters == null ? null : jsonencode(var.parameters)

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []

    content {
      type         = var.identity_type
      identity_ids = length(var.identity_ids) > 0 ? var.identity_ids : null
    }
  }
}

resource "azurerm_subscription_policy_assignment" "policy_assignment_subscription" {
  count = var.scope_type == "subscription" ? 1 : 0

  name                 = var.policy_assignment_name
  display_name         = var.display_name
  description          = var.description
  policy_definition_id = var.policy_definition_id
  subscription_id      = var.scope_id
  location             = var.location
  not_scopes           = var.not_scopes
  enforce              = var.enforce
  metadata             = var.metadata == null ? null : jsonencode(var.metadata)
  parameters           = var.parameters == null ? null : jsonencode(var.parameters)

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []

    content {
      type         = var.identity_type
      identity_ids = length(var.identity_ids) > 0 ? var.identity_ids : null
    }
  }
}

resource "azurerm_resource_group_policy_assignment" "policy_assignment_resource_group" {
  count = var.scope_type == "resource_group" ? 1 : 0

  name                 = var.policy_assignment_name
  display_name         = var.display_name
  description          = var.description
  policy_definition_id = var.policy_definition_id
  resource_group_id    = var.scope_id
  location             = var.location
  not_scopes           = var.not_scopes
  enforce              = var.enforce
  metadata             = var.metadata == null ? null : jsonencode(var.metadata)
  parameters           = var.parameters == null ? null : jsonencode(var.parameters)

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []

    content {
      type         = var.identity_type
      identity_ids = length(var.identity_ids) > 0 ? var.identity_ids : null
    }
  }
}

resource "azurerm_resource_policy_assignment" "policy_assignment_resource" {
  count = var.scope_type == "resource" ? 1 : 0

  name                 = var.policy_assignment_name
  display_name         = var.display_name
  description          = var.description
  policy_definition_id = var.policy_definition_id
  resource_id          = var.scope_id
  location             = var.location
  not_scopes           = var.not_scopes
  enforce              = var.enforce
  metadata             = var.metadata == null ? null : jsonencode(var.metadata)
  parameters           = var.parameters == null ? null : jsonencode(var.parameters)

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []

    content {
      type         = var.identity_type
      identity_ids = length(var.identity_ids) > 0 ? var.identity_ids : null
    }
  }
}
