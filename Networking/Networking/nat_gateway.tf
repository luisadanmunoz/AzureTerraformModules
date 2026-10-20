#############################################################################
# NAT GATEWAYS
#############################################################################
module "nat_gateway" {
  source = "./modules/nat_gateway"

  for_each = var.nat_gateways

  nat_gateway_name = each.value["nat_gateway_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                = each.value["location"]
  sku_name                = try(each.value["sku_name"], "Standard")
  idle_timeout_in_minutes = try(each.value["idle_timeout_in_minutes"], 4)
  public_ip_id_map = length(coalesce(try(each.value["public_ip_names"], null), [])) > 0 ? {
    for name in each.value["public_ip_names"] :
    name => module.public_ip[element([for public_ip_reference, public_ip in var.public_ips : public_ip_reference if public_ip.public_ip_name == name], 0)].id
    } : {
    for index, id in try(each.value["public_ip_ids"], []) : tostring(index) => id
  }
  public_ip_prefix_id_map = {
    for index, id in coalesce(try(each.value["public_ip_prefix_ids"], null), []) : tostring(index) => id
  }
  tags = try(each.value["tags"], var.tags)
}
