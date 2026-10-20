#############################################################################
# BUDGETS
#############################################################################
module "budget" {
  source = "./modules/budget"

  for_each = var.budgets

  budget_name = each.value["budget_name"]
  scope_type  = each.value["scope_type"]
  amount      = each.value["amount"]
  time_grain  = each.value["time_grain"]
  start_date  = each.value["start_date"]
  end_date    = try(each.value["end_date"], null)
  management_group_id = try(
    element([for _, management_group in module.management_group : management_group.id if management_group.name == each.value["management_group_name"]], 0),
    each.value["management_group_id"],
    null
  )
  subscription_id = try(each.value["subscription_id"], null)
  resource_group_id = try(
    element([for _, resource_group in module.rg : resource_group.id if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_id"],
    null
  )
  notifications = coalesce(try(each.value["notifications"], null), {})
}
