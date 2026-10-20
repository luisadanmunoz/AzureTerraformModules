#############################################################################
# SSH PUBLIC KEYS
#############################################################################
module "ssh_public_key" {
  source = "./modules/ssh_public_key"

  for_each = var.ssh_public_keys

  ssh_public_key_name = each.value["ssh_public_key_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location   = each.value["location"]
  public_key = each.value["public_key"]
  timeouts   = try(each.value["timeouts"], null)
  tags       = try(each.value["tags"], var.tags)
}
