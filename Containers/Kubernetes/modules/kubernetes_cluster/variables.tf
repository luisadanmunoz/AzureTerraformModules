#############################################################################
# VARIABLES KUBERNETES CLUSTER
#############################################################################
variable "kubernetes_cluster_name" {
  description = "value to set the kubernetes cluster name"
  type        = string
}

variable "resource_group_name" {
  description = "value to set the resource group name"
  type        = string
}

variable "location" {
  description = "value to set the location"
  type        = string
}

variable "dns_prefix" {
  description = "value to set the dns prefix"
  type        = string
  default     = null
}

variable "dns_prefix_private_cluster" {
  description = "value to set the dns prefix private cluster"
  type        = string
  default     = null
}

variable "kubernetes_version" {
  description = "value to set the kubernetes version"
  type        = string
  default     = null
}

variable "automatic_upgrade_channel" {
  description = "value to set the automatic upgrade channel"
  type        = string
  default     = null
}

variable "azure_policy_enabled" {
  description = "value to set the azure policy enabled"
  type        = bool
  default     = null
}

variable "cost_analysis_enabled" {
  description = "value to set the cost analysis enabled"
  type        = bool
  default     = null
}

variable "image_cleaner_enabled" {
  description = "value to set the image cleaner enabled"
  type        = bool
  default     = null
}

variable "image_cleaner_interval_hours" {
  description = "value to set the image cleaner interval hours"
  type        = number
  default     = null
}

variable "local_account_disabled" {
  description = "value to set the local account disabled"
  type        = bool
  default     = null
}

variable "node_os_upgrade_channel" {
  description = "value to set the node os upgrade channel"
  type        = string
  default     = null
}

variable "oidc_issuer_enabled" {
  description = "value to set the oidc issuer enabled"
  type        = bool
  default     = null
}

variable "private_cluster_enabled" {
  description = "value to set the private cluster enabled"
  type        = bool
  default     = null
}

variable "private_cluster_public_fqdn_enabled" {
  description = "value to set the private cluster public fqdn enabled"
  type        = bool
  default     = null
}

variable "private_dns_zone_id" {
  description = "value to set the private dns zone id"
  type        = string
  default     = null
}

variable "role_based_access_control_enabled" {
  description = "value to set the role based access control enabled"
  type        = bool
  default     = null
}

variable "run_command_enabled" {
  description = "value to set the run command enabled"
  type        = bool
  default     = null
}

variable "sku_tier" {
  description = "value to set the sku tier"
  type        = string
  default     = null
}

variable "support_plan" {
  description = "value to set the support plan"
  type        = string
  default     = null
}

variable "workload_identity_enabled" {
  description = "value to set the workload identity enabled"
  type        = bool
  default     = null
}

variable "api_server_access_profile" {
  description = "value to set the api server access profile"
  type = object({
    authorized_ip_ranges                = optional(list(string))
    subnet_id                           = optional(string)
    virtual_network_integration_enabled = optional(bool)
  })
  default = null
}

variable "azure_active_directory_role_based_access_control" {
  description = "value to set the azure active directory role based access control"
  type = object({
    admin_group_object_ids = optional(list(string))
    azure_rbac_enabled     = optional(bool)
    tenant_id              = optional(string)
  })
  default = null
}

variable "default_node_pool" {
  description = "value to set the default node pool"
  type = object({
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
}

variable "identity" {
  description = "value to set the identity"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "service_principal" {
  description = "value to set the service principal"
  type = object({
    client_id     = string
    client_secret = string
  })
  default   = null
  sensitive = true
}

variable "linux_profile" {
  description = "value to set the linux profile"
  type = object({
    admin_username = string
    ssh_key = object({
      key_data = string
    })
  })
  default = null
}

variable "network_profile" {
  description = "value to set the network profile"
  type = object({
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
  })
  default = null
}

variable "oms_agent" {
  description = "value to set the oms agent"
  type = object({
    log_analytics_workspace_id      = string
    msi_auth_for_monitoring_enabled = optional(bool)
  })
  default = null
}

variable "microsoft_defender" {
  description = "value to set the microsoft defender"
  type = object({
    log_analytics_workspace_id = string
  })
  default = null
}

variable "storage_profile" {
  description = "value to set the storage profile"
  type = object({
    blob_driver_enabled         = optional(bool)
    disk_driver_enabled         = optional(bool)
    file_driver_enabled         = optional(bool)
    snapshot_controller_enabled = optional(bool)
  })
  default = null
}

variable "workload_autoscaler_profile" {
  description = "value to set the workload autoscaler profile"
  type = object({
    keda_enabled                    = optional(bool)
    vertical_pod_autoscaler_enabled = optional(bool)
  })
  default = null
}

variable "timeouts" {
  description = "value to set the timeouts"
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

variable "tags" {
  description = "value to set the tags"
  type        = map(string)
  default     = {}
}
