#############################################################################
# VIRTUAL DESKTOP WORKSPACES
#############################################################################
module "virtual_desktop_workspace" {
  source = "./modules/virtual_desktop_workspace"

  for_each = var.virtual_desktop_workspaces

  virtual_desktop_workspace_name = each.value["virtual_desktop_workspace_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                      = each.value["location"]
  friendly_name                 = try(each.value["friendly_name"], null)
  description                   = try(each.value["description"], null)
  public_network_access_enabled = try(each.value["public_network_access_enabled"], null)
  timeouts                      = try(each.value["timeouts"], null)
  tags                          = try(each.value["tags"], var.tags)
}
