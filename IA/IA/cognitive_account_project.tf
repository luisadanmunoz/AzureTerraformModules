#############################################################################
# COGNITIVE ACCOUNT PROJECTS
#############################################################################
module "cognitive_account_project" {
  source = "./modules/cognitive_account_project"

  for_each = var.cognitive_account_projects

  cognitive_account_project_name = each.value["cognitive_account_project_name"]
  location                       = each.value["location"]
  cognitive_account_id = try(
    element([for _, cognitive_account in module.cognitive_account : cognitive_account.id if cognitive_account.name == each.value["cognitive_account_name"]], 0),
    each.value["cognitive_account_id"]
  )
  description  = try(each.value["description"], null)
  display_name = try(each.value["display_name"], null)
  identity     = each.value["identity"]
  timeouts     = try(each.value["timeouts"], null)
  tags         = try(each.value["tags"], var.tags)
}
