#############################################################################
# COGNITIVE ACCOUNT RAI POLICIES
#############################################################################
module "cognitive_account_rai_policy" {
  source = "./modules/cognitive_account_rai_policy"

  for_each = var.cognitive_account_rai_policies

  cognitive_account_rai_policy_name = each.value["cognitive_account_rai_policy_name"]
  cognitive_account_id = try(
    element([for _, cognitive_account in module.cognitive_account : cognitive_account.id if cognitive_account.name == each.value["cognitive_account_name"]], 0),
    each.value["cognitive_account_id"]
  )
  base_policy_name = each.value["base_policy_name"]
  mode             = try(each.value["mode"], null)
  content_filter   = each.value["content_filter"]
  timeouts         = try(each.value["timeouts"], null)
  tags             = try(each.value["tags"], var.tags)
}
