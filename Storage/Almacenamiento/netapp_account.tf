#############################################################################
# NETAPP ACCOUNTS
#############################################################################
module "netapp_account" {
  source = "./modules/netapp_account"

  for_each = var.netapp_accounts

  netapp_account_name = each.value["netapp_account_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location         = each.value["location"]
  active_directory = try(each.value["active_directory"], null)
  identity         = try(each.value["identity"], null)
  timeouts         = try(each.value["timeouts"], null)
  tags             = try(each.value["tags"], var.tags)
}
