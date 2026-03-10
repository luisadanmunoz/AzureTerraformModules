################################################################################
# Entra ID Directory Role Assignment
################################################################################

resource "azuread_directory_role_assignment" "this" {
  count = var.create ? 1 : 0

  role_id             = var.role_id
  principal_object_id = var.principal_object_id

  app_scope_id       = var.app_scope_id
  directory_scope_id = var.directory_scope_id
}
