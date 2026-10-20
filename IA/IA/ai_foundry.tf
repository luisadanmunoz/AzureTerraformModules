#############################################################################
# AI FOUNDRY
#############################################################################
module "ai_foundry" {
  source = "./modules/ai_foundry"

  for_each = var.ai_foundries

  ai_foundry_name = each.value["ai_foundry_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                       = each.value["location"]
  storage_account_id             = each.value["storage_account_id"]
  key_vault_id                   = each.value["key_vault_id"]
  identity                       = each.value["identity"]
  application_insights_id        = try(each.value["application_insights_id"], null)
  container_registry_id          = try(each.value["container_registry_id"], null)
  description                    = try(each.value["description"], null)
  friendly_name                  = try(each.value["friendly_name"], null)
  high_business_impact_enabled   = try(each.value["high_business_impact_enabled"], null)
  primary_user_assigned_identity = try(each.value["primary_user_assigned_identity"], null)
  public_network_access          = try(each.value["public_network_access"], null)
  encryption                     = try(each.value["encryption"], null)
  managed_network                = try(each.value["managed_network"], null)
  timeouts                       = try(each.value["timeouts"], null)
  tags                           = try(each.value["tags"], var.tags)
}
