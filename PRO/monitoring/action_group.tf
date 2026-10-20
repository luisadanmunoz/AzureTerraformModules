#############################################################################
# ACTION GROUP ACTION OUTPUT
#############################################################################
module "action_group" {
  source = "./modules/action_group"

  for_each = var.action_group

  name           = each.value["name"]
  resource_group = each.value["resource_group_name"]
  short_name     = each.value["short_name"]
  name_webhook   = each.value["name_webhook"]
  uri            = each.value["uri"]
  name_email     = each.value["name_email"]
  email          = each.value["email"]
  name_email2    = each.value["name_email2"]
  email2         = each.value["email2"]


}