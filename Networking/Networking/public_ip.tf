#############################################################################
# PUBLIC IPS
#############################################################################
module "public_ip" {
  source = "./modules/public_ip"

  for_each = var.public_ips

  public_ip_name = each.value["public_ip_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                = each.value["location"]
  allocation_method       = each.value["allocation_method"]
  sku                     = try(each.value["sku"], "Standard")
  sku_tier                = try(each.value["sku_tier"], "Regional")
  domain_name_label       = try(each.value["domain_name_label"], null)
  reverse_fqdn            = try(each.value["reverse_fqdn"], null)
  ip_version              = try(each.value["ip_version"], "IPv4")
  idle_timeout_in_minutes = try(each.value["idle_timeout_in_minutes"], 4)
  zones                   = try(each.value["zones"], [])
  tags                    = try(each.value["tags"], var.tags)
}
