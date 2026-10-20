#############################################################################
# IOT HUB ENDPOINT STORAGE CONTAINERS
#############################################################################
module "iothub_endpoint_storage_container" {
  source = "./modules/iothub_endpoint_storage_container"

  for_each = var.iothub_endpoint_storage_containers

  iothub_endpoint_storage_container_name = each.value["iothub_endpoint_storage_container_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  iothub_id = try(
    element([for _, iothub in module.iothub : iothub.id if iothub.name == each.value["iothub_name"]], 0),
    each.value["iothub_id"]
  )
  container_name             = each.value["container_name"]
  authentication_type        = try(each.value["authentication_type"], null)
  connection_string          = try(each.value["connection_string"], null)
  endpoint_uri               = try(each.value["endpoint_uri"], null)
  identity_id                = try(each.value["identity_id"], null)
  batch_frequency_in_seconds = try(each.value["batch_frequency_in_seconds"], null)
  encoding                   = try(each.value["encoding"], null)
  file_name_format           = try(each.value["file_name_format"], null)
  max_chunk_size_in_bytes    = try(each.value["max_chunk_size_in_bytes"], null)
  subscription_id            = try(each.value["subscription_id"], null)
  timeouts                   = try(each.value["timeouts"], null)
}
