#############################################################################
# MONITOR ACTION GROUPS
#############################################################################
module "monitor_action_group" {
  source = "./modules/monitor_action_group"

  for_each = var.monitor_action_groups

  action_group_name = each.value["action_group_name"]
  short_name        = each.value["short_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  enabled            = try(each.value["enabled"], true)
  email_receivers    = try(each.value["email_receivers"], [])
  webhook_receivers  = try(each.value["webhook_receivers"], [])
  arm_role_receivers = try(each.value["arm_role_receivers"], [])
  tags               = var.tags
}
