#############################################################################
# KUBERNETES CLUSTERS
#############################################################################
module "kubernetes_cluster" {
  source = "./modules/kubernetes_cluster"

  for_each = var.kubernetes_clusters

  kubernetes_cluster_name = each.value["kubernetes_cluster_name"]
  resource_group_name = try(
    element([for _, resource_group in module.rg : resource_group.name if resource_group.name == each.value["resource_group_name"]], 0),
    each.value["resource_group_name"]
  )
  location                                         = each.value["location"]
  dns_prefix                                       = try(each.value["dns_prefix"], null)
  dns_prefix_private_cluster                       = try(each.value["dns_prefix_private_cluster"], null)
  kubernetes_version                               = try(each.value["kubernetes_version"], null)
  automatic_upgrade_channel                        = try(each.value["automatic_upgrade_channel"], null)
  azure_policy_enabled                             = try(each.value["azure_policy_enabled"], null)
  cost_analysis_enabled                            = try(each.value["cost_analysis_enabled"], null)
  image_cleaner_enabled                            = try(each.value["image_cleaner_enabled"], null)
  image_cleaner_interval_hours                     = try(each.value["image_cleaner_interval_hours"], null)
  local_account_disabled                           = try(each.value["local_account_disabled"], null)
  node_os_upgrade_channel                          = try(each.value["node_os_upgrade_channel"], null)
  oidc_issuer_enabled                              = try(each.value["oidc_issuer_enabled"], null)
  private_cluster_enabled                          = try(each.value["private_cluster_enabled"], null)
  private_cluster_public_fqdn_enabled              = try(each.value["private_cluster_public_fqdn_enabled"], null)
  private_dns_zone_id                              = try(each.value["private_dns_zone_id"], null)
  role_based_access_control_enabled                = try(each.value["role_based_access_control_enabled"], null)
  run_command_enabled                              = try(each.value["run_command_enabled"], null)
  sku_tier                                         = try(each.value["sku_tier"], null)
  support_plan                                     = try(each.value["support_plan"], null)
  workload_identity_enabled                        = try(each.value["workload_identity_enabled"], null)
  api_server_access_profile                        = try(each.value["api_server_access_profile"], null)
  azure_active_directory_role_based_access_control = try(each.value["azure_active_directory_role_based_access_control"], null)
  default_node_pool                                = each.value["default_node_pool"]
  identity                                         = try(each.value["identity"], null)
  service_principal                                = try(each.value["service_principal"], null)
  linux_profile                                    = try(each.value["linux_profile"], null)
  network_profile                                  = try(each.value["network_profile"], null)
  oms_agent                                        = try(each.value["oms_agent"], null)
  microsoft_defender                               = try(each.value["microsoft_defender"], null)
  storage_profile                                  = try(each.value["storage_profile"], null)
  workload_autoscaler_profile                      = try(each.value["workload_autoscaler_profile"], null)
  timeouts                                         = try(each.value["timeouts"], null)
  tags                                             = try(each.value["tags"], var.tags)
}
