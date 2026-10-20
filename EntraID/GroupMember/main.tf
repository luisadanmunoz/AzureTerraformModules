################################################################################
# Entra ID Group Member
################################################################################

resource "azuread_group_member" "this" {
  count = var.create ? 1 : 0

  group_object_id  = var.group_object_id
  member_object_id = var.member_object_id
}
