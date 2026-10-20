#############################################################################
# IOT HUBS
#############################################################################
module "iothub" {
  source = "./modules/iothub"

  for_each = var.iothubs

  iothub_name = each.value["iothub_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                      = each.value["location"]
  event_hub_partition_count     = try(each.value["event_hub_partition_count"], null)
  event_hub_retention_in_days   = try(each.value["event_hub_retention_in_days"], null)
  local_authentication_enabled  = try(each.value["local_authentication_enabled"], null)
  min_tls_version               = try(each.value["min_tls_version"], null)
  public_network_access_enabled = try(each.value["public_network_access_enabled"], null)
  cloud_to_device               = try(each.value["cloud_to_device"], null)
  identity                      = try(each.value["identity"], null)
  network_rule_set              = try(each.value["network_rule_set"], null)
  sku                           = each.value["sku"]
  timeouts                      = try(each.value["timeouts"], null)
  tags                          = try(each.value["tags"], var.tags)
}
