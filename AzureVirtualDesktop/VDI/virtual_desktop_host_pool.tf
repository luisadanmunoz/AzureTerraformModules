#############################################################################
# VIRTUAL DESKTOP HOST POOLS
#############################################################################
module "virtual_desktop_host_pool" {
  source = "./modules/virtual_desktop_host_pool"

  for_each = var.virtual_desktop_host_pools

  virtual_desktop_host_pool_name = each.value["virtual_desktop_host_pool_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                         = each.value["location"]
  type                             = each.value["type"]
  load_balancer_type               = each.value["load_balancer_type"]
  friendly_name                    = try(each.value["friendly_name"], null)
  description                      = try(each.value["description"], null)
  validate_environment             = try(each.value["validate_environment"], null)
  start_vm_on_connect              = try(each.value["start_vm_on_connect"], null)
  custom_rdp_properties            = try(each.value["custom_rdp_properties"], null)
  personal_desktop_assignment_type = try(each.value["personal_desktop_assignment_type"], null)
  public_network_access            = try(each.value["public_network_access"], null)
  maximum_sessions_allowed         = try(each.value["maximum_sessions_allowed"], null)
  preferred_app_group_type         = try(each.value["preferred_app_group_type"], null)
  vm_template                      = try(each.value["vm_template"], null)
  scheduled_agent_updates          = try(each.value["scheduled_agent_updates"], null)
  timeouts                         = try(each.value["timeouts"], null)
  tags                             = try(each.value["tags"], var.tags)
}
