#############################################################################
# EVENTHUB
#############################################################################

module "eventhub" {
  source = "./modules/eventhub"

  for_each = var.eventhub


  namespace               = each.value["namespace"]
  location                = each.value["location"]
  resource_group_name     = each.value["resource_group_name"]
  name_eventhub           = each.value["name_eventhub"]
  name_authorization_rule = each.value["name_authorization_rule"]
  subnet_id               = element([for k, v in module.subnet : v.id if v.name == each.value["subnet"]], 0)
  private_dns_zone_ids    = element([for k, v in module.private_dns_zone : v.id if v.name == each.value["private_dns_zone_ids"]], 0)

  tags = var.tags

  depends_on = [module.subnet, module.private_dns_zone]

}




