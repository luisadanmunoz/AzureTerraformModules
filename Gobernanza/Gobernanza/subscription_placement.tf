#############################################################################
# SUBSCRIPTIONS PLACEMENTS
#############################################################################
module "subscription_placement" {
  source = "./modules/subscription_placement"

  for_each = var.subscription_placements

  management_group_id = try(
    element([for _, management_group in module.management_group : management_group.id if management_group.name == each.value["management_group_name"]], 0),
    each.value["management_group_id"]
  )
  subscription_id = each.value["subscription_id"]
}
