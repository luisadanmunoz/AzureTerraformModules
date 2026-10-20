#############################################################################
# COGNITIVE DEPLOYMENTS
#############################################################################
module "cognitive_deployment" {
  source = "./modules/cognitive_deployment"

  for_each = var.cognitive_deployments

  cognitive_deployment_name = each.value["cognitive_deployment_name"]
  cognitive_account_id = try(
    element([for _, cognitive_account in module.cognitive_account : cognitive_account.id if cognitive_account.name == each.value["cognitive_account_name"]], 0),
    each.value["cognitive_account_id"]
  )
  dynamic_throttling_enabled = try(each.value["dynamic_throttling_enabled"], null)
  rai_policy_name            = try(each.value["rai_policy_name"], null)
  version_upgrade_option     = try(each.value["version_upgrade_option"], null)
  model                      = each.value["model"]
  sku                        = each.value["sku"]
  timeouts                   = try(each.value["timeouts"], null)
}
