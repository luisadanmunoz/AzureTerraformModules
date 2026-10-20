#############################################################################
# VIRTUAL DESKTOP WORKSPACE APPLICATION GROUP ASSOCIATIONS
#############################################################################
module "virtual_desktop_workspace_application_group_association" {
  source = "./modules/virtual_desktop_workspace_application_group_association"

  for_each = var.virtual_desktop_workspace_application_group_associations

  workspace_id = try(
    element([for _, workspace in module.virtual_desktop_workspace : workspace.id if workspace.name == each.value["virtual_desktop_workspace_name"]], 0),
    each.value["workspace_id"]
  )
  application_group_id = try(
    element([for _, application_group in module.virtual_desktop_application_group : application_group.id if application_group.name == each.value["virtual_desktop_application_group_name"]], 0),
    each.value["application_group_id"]
  )
  timeouts = try(each.value["timeouts"], null)
}
