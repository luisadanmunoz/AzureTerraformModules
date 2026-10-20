#############################################################################
# IOT HUB DPS
#############################################################################
module "iothub_dps" {
  source = "./modules/iothub_dps"

  for_each = var.iothub_dpss

  iothub_dps_name = each.value["iothub_dps_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                      = each.value["location"]
  allocation_policy             = try(each.value["allocation_policy"], null)
  data_residency_enabled        = try(each.value["data_residency_enabled"], null)
  public_network_access_enabled = try(each.value["public_network_access_enabled"], null)
  ip_filter_rule                = try(each.value["ip_filter_rule"], null)
  linked_hub                    = try(each.value["linked_hub"], null)
  sku                           = each.value["sku"]
  timeouts                      = try(each.value["timeouts"], null)
  tags                          = try(each.value["tags"], var.tags)
}
