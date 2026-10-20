#############################################################################
# IOT HUB ENDPOINT SERVICEBUS QUEUES
#############################################################################
module "iothub_endpoint_servicebus_queue" {
  source = "./modules/iothub_endpoint_servicebus_queue"

  for_each = var.iothub_endpoint_servicebus_queues

  iothub_endpoint_servicebus_queue_name = each.value["iothub_endpoint_servicebus_queue_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  iothub_id = try(
    element([for _, iothub in module.iothub : iothub.id if iothub.name == each.value["iothub_name"]], 0),
    each.value["iothub_id"]
  )
  authentication_type = try(each.value["authentication_type"], null)
  connection_string   = try(each.value["connection_string"], null)
  endpoint_uri        = try(each.value["endpoint_uri"], null)
  entity_path         = try(each.value["entity_path"], null)
  identity_id         = try(each.value["identity_id"], null)
  subscription_id     = try(each.value["subscription_id"], null)
  timeouts            = try(each.value["timeouts"], null)
}
