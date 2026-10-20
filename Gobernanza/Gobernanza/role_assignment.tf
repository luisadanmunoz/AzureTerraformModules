#############################################################################
# ROLE ASSIGNMENTS
#############################################################################
module "role_assignment" {
  source = "./modules/role_assignment"

  for_each = var.role_assignments

  scope = try(
    element([for _, resource_group in module.rg : resource_group.id if resource_group.name == each.value["resource_group_name"]], 0),
    element([for _, management_group in module.management_group : management_group.id if management_group.name == each.value["management_group_name"]], 0),
    each.value["scope"]
  )
  principal_id                     = each.value["principal_id"]
  role_definition_name             = try(each.value["role_definition_name"], null)
  role_definition_id               = try(each.value["role_definition_id"], null)
  principal_type                   = try(each.value["principal_type"], null)
  description                      = try(each.value["description"], null)
  condition                        = try(each.value["condition"], null)
  condition_version                = try(each.value["condition_version"], null)
  skip_service_principal_aad_check = try(each.value["skip_service_principal_aad_check"], false)
}
