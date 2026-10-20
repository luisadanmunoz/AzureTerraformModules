#############################################################################
# NETAPP POOLS
#############################################################################
module "netapp_pool" {
  source = "./modules/netapp_pool"

  for_each = var.netapp_pools

  netapp_pool_name = each.value["netapp_pool_name"]
  account_name = try(
    element([for _, netapp_account in module.netapp_account : netapp_account.name if netapp_account.name == each.value["netapp_account_name"]], 0),
    each.value["netapp_account_name"]
  )
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                = each.value["location"]
  service_level           = each.value["service_level"]
  size_in_tb              = each.value["size_in_tb"]
  cool_access_enabled     = try(each.value["cool_access_enabled"], null)
  custom_throughput_mibps = try(each.value["custom_throughput_mibps"], null)
  encryption_type         = try(each.value["encryption_type"], null)
  qos_type                = try(each.value["qos_type"], null)
  timeouts                = try(each.value["timeouts"], null)
  tags                    = try(each.value["tags"], var.tags)
}
