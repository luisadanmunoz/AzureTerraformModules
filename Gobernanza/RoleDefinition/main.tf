################################################################################
# Azure Custom Role Definition
################################################################################

resource "azurerm_role_definition" "this" {
  count = var.create ? 1 : 0

  name        = var.name
  scope       = var.scope
  description = var.description

  dynamic "permissions" {
    for_each = var.permissions
    content {
      actions          = permissions.value.actions
      not_actions      = permissions.value.not_actions
      data_actions     = permissions.value.data_actions
      not_data_actions = permissions.value.not_data_actions
    }
  }

  assignable_scopes = local.assignable_scopes
}
