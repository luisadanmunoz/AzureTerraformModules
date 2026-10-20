#############################################################################
# KUBERNETES FLEET MEMBERS
#############################################################################
module "kubernetes_fleet_member" {
  source = "./modules/kubernetes_fleet_member"

  for_each = var.kubernetes_fleet_members

  kubernetes_fleet_member_name = each.value["kubernetes_fleet_member_name"]
  kubernetes_fleet_id = try(
    element([for _, kubernetes_fleet_manager in module.kubernetes_fleet_manager : kubernetes_fleet_manager.id if kubernetes_fleet_manager.name == each.value["kubernetes_fleet_manager_name"]], 0),
    each.value["kubernetes_fleet_id"]
  )
  kubernetes_cluster_id = try(
    element([for _, kubernetes_cluster in module.kubernetes_cluster : kubernetes_cluster.id if kubernetes_cluster.name == each.value["kubernetes_cluster_name"]], 0),
    each.value["kubernetes_cluster_id"]
  )
  group    = try(each.value["group"], null)
  timeouts = try(each.value["timeouts"], null)
}
