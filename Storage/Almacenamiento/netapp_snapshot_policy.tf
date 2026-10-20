#############################################################################
# NETAPP SNAPSHOT POLICIES
#############################################################################
module "netapp_snapshot_policy" {
  source = "./modules/netapp_snapshot_policy"

  for_each = var.netapp_snapshot_policies

  netapp_snapshot_policy_name = each.value["netapp_snapshot_policy_name"]
  account_name = try(
    element([for _, netapp_account in module.netapp_account : netapp_account.name if netapp_account.name == each.value["netapp_account_name"]], 0),
    each.value["netapp_account_name"]
  )
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location         = each.value["location"]
  enabled          = each.value["enabled"]
  hourly_schedule  = try(each.value["hourly_schedule"], null)
  daily_schedule   = try(each.value["daily_schedule"], null)
  weekly_schedule  = try(each.value["weekly_schedule"], null)
  monthly_schedule = try(each.value["monthly_schedule"], null)
  timeouts         = try(each.value["timeouts"], null)
  tags             = try(each.value["tags"], var.tags)
}
