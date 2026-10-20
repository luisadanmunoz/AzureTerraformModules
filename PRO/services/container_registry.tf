#############################################################################
# CONTAINER REGISTRY
#############################################################################
module "container_registry" {
  source = "./modules/container_registry"

  for_each = var.container_registry

  name                 = each.value["name"]
  location             = each.value["location"]
  resource_group_name  = each.value["resource_group_name"]
  subnet_id            = element([for k, v in module.subnet : v.id if v.name == each.value["subnet"]], 0)
  private_dns_zone_ids = element([for k, v in module.private_dns_zone : v.id if v.name == each.value["private_dns_zone_ids"]], 0)
  /*
  sku                       = each.value["sku"]
  agentpool                 = each.value["agentpool"]
  
*/

  tags = var.tags

  depends_on = [module.subnet, module.private_dns_zone]

}

