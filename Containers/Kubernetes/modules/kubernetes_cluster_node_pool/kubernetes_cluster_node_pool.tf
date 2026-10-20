#############################################################################
# KUBERNETES CLUSTER NODE POOL
#############################################################################
resource "azurerm_kubernetes_cluster_node_pool" "kubernetes_cluster_node_pool" {
  name                        = var.kubernetes_cluster_node_pool_name
  kubernetes_cluster_id       = var.kubernetes_cluster_id
  vm_size                     = var.vm_size
  node_count                  = var.node_count
  auto_scaling_enabled        = var.auto_scaling_enabled
  min_count                   = var.min_count
  max_count                   = var.max_count
  max_pods                    = var.max_pods
  mode                        = var.mode
  node_labels                 = var.node_labels
  node_public_ip_enabled      = var.node_public_ip_enabled
  node_public_ip_prefix_id    = var.node_public_ip_prefix_id
  node_taints                 = var.node_taints
  orchestrator_version        = var.orchestrator_version
  os_disk_size_gb             = var.os_disk_size_gb
  os_disk_type                = var.os_disk_type
  os_sku                      = var.os_sku
  os_type                     = var.os_type
  pod_subnet_id               = var.pod_subnet_id
  priority                    = var.priority
  scale_down_mode             = var.scale_down_mode
  spot_max_price              = var.spot_max_price
  temporary_name_for_rotation = var.temporary_name_for_rotation
  ultra_ssd_enabled           = var.ultra_ssd_enabled
  vnet_subnet_id              = var.vnet_subnet_id
  workload_runtime            = var.workload_runtime
  zones                       = var.zones
  tags                        = var.tags

  dynamic "kubelet_config" {
    for_each = var.kubelet_config != null ? [var.kubelet_config] : []

    content {
      allowed_unsafe_sysctls    = try(kubelet_config.value["allowed_unsafe_sysctls"], null)
      container_log_max_line    = try(kubelet_config.value["container_log_max_line"], null)
      container_log_max_size_mb = try(kubelet_config.value["container_log_max_size_mb"], null)
      cpu_cfs_quota_enabled     = try(kubelet_config.value["cpu_cfs_quota_enabled"], null)
      cpu_cfs_quota_period      = try(kubelet_config.value["cpu_cfs_quota_period"], null)
      cpu_manager_policy        = try(kubelet_config.value["cpu_manager_policy"], null)
      image_gc_high_threshold   = try(kubelet_config.value["image_gc_high_threshold"], null)
      image_gc_low_threshold    = try(kubelet_config.value["image_gc_low_threshold"], null)
      pod_max_pid               = try(kubelet_config.value["pod_max_pid"], null)
      topology_manager_policy   = try(kubelet_config.value["topology_manager_policy"], null)
    }
  }

  dynamic "linux_os_config" {
    for_each = var.linux_os_config != null ? [var.linux_os_config] : []

    content {
      swap_file_size_mb            = try(linux_os_config.value["swap_file_size_mb"], null)
      transparent_huge_page        = try(linux_os_config.value["transparent_huge_page"], null)
      transparent_huge_page_defrag = try(linux_os_config.value["transparent_huge_page_defrag"], null)
    }
  }

  dynamic "upgrade_settings" {
    for_each = var.upgrade_settings != null ? [var.upgrade_settings] : []

    content {
      max_surge                     = upgrade_settings.value["max_surge"]
      drain_timeout_in_minutes      = try(upgrade_settings.value["drain_timeout_in_minutes"], null)
      node_soak_duration_in_minutes = try(upgrade_settings.value["node_soak_duration_in_minutes"], null)
      undrainable_node_behavior     = try(upgrade_settings.value["undrainable_node_behavior"], null)
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }

  lifecycle {
    precondition {
      condition = (
        coalesce(try(var.auto_scaling_enabled, null), false) == true &&
        var.min_count != null &&
        var.max_count != null
        ) || (
        coalesce(try(var.auto_scaling_enabled, null), false) == false &&
        var.node_count != null
      )
      error_message = "When auto_scaling_enabled is true you must set min_count and max_count. When false you must set node_count."
    }
  }
}
