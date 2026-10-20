#############################################################################
# MANAGEMENT GROUPS
#############################################################################
module "management_group" {
  source = "./modules/management_group"

  for_each = var.management_groups

  management_group_name = each.value["management_group_name"]
  display_name          = each.value["display_name"]
  parent_management_group_id = try(
    "/providers/Microsoft.Management/managementGroups/${element([for _, management_group in var.management_groups : management_group.management_group_name if management_group.management_group_name == each.value["parent_management_group_name"]], 0)}",
    each.value["parent_management_group_id"],
    null
  )
  subscription_ids = try(each.value["subscription_ids"], [])
}
