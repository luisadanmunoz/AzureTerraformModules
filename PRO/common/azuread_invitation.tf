#############################################################################
# MODULE AZUREAD INVITATION
#############################################################################

module "azuread_invitation" {
  source = "./modules/azuread_invitation"

  for_each = var.azuread_invitation

  user_display_name   = each.value["user_display_name"]
  user_email_address  = each.value["user_email_address"]
  user_principal_name = each.value["user_principal_name"]
  group_object_id     = element([for k, v in module.azuread_group : v.id if v.display_name == each.value["group"]], 0)

}