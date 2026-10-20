#############################################################################
# SECURITY CENTER WORKSPACES
#############################################################################
module "security_center_workspace" {
  source = "./modules/security_center_workspace"

  for_each = var.security_center_workspaces

  scope = each.value["scope"]
  workspace_id = try(
    element([for _, workspace in module.log_analytics_workspace : workspace.id if workspace.name == each.value["log_analytics_workspace_name"]], 0),
    each.value["workspace_id"]
  )
  timeouts = try(each.value["timeouts"], null)
}
