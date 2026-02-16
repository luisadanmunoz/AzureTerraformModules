################################################################################
# Entra ID Directory Role
# Activates a built-in directory role for use in the tenant
################################################################################

resource "azuread_directory_role" "this" {
  count = var.create ? 1 : 0

  display_name = var.display_name
  template_id  = var.template_id
}
