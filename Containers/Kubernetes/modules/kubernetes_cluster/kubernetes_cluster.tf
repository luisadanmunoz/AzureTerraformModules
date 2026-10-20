#############################################################################
# KUBERNETES CLUSTER
#############################################################################
resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                                = var.kubernetes_cluster_name
  resource_group_name                 = var.resource_group_name
  location                            = var.location
  dns_prefix                          = var.dns_prefix
  dns_prefix_private_cluster          = var.dns_prefix_private_cluster
  kubernetes_version                  = var.kubernetes_version
  automatic_upgrade_channel           = var.automatic_upgrade_channel
  azure_policy_enabled                = var.azure_policy_enabled
  cost_analysis_enabled               = var.cost_analysis_enabled
  image_cleaner_enabled               = var.image_cleaner_enabled
  image_cleaner_interval_hours        = var.image_cleaner_interval_hours
  local_account_disabled              = var.local_account_disabled
  node_os_upgrade_channel             = var.node_os_upgrade_channel
  oidc_issuer_enabled                 = var.oidc_issuer_enabled
  private_cluster_enabled             = var.private_cluster_enabled
  private_cluster_public_fqdn_enabled = var.private_cluster_public_fqdn_enabled
  private_dns_zone_id                 = var.private_dns_zone_id
  role_based_access_control_enabled   = var.role_based_access_control_enabled
  run_command_enabled                 = var.run_command_enabled
  sku_tier                            = var.sku_tier
  support_plan                        = var.support_plan
  workload_identity_enabled           = var.workload_identity_enabled
  tags                                = var.tags

  default_node_pool {
    name                         = var.default_node_pool["name"]
    vm_size                      = try(var.default_node_pool["vm_size"], null)
    node_count                   = try(var.default_node_pool["node_count"], null)
    auto_scaling_enabled         = try(var.default_node_pool["auto_scaling_enabled"], null)
    min_count                    = try(var.default_node_pool["min_count"], null)
    max_count                    = try(var.default_node_pool["max_count"], null)
    max_pods                     = try(var.default_node_pool["max_pods"], null)
    node_labels                  = try(var.default_node_pool["node_labels"], null)
    node_public_ip_enabled       = try(var.default_node_pool["node_public_ip_enabled"], null)
    only_critical_addons_enabled = try(var.default_node_pool["only_critical_addons_enabled"], null)
    orchestrator_version         = try(var.default_node_pool["orchestrator_version"], null)
    os_disk_size_gb              = try(var.default_node_pool["os_disk_size_gb"], null)
    os_disk_type                 = try(var.default_node_pool["os_disk_type"], null)
    os_sku                       = try(var.default_node_pool["os_sku"], null)
    pod_subnet_id                = try(var.default_node_pool["pod_subnet_id"], null)
    scale_down_mode              = try(var.default_node_pool["scale_down_mode"], null)
    temporary_name_for_rotation  = try(var.default_node_pool["temporary_name_for_rotation"], null)
    type                         = try(var.default_node_pool["type"], null)
    ultra_ssd_enabled            = try(var.default_node_pool["ultra_ssd_enabled"], null)
    vnet_subnet_id               = try(var.default_node_pool["vnet_subnet_id"], null)
    zones                        = try(var.default_node_pool["zones"], null)

    dynamic "kubelet_config" {
      for_each = try(var.default_node_pool["kubelet_config"], null) != null ? [var.default_node_pool["kubelet_config"]] : []

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
      for_each = try(var.default_node_pool["linux_os_config"], null) != null ? [var.default_node_pool["linux_os_config"]] : []

      content {
        swap_file_size_mb            = try(linux_os_config.value["swap_file_size_mb"], null)
        transparent_huge_page        = try(linux_os_config.value["transparent_huge_page"], null)
        transparent_huge_page_defrag = try(linux_os_config.value["transparent_huge_page_defrag"], null)
      }
    }

    dynamic "upgrade_settings" {
      for_each = try(var.default_node_pool["upgrade_settings"], null) != null ? [var.default_node_pool["upgrade_settings"]] : []

      content {
        max_surge                     = upgrade_settings.value["max_surge"]
        drain_timeout_in_minutes      = try(upgrade_settings.value["drain_timeout_in_minutes"], null)
        node_soak_duration_in_minutes = try(upgrade_settings.value["node_soak_duration_in_minutes"], null)
        undrainable_node_behavior     = try(upgrade_settings.value["undrainable_node_behavior"], null)
      }
    }
  }

  dynamic "api_server_access_profile" {
    for_each = var.api_server_access_profile != null ? [var.api_server_access_profile] : []

    content {
      authorized_ip_ranges                = try(api_server_access_profile.value["authorized_ip_ranges"], null)
      subnet_id                           = try(api_server_access_profile.value["subnet_id"], null)
      virtual_network_integration_enabled = try(api_server_access_profile.value["virtual_network_integration_enabled"], null)
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.azure_active_directory_role_based_access_control != null ? [var.azure_active_directory_role_based_access_control] : []

    content {
      admin_group_object_ids = try(azure_active_directory_role_based_access_control.value["admin_group_object_ids"], null)
      azure_rbac_enabled     = try(azure_active_directory_role_based_access_control.value["azure_rbac_enabled"], null)
      tenant_id              = try(azure_active_directory_role_based_access_control.value["tenant_id"], null)
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = try(identity.value["identity_ids"], null)
    }
  }

  dynamic "service_principal" {
    for_each = var.service_principal != null ? [var.service_principal] : []

    content {
      client_id     = service_principal.value["client_id"]
      client_secret = service_principal.value["client_secret"]
    }
  }

  dynamic "linux_profile" {
    for_each = var.linux_profile != null ? [var.linux_profile] : []

    content {
      admin_username = linux_profile.value["admin_username"]

      ssh_key {
        key_data = linux_profile.value["ssh_key"]["key_data"]
      }
    }
  }

  dynamic "network_profile" {
    for_each = var.network_profile != null ? [var.network_profile] : []

    content {
      network_plugin      = network_profile.value["network_plugin"]
      dns_service_ip      = try(network_profile.value["dns_service_ip"], null)
      load_balancer_sku   = try(network_profile.value["load_balancer_sku"], null)
      network_data_plane  = try(network_profile.value["network_data_plane"], null)
      network_mode        = try(network_profile.value["network_mode"], null)
      network_plugin_mode = try(network_profile.value["network_plugin_mode"], null)
      network_policy      = try(network_profile.value["network_policy"], null)
      outbound_type       = try(network_profile.value["outbound_type"], null)
      pod_cidr            = try(network_profile.value["pod_cidr"], null)
      pod_cidrs           = try(network_profile.value["pod_cidrs"], null)
      service_cidr        = try(network_profile.value["service_cidr"], null)
      service_cidrs       = try(network_profile.value["service_cidrs"], null)

      dynamic "advanced_networking" {
        for_each = try(network_profile.value["advanced_networking"], null) != null ? [network_profile.value["advanced_networking"]] : []

        content {
          observability_enabled = try(advanced_networking.value["observability_enabled"], null)
          security_enabled      = try(advanced_networking.value["security_enabled"], null)
        }
      }

      dynamic "load_balancer_profile" {
        for_each = try(network_profile.value["load_balancer_profile"], null) != null ? [network_profile.value["load_balancer_profile"]] : []

        content {
          backend_pool_type           = try(load_balancer_profile.value["backend_pool_type"], null)
          idle_timeout_in_minutes     = try(load_balancer_profile.value["idle_timeout_in_minutes"], null)
          managed_outbound_ip_count   = try(load_balancer_profile.value["managed_outbound_ip_count"], null)
          managed_outbound_ipv6_count = try(load_balancer_profile.value["managed_outbound_ipv6_count"], null)
          outbound_ip_address_ids     = try(load_balancer_profile.value["outbound_ip_address_ids"], null)
          outbound_ip_prefix_ids      = try(load_balancer_profile.value["outbound_ip_prefix_ids"], null)
          outbound_ports_allocated    = try(load_balancer_profile.value["outbound_ports_allocated"], null)
        }
      }

      dynamic "nat_gateway_profile" {
        for_each = try(network_profile.value["nat_gateway_profile"], null) != null ? [network_profile.value["nat_gateway_profile"]] : []

        content {
          idle_timeout_in_minutes   = try(nat_gateway_profile.value["idle_timeout_in_minutes"], null)
          managed_outbound_ip_count = try(nat_gateway_profile.value["managed_outbound_ip_count"], null)
        }
      }
    }
  }

  dynamic "oms_agent" {
    for_each = var.oms_agent != null ? [var.oms_agent] : []

    content {
      log_analytics_workspace_id      = oms_agent.value["log_analytics_workspace_id"]
      msi_auth_for_monitoring_enabled = try(oms_agent.value["msi_auth_for_monitoring_enabled"], null)
    }
  }

  dynamic "microsoft_defender" {
    for_each = var.microsoft_defender != null ? [var.microsoft_defender] : []

    content {
      log_analytics_workspace_id = microsoft_defender.value["log_analytics_workspace_id"]
    }
  }

  dynamic "storage_profile" {
    for_each = var.storage_profile != null ? [var.storage_profile] : []

    content {
      blob_driver_enabled         = try(storage_profile.value["blob_driver_enabled"], null)
      disk_driver_enabled         = try(storage_profile.value["disk_driver_enabled"], null)
      file_driver_enabled         = try(storage_profile.value["file_driver_enabled"], null)
      snapshot_controller_enabled = try(storage_profile.value["snapshot_controller_enabled"], null)
    }
  }

  dynamic "workload_autoscaler_profile" {
    for_each = var.workload_autoscaler_profile != null ? [var.workload_autoscaler_profile] : []

    content {
      keda_enabled                    = try(workload_autoscaler_profile.value["keda_enabled"], null)
      vertical_pod_autoscaler_enabled = try(workload_autoscaler_profile.value["vertical_pod_autoscaler_enabled"], null)
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
      condition     = (var.identity != null) != (var.service_principal != null)
      error_message = "Exactly one of identity or service_principal must be provided."
    }

    precondition {
      condition     = var.dns_prefix != null || var.dns_prefix_private_cluster != null
      error_message = "You must provide dns_prefix or dns_prefix_private_cluster."
    }

    precondition {
      condition = (
        coalesce(try(var.default_node_pool["auto_scaling_enabled"], null), false) == true &&
        try(var.default_node_pool["min_count"], null) != null &&
        try(var.default_node_pool["max_count"], null) != null
        ) || (
        coalesce(try(var.default_node_pool["auto_scaling_enabled"], null), false) == false &&
        try(var.default_node_pool["node_count"], null) != null
      )
      error_message = "When default_node_pool.auto_scaling_enabled is true you must set min_count and max_count. When false you must set node_count."
    }
  }
}
