#############################################################################
# PRIVATE ENDPOINTS
#############################################################################
module "private_endpoint" {
  source = "./modules/private_endpoint"

  for_each = var.private_endpoints

  private_endpoint_name = each.value["private_endpoint_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location = each.value["location"]
  subnet_id = try(
    element([for _, subnet in module.subnet : subnet.id if subnet.name == each.value["subnet_name"]], 0),
    each.value["subnet_id"]
  )
  custom_network_interface_name   = try(each.value["custom_network_interface_name"], null)
  private_service_connection_name = try(each.value["private_service_connection_name"], null)
  private_connection_resource_id  = each.value["private_connection_resource_id"]
  subresource_names               = each.value["subresource_names"]
  is_manual_connection            = try(each.value["is_manual_connection"], false)
  request_message                 = try(each.value["request_message"], null)
  private_dns_zone_group_name     = try(each.value["private_dns_zone_group_name"], "default")
  private_dns_zone_ids = try(
    length(coalesce(try(each.value["private_dns_zone_names"], null), [])) > 0 ? [
      for name in each.value["private_dns_zone_names"] :
      element([for _, private_dns_zone in module.private_dns_zone : private_dns_zone.id if private_dns_zone.name == name], 0)
    ] : each.value["private_dns_zone_ids"],
    each.value["private_dns_zone_ids"],
    []
  )
  tags = try(each.value["tags"], var.tags)
}
