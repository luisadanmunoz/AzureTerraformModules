#############################################################################
# IOT HUB CONSUMER GROUPS
#############################################################################
module "iothub_consumer_group" {
  source = "./modules/iothub_consumer_group"

  for_each = var.iothub_consumer_groups

  iothub_consumer_group_name = each.value["iothub_consumer_group_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  iothub_name = try(
    element([for _, iothub in module.iothub : iothub.name if iothub.name == each.value["iothub_name"]], 0),
    each.value["iothub_name"]
  )
  eventhub_endpoint_name = each.value["eventhub_endpoint_name"]
  timeouts               = try(each.value["timeouts"], null)
}
