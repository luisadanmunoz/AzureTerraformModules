#############################################################################
# KUBERNETES FLEET UPDATE STRATEGIES
#############################################################################
module "kubernetes_fleet_update_strategy" {
  source = "./modules/kubernetes_fleet_update_strategy"

  for_each = var.kubernetes_fleet_update_strategies

  kubernetes_fleet_update_strategy_name = each.value["kubernetes_fleet_update_strategy_name"]
  kubernetes_fleet_manager_id = try(
    element([for _, kubernetes_fleet_manager in module.kubernetes_fleet_manager : kubernetes_fleet_manager.id if kubernetes_fleet_manager.name == each.value["kubernetes_fleet_manager_name"]], 0),
    each.value["kubernetes_fleet_manager_id"]
  )
  stages   = each.value["stages"]
  timeouts = try(each.value["timeouts"], null)
}
