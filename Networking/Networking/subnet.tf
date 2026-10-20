#############################################################################
# SUBNETS
#############################################################################
module "subnet" {
  source = "./modules/subnet"

  for_each = var.subnets

  subnet_name = each.value["subnet_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  virtual_network_name = try(
    element([for _, virtual_network in module.vnet : virtual_network.name if virtual_network.name == each.value["virtual_network_name"]], 0),
    each.value["virtual_network_name"]
  )
  address_prefixes                      = each.value["address_prefixes"]
  service_endpoints                     = coalesce(try(each.value["service_endpoints"], null), [])
  service_endpoint_policy_ids           = coalesce(try(each.value["service_endpoint_policy_ids"], null), [])
  private_endpoint_network_policies     = try(each.value["private_endpoint_network_policies"], null)
  private_link_service_network_policies = try(each.value["private_link_service_network_policies"], null)
  delegations                           = coalesce(try(each.value["delegations"], null), [])
  associate_nsg = (
    try(each.value["nsg_name"], null) != null ||
    try(each.value["nsg_id"], null) != null
  )
  nsg_id = try(
    element([for _, network_security_group in module.nsg : network_security_group.id if network_security_group.name == each.value["nsg_name"]], 0),
    each.value["nsg_id"],
    null
  )
  associate_route_table = (
    try(each.value["route_table_name"], null) != null ||
    try(each.value["route_table_id"], null) != null
  )
  route_table_id = try(
    element([for _, route_table in module.route_table : route_table.id if route_table.name == each.value["route_table_name"]], 0),
    each.value["route_table_id"],
    null
  )
  associate_nat_gateway = (
    try(each.value["nat_gateway_name"], null) != null ||
    try(each.value["nat_gateway_id"], null) != null
  )
  nat_gateway_id = try(
    element([for _, nat_gateway in module.nat_gateway : nat_gateway.id if nat_gateway.name == each.value["nat_gateway_name"]], 0),
    each.value["nat_gateway_id"],
    null
  )
}
