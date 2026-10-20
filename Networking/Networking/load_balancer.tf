#############################################################################
# LOAD BALANCERS
#############################################################################
module "load_balancer" {
  source = "./modules/load_balancer"

  for_each = var.load_balancers

  load_balancer_name = each.value["load_balancer_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location  = each.value["location"]
  sku       = try(each.value["sku"], "Standard")
  sku_tier  = try(each.value["sku_tier"], "Regional")
  edge_zone = try(each.value["edge_zone"], null)
  frontend_ip_configurations = [
    for configuration in each.value["frontend_ip_configurations"] : merge(
      configuration,
      {
        subnet_id = try(
          element([for _, subnet in module.subnet : subnet.id if subnet.name == configuration["subnet_name"]], 0),
          configuration["subnet_id"],
          null
        )
        public_ip_address_id = try(
          element([for _, public_ip in module.public_ip : public_ip.id if public_ip.name == configuration["public_ip_name"]], 0),
          configuration["public_ip_id"],
          null
        )
      }
    )
  ]
  backend_address_pools = try(each.value["backend_address_pools"], [])
  probes                = try(each.value["probes"], [])
  rules                 = try(each.value["rules"], [])
  tags                  = try(each.value["tags"], var.tags)
}
