#############################################################################
# KUBERNETES CLUSTER NODE POOLS
#############################################################################
module "kubernetes_cluster_node_pool" {
  source = "./modules/kubernetes_cluster_node_pool"

  for_each = var.kubernetes_cluster_node_pools

  kubernetes_cluster_node_pool_name = each.value["kubernetes_cluster_node_pool_name"]
  kubernetes_cluster_id = try(
    element([for _, kubernetes_cluster in module.kubernetes_cluster : kubernetes_cluster.id if kubernetes_cluster.name == each.value["kubernetes_cluster_name"]], 0),
    each.value["kubernetes_cluster_id"]
  )
  vm_size                     = try(each.value["vm_size"], null)
  node_count                  = try(each.value["node_count"], null)
  auto_scaling_enabled        = try(each.value["auto_scaling_enabled"], null)
  min_count                   = try(each.value["min_count"], null)
  max_count                   = try(each.value["max_count"], null)
  max_pods                    = try(each.value["max_pods"], null)
  mode                        = try(each.value["mode"], null)
  node_labels                 = try(each.value["node_labels"], null)
  node_public_ip_enabled      = try(each.value["node_public_ip_enabled"], null)
  node_public_ip_prefix_id    = try(each.value["node_public_ip_prefix_id"], null)
  node_taints                 = try(each.value["node_taints"], null)
  orchestrator_version        = try(each.value["orchestrator_version"], null)
  os_disk_size_gb             = try(each.value["os_disk_size_gb"], null)
  os_disk_type                = try(each.value["os_disk_type"], null)
  os_sku                      = try(each.value["os_sku"], null)
  os_type                     = try(each.value["os_type"], null)
  pod_subnet_id               = try(each.value["pod_subnet_id"], null)
  priority                    = try(each.value["priority"], null)
  scale_down_mode             = try(each.value["scale_down_mode"], null)
  spot_max_price              = try(each.value["spot_max_price"], null)
  temporary_name_for_rotation = try(each.value["temporary_name_for_rotation"], null)
  ultra_ssd_enabled           = try(each.value["ultra_ssd_enabled"], null)
  vnet_subnet_id              = try(each.value["vnet_subnet_id"], null)
  workload_runtime            = try(each.value["workload_runtime"], null)
  zones                       = try(each.value["zones"], null)
  kubelet_config              = try(each.value["kubelet_config"], null)
  linux_os_config             = try(each.value["linux_os_config"], null)
  upgrade_settings            = try(each.value["upgrade_settings"], null)
  timeouts                    = try(each.value["timeouts"], null)
  tags                        = try(each.value["tags"], var.tags)
}
