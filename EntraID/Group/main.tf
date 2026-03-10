################################################################################
# Entra ID Group
################################################################################

resource "azuread_group" "this" {
  count = var.create ? 1 : 0

  display_name     = var.display_name
  description      = var.description
  security_enabled = var.security_enabled
  mail_enabled     = var.mail_enabled
  mail_nickname    = var.mail_nickname
  types            = var.types

  assignable_to_role      = var.assignable_to_role
  behaviors               = var.behaviors
  owners                  = var.owners
  members                 = var.members
  prevent_duplicate_names = var.prevent_duplicate_names
  visibility              = var.visibility

  external_senders_allowed   = var.external_senders_allowed
  auto_subscribe_new_members = var.auto_subscribe_new_members
  hide_from_address_lists    = var.hide_from_address_lists
  hide_from_outlook_clients  = var.hide_from_outlook_clients

  onpremises_group_type = var.onpremises_group_type
  writeback_enabled     = var.writeback_enabled

  provisioning_options = var.provisioning_options
  theme                = var.theme

  dynamic "dynamic_membership" {
    for_each = var.dynamic_membership != null ? [var.dynamic_membership] : []
    content {
      enabled = dynamic_membership.value.enabled
      rule    = dynamic_membership.value.rule
    }
  }
}
