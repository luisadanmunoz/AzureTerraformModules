#############################################################################
# AI FOUNDRY PROJECTS
#############################################################################
module "ai_foundry_project" {
  source = "./modules/ai_foundry_project"

  for_each = var.ai_foundry_projects

  ai_foundry_project_name = each.value["ai_foundry_project_name"]
  location                = each.value["location"]
  ai_services_hub_id = try(
    element([for _, ai_foundry in module.ai_foundry : ai_foundry.id if ai_foundry.name == each.value["ai_foundry_name"]], 0),
    each.value["ai_services_hub_id"]
  )
  description                    = try(each.value["description"], null)
  friendly_name                  = try(each.value["friendly_name"], null)
  high_business_impact_enabled   = try(each.value["high_business_impact_enabled"], null)
  primary_user_assigned_identity = try(each.value["primary_user_assigned_identity"], null)
  identity                       = try(each.value["identity"], null)
  timeouts                       = try(each.value["timeouts"], null)
  tags                           = try(each.value["tags"], var.tags)
}
