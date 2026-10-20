################################################################################
# Azure Policy Assignment - Subscription Scope
################################################################################

resource "azurerm_subscription_policy_assignment" "this" {
  count = var.create && var.scope_type == "subscription" ? 1 : 0

  name                 = var.name
  subscription_id      = local.scope
  policy_definition_id = var.policy_definition_id
  display_name         = var.display_name
  description          = var.description
  enforce              = var.enforce
  parameters           = var.parameters
  metadata             = var.metadata
  not_scopes           = var.not_scopes
  location             = var.location

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "non_compliance_message" {
    for_each = var.non_compliance_messages
    content {
      content                        = non_compliance_message.value.content
      policy_definition_reference_id = non_compliance_message.value.policy_definition_reference_id
    }
  }

  dynamic "resource_selectors" {
    for_each = var.resource_selectors
    content {
      name = resource_selectors.value.name
      dynamic "selectors" {
        for_each = resource_selectors.value.selectors
        content {
          kind   = selectors.value.kind
          in     = selectors.value.in
          not_in = selectors.value.not_in
        }
      }
    }
  }

  dynamic "overrides" {
    for_each = var.overrides
    content {
      value = overrides.value.value
      dynamic "selectors" {
        for_each = overrides.value.selectors
        content {
          kind   = selectors.value.kind
          in     = selectors.value.in
          not_in = selectors.value.not_in
        }
      }
    }
  }
}

################################################################################
# Azure Policy Assignment - Resource Group Scope
################################################################################

resource "azurerm_resource_group_policy_assignment" "this" {
  count = var.create && var.scope_type == "resource_group" ? 1 : 0

  name                 = var.name
  resource_group_id    = local.scope
  policy_definition_id = var.policy_definition_id
  display_name         = var.display_name
  description          = var.description
  enforce              = var.enforce
  parameters           = var.parameters
  metadata             = var.metadata
  not_scopes           = var.not_scopes
  location             = var.location

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "non_compliance_message" {
    for_each = var.non_compliance_messages
    content {
      content                        = non_compliance_message.value.content
      policy_definition_reference_id = non_compliance_message.value.policy_definition_reference_id
    }
  }

  dynamic "resource_selectors" {
    for_each = var.resource_selectors
    content {
      name = resource_selectors.value.name
      dynamic "selectors" {
        for_each = resource_selectors.value.selectors
        content {
          kind   = selectors.value.kind
          in     = selectors.value.in
          not_in = selectors.value.not_in
        }
      }
    }
  }

  dynamic "overrides" {
    for_each = var.overrides
    content {
      value = overrides.value.value
      dynamic "selectors" {
        for_each = overrides.value.selectors
        content {
          kind   = selectors.value.kind
          in     = selectors.value.in
          not_in = selectors.value.not_in
        }
      }
    }
  }
}

################################################################################
# Azure Policy Assignment - Management Group Scope
################################################################################

resource "azurerm_management_group_policy_assignment" "this" {
  count = var.create && var.scope_type == "management_group" ? 1 : 0

  name                 = var.name
  management_group_id  = local.scope
  policy_definition_id = var.policy_definition_id
  display_name         = var.display_name
  description          = var.description
  enforce              = var.enforce
  parameters           = var.parameters
  metadata             = var.metadata
  not_scopes           = var.not_scopes
  location             = var.location

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "non_compliance_message" {
    for_each = var.non_compliance_messages
    content {
      content                        = non_compliance_message.value.content
      policy_definition_reference_id = non_compliance_message.value.policy_definition_reference_id
    }
  }

  dynamic "resource_selectors" {
    for_each = var.resource_selectors
    content {
      name = resource_selectors.value.name
      dynamic "selectors" {
        for_each = resource_selectors.value.selectors
        content {
          kind   = selectors.value.kind
          in     = selectors.value.in
          not_in = selectors.value.not_in
        }
      }
    }
  }

  dynamic "overrides" {
    for_each = var.overrides
    content {
      value = overrides.value.value
      dynamic "selectors" {
        for_each = overrides.value.selectors
        content {
          kind   = selectors.value.kind
          in     = selectors.value.in
          not_in = selectors.value.not_in
        }
      }
    }
  }
}

################################################################################
# Azure Policy Assignment - Resource Scope
################################################################################

resource "azurerm_resource_policy_assignment" "this" {
  count = var.create && var.scope_type == "resource" ? 1 : 0

  name                 = var.name
  resource_id          = local.scope
  policy_definition_id = var.policy_definition_id
  display_name         = var.display_name
  description          = var.description
  enforce              = var.enforce
  parameters           = var.parameters
  metadata             = var.metadata
  not_scopes           = var.not_scopes
  location             = var.location

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "non_compliance_message" {
    for_each = var.non_compliance_messages
    content {
      content                        = non_compliance_message.value.content
      policy_definition_reference_id = non_compliance_message.value.policy_definition_reference_id
    }
  }

  dynamic "resource_selectors" {
    for_each = var.resource_selectors
    content {
      name = resource_selectors.value.name
      dynamic "selectors" {
        for_each = resource_selectors.value.selectors
        content {
          kind   = selectors.value.kind
          in     = selectors.value.in
          not_in = selectors.value.not_in
        }
      }
    }
  }

  dynamic "overrides" {
    for_each = var.overrides
    content {
      value = overrides.value.value
      dynamic "selectors" {
        for_each = overrides.value.selectors
        content {
          kind   = selectors.value.kind
          in     = selectors.value.in
          not_in = selectors.value.not_in
        }
      }
    }
  }
}
