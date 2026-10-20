#############################################################################
# GLOBAL TAGS
#############################################################################
variable "tags" {
  description = "value to set the global tags"
  type        = map(string)
  default     = {}
}

#############################################################################
# RESOURCE GROUPS
#############################################################################
variable "resources_groups" {
  description = "value to set the resources groups"
  type = map(object({
    resource_group_name = string
    location            = string
    tags                = optional(map(string))
  }))
  default = {}
}

#############################################################################
# KUBERNETES CLUSTERS
#############################################################################
variable "kubernetes_clusters" {
  description = "value to set the kubernetes clusters"
  type = map(object({
    kubernetes_cluster_name             = string
    resource_group_name                 = optional(string)
    location                            = string
    dns_prefix                          = optional(string)
    dns_prefix_private_cluster          = optional(string)
    kubernetes_version                  = optional(string)
    automatic_upgrade_channel           = optional(string)
    azure_policy_enabled                = optional(bool)
    cost_analysis_enabled               = optional(bool)
    image_cleaner_enabled               = optional(bool)
    image_cleaner_interval_hours        = optional(number)
    local_account_disabled              = optional(bool)
    node_os_upgrade_channel             = optional(string)
    oidc_issuer_enabled                 = optional(bool)
    private_cluster_enabled             = optional(bool)
    private_cluster_public_fqdn_enabled = optional(bool)
    private_dns_zone_id                 = optional(string)
    role_based_access_control_enabled   = optional(bool)
    run_command_enabled                 = optional(bool)
    sku_tier                            = optional(string)
    support_plan                        = optional(string)
    workload_identity_enabled           = optional(bool)
    api_server_access_profile = optional(object({
      authorized_ip_ranges                = optional(list(string))
      subnet_id                           = optional(string)
      virtual_network_integration_enabled = optional(bool)
    }))
    azure_active_directory_role_based_access_control = optional(object({
      admin_group_object_ids = optional(list(string))
      azure_rbac_enabled     = optional(bool)
      tenant_id              = optional(string)
    }))
    default_node_pool = object({
      name                         = string
      vm_size                      = optional(string)
      node_count                   = optional(number)
      auto_scaling_enabled         = optional(bool)
      min_count                    = optional(number)
      max_count                    = optional(number)
      max_pods                     = optional(number)
      node_labels                  = optional(map(string))
      node_public_ip_enabled       = optional(bool)
      only_critical_addons_enabled = optional(bool)
      orchestrator_version         = optional(string)
      os_disk_size_gb              = optional(number)
      os_disk_type                 = optional(string)
      os_sku                       = optional(string)
      pod_subnet_id                = optional(string)
      scale_down_mode              = optional(string)
      temporary_name_for_rotation  = optional(string)
      type                         = optional(string)
      ultra_ssd_enabled            = optional(bool)
      vnet_subnet_id               = optional(string)
      zones                        = optional(list(string))
      kubelet_config = optional(object({
        allowed_unsafe_sysctls    = optional(list(string))
        container_log_max_line    = optional(number)
        container_log_max_size_mb = optional(number)
        cpu_cfs_quota_enabled     = optional(bool)
        cpu_cfs_quota_period      = optional(string)
        cpu_manager_policy        = optional(string)
        image_gc_high_threshold   = optional(number)
        image_gc_low_threshold    = optional(number)
        pod_max_pid               = optional(number)
        topology_manager_policy   = optional(string)
      }))
      linux_os_config = optional(object({
        swap_file_size_mb            = optional(number)
        transparent_huge_page        = optional(string)
        transparent_huge_page_defrag = optional(string)
      }))
      upgrade_settings = optional(object({
        max_surge                     = string
        drain_timeout_in_minutes      = optional(number)
        node_soak_duration_in_minutes = optional(number)
        undrainable_node_behavior     = optional(string)
      }))
    })
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    service_principal = optional(object({
      client_id     = string
      client_secret = string
    }))
    linux_profile = optional(object({
      admin_username = string
      ssh_key = object({
        key_data = string
      })
    }))
    network_profile = optional(object({
      network_plugin      = string
      dns_service_ip      = optional(string)
      load_balancer_sku   = optional(string)
      network_data_plane  = optional(string)
      network_mode        = optional(string)
      network_plugin_mode = optional(string)
      network_policy      = optional(string)
      outbound_type       = optional(string)
      pod_cidr            = optional(string)
      pod_cidrs           = optional(list(string))
      service_cidr        = optional(string)
      service_cidrs       = optional(list(string))
      advanced_networking = optional(object({
        observability_enabled = optional(bool)
        security_enabled      = optional(bool)
      }))
      load_balancer_profile = optional(object({
        backend_pool_type           = optional(string)
        idle_timeout_in_minutes     = optional(number)
        managed_outbound_ip_count   = optional(number)
        managed_outbound_ipv6_count = optional(number)
        outbound_ip_address_ids     = optional(list(string))
        outbound_ip_prefix_ids      = optional(list(string))
        outbound_ports_allocated    = optional(number)
      }))
      nat_gateway_profile = optional(object({
        idle_timeout_in_minutes   = optional(number)
        managed_outbound_ip_count = optional(number)
      }))
    }))
    oms_agent = optional(object({
      log_analytics_workspace_id      = string
      msi_auth_for_monitoring_enabled = optional(bool)
    }))
    microsoft_defender = optional(object({
      log_analytics_workspace_id = string
    }))
    storage_profile = optional(object({
      blob_driver_enabled         = optional(bool)
      disk_driver_enabled         = optional(bool)
      file_driver_enabled         = optional(bool)
      snapshot_controller_enabled = optional(bool)
    }))
    workload_autoscaler_profile = optional(object({
      keda_enabled                    = optional(bool)
      vertical_pod_autoscaler_enabled = optional(bool)
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# KUBERNETES CLUSTER NODE POOLS
#############################################################################
variable "kubernetes_cluster_node_pools" {
  description = "value to set the kubernetes cluster node pools"
  type = map(object({
    kubernetes_cluster_node_pool_name = string
    kubernetes_cluster_name           = optional(string)
    kubernetes_cluster_id             = optional(string)
    vm_size                           = optional(string)
    node_count                        = optional(number)
    auto_scaling_enabled              = optional(bool)
    min_count                         = optional(number)
    max_count                         = optional(number)
    max_pods                          = optional(number)
    mode                              = optional(string)
    node_labels                       = optional(map(string))
    node_public_ip_enabled            = optional(bool)
    node_public_ip_prefix_id          = optional(string)
    node_taints                       = optional(list(string))
    orchestrator_version              = optional(string)
    os_disk_size_gb                   = optional(number)
    os_disk_type                      = optional(string)
    os_sku                            = optional(string)
    os_type                           = optional(string)
    pod_subnet_id                     = optional(string)
    priority                          = optional(string)
    scale_down_mode                   = optional(string)
    spot_max_price                    = optional(number)
    temporary_name_for_rotation       = optional(string)
    ultra_ssd_enabled                 = optional(bool)
    vnet_subnet_id                    = optional(string)
    workload_runtime                  = optional(string)
    zones                             = optional(list(string))
    kubelet_config = optional(object({
      allowed_unsafe_sysctls    = optional(list(string))
      container_log_max_line    = optional(number)
      container_log_max_size_mb = optional(number)
      cpu_cfs_quota_enabled     = optional(bool)
      cpu_cfs_quota_period      = optional(string)
      cpu_manager_policy        = optional(string)
      image_gc_high_threshold   = optional(number)
      image_gc_low_threshold    = optional(number)
      pod_max_pid               = optional(number)
      topology_manager_policy   = optional(string)
    }))
    linux_os_config = optional(object({
      swap_file_size_mb            = optional(number)
      transparent_huge_page        = optional(string)
      transparent_huge_page_defrag = optional(string)
    }))
    upgrade_settings = optional(object({
      max_surge                     = string
      drain_timeout_in_minutes      = optional(number)
      node_soak_duration_in_minutes = optional(number)
      undrainable_node_behavior     = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# KUBERNETES CLUSTER EXTENSIONS
#############################################################################
variable "kubernetes_cluster_extensions" {
  description = "value to set the kubernetes cluster extensions"
  type = map(object({
    kubernetes_cluster_extension_name = string
    kubernetes_cluster_name           = optional(string)
    cluster_id                        = optional(string)
    extension_type                    = string
    configuration_settings            = optional(map(string))
    configuration_protected_settings  = optional(map(string))
    release_namespace                 = optional(string)
    release_train                     = optional(string)
    target_namespace                  = optional(string)
    extension_version                 = optional(string)
    plan = optional(object({
      name           = string
      product        = string
      publisher      = string
      promotion_code = optional(string)
      version        = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# KUBERNETES CLUSTER TRUSTED ACCESS ROLE BINDINGS
#############################################################################
variable "kubernetes_cluster_trusted_access_role_bindings" {
  description = "value to set the kubernetes cluster trusted access role bindings"
  type = map(object({
    kubernetes_cluster_trusted_access_role_binding_name = string
    kubernetes_cluster_name                             = optional(string)
    kubernetes_cluster_id                               = optional(string)
    roles                                               = list(string)
    source_resource_id                                  = string
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# KUBERNETES FLEET MANAGERS
#############################################################################
variable "kubernetes_fleet_managers" {
  description = "value to set the kubernetes fleet managers"
  type = map(object({
    kubernetes_fleet_manager_name = string
    resource_group_name           = optional(string)
    location                      = string
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = {}
}

#############################################################################
# KUBERNETES FLEET MEMBERS
#############################################################################
variable "kubernetes_fleet_members" {
  description = "value to set the kubernetes fleet members"
  type = map(object({
    kubernetes_fleet_member_name  = string
    kubernetes_fleet_manager_name = optional(string)
    kubernetes_fleet_id           = optional(string)
    kubernetes_cluster_name       = optional(string)
    kubernetes_cluster_id         = optional(string)
    group                         = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

#############################################################################
# KUBERNETES FLEET UPDATE STRATEGIES
#############################################################################
variable "kubernetes_fleet_update_strategies" {
  description = "value to set the kubernetes fleet update strategies"
  type = map(object({
    kubernetes_fleet_update_strategy_name = string
    kubernetes_fleet_manager_name         = optional(string)
    kubernetes_fleet_manager_id           = optional(string)
    stages = list(object({
      name                        = string
      after_stage_wait_in_seconds = optional(number)
      groups = list(object({
        name = string
      }))
    }))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}
