#############################################################################
# BASTION HOSTS
#############################################################################
module "bastion_host" {
  source = "./modules/bastion_host"

  for_each = var.bastion_hosts

  bastion_host_name = each.value["bastion_host_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location = each.value["location"]
  subnet_id = try(
    element([for _, subnet in module.subnet : subnet.id if subnet.name == each.value["subnet_name"]], 0),
    each.value["subnet_id"]
  )
  public_ip_id = try(
    element([for _, public_ip in module.public_ip : public_ip.id if public_ip.name == each.value["public_ip_name"]], 0),
    each.value["public_ip_id"]
  )
  sku                    = try(each.value["sku"], "Standard")
  scale_units            = try(each.value["scale_units"], 2)
  copy_paste_enabled     = try(each.value["copy_paste_enabled"], true)
  file_copy_enabled      = try(each.value["file_copy_enabled"], false)
  ip_connect_enabled     = try(each.value["ip_connect_enabled"], false)
  shareable_link_enabled = try(each.value["shareable_link_enabled"], false)
  tunneling_enabled      = try(each.value["tunneling_enabled"], false)
  zones                  = try(each.value["zones"], [])
  tags                   = try(each.value["tags"], var.tags)
}
