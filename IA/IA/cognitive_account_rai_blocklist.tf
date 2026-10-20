#############################################################################
# COGNITIVE ACCOUNT RAI BLOCKLISTS
#############################################################################
module "cognitive_account_rai_blocklist" {
  source = "./modules/cognitive_account_rai_blocklist"

  for_each = var.cognitive_account_rai_blocklists

  cognitive_account_rai_blocklist_name = each.value["cognitive_account_rai_blocklist_name"]
  cognitive_account_id = try(
    element([for _, cognitive_account in module.cognitive_account : cognitive_account.id if cognitive_account.name == each.value["cognitive_account_name"]], 0),
    each.value["cognitive_account_id"]
  )
  description = try(each.value["description"], null)
  timeouts    = try(each.value["timeouts"], null)
  tags        = try(each.value["tags"], var.tags)
}
