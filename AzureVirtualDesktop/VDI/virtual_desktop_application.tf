#############################################################################
# VIRTUAL DESKTOP APPLICATIONS
#############################################################################
module "virtual_desktop_application" {
  source = "./modules/virtual_desktop_application"

  for_each = var.virtual_desktop_applications

  virtual_desktop_application_name = each.value["virtual_desktop_application_name"]
  application_group_id = try(
    element([for _, application_group in module.virtual_desktop_application_group : application_group.id if application_group.name == each.value["virtual_desktop_application_group_name"]], 0),
    each.value["application_group_id"]
  )
  friendly_name                = try(each.value["friendly_name"], null)
  description                  = try(each.value["description"], null)
  path                         = each.value["path"]
  command_line_argument_policy = each.value["command_line_argument_policy"]
  command_line_arguments       = try(each.value["command_line_arguments"], null)
  show_in_portal               = try(each.value["show_in_portal"], null)
  icon_path                    = try(each.value["icon_path"], null)
  icon_index                   = try(each.value["icon_index"], null)
  timeouts                     = try(each.value["timeouts"], null)
}
