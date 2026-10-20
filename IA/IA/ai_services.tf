#############################################################################
# AI SERVICES
#############################################################################
module "ai_services" {
  source = "./modules/ai_services"

  for_each = var.ai_services

  ai_services_name = each.value["ai_services_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                           = each.value["location"]
  sku_name                           = each.value["sku_name"]
  custom_subdomain_name              = try(each.value["custom_subdomain_name"], null)
  fqdns                              = try(each.value["fqdns"], null)
  local_authentication_enabled       = try(each.value["local_authentication_enabled"], null)
  outbound_network_access_restricted = try(each.value["outbound_network_access_restricted"], null)
  public_network_access              = try(each.value["public_network_access"], null)
  customer_managed_key               = try(each.value["customer_managed_key"], null)
  identity                           = try(each.value["identity"], null)
  network_acls                       = try(each.value["network_acls"], null)
  storage                            = try(each.value["storage"], null)
  timeouts                           = try(each.value["timeouts"], null)
  tags                               = try(each.value["tags"], var.tags)
}
