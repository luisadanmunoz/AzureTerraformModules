#############################################################################
# VIRTUAL DESKTOP APPLICATION GROUPS
#############################################################################
module "virtual_desktop_application_group" {
  source = "./modules/virtual_desktop_application_group"

  for_each = var.virtual_desktop_application_groups

  virtual_desktop_application_group_name = each.value["virtual_desktop_application_group_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location = each.value["location"]
  type     = each.value["type"]
  host_pool_id = try(
    element([for _, host_pool in module.virtual_desktop_host_pool : host_pool.id if host_pool.name == each.value["virtual_desktop_host_pool_name"]], 0),
    each.value["host_pool_id"]
  )
  friendly_name                = try(each.value["friendly_name"], null)
  default_desktop_display_name = try(each.value["default_desktop_display_name"], null)
  description                  = try(each.value["description"], null)
  timeouts                     = try(each.value["timeouts"], null)
  tags                         = try(each.value["tags"], var.tags)
}
