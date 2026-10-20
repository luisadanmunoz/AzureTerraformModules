#############################################################################
# VARIABLES KUBERNETES CLUSTER NODE POOL
#############################################################################
variable "kubernetes_cluster_node_pool_name" {
  description = "value to set the kubernetes cluster node pool name"
  type        = string
}

variable "kubernetes_cluster_id" {
  description = "value to set the kubernetes cluster id"
  type        = string
}

variable "vm_size" {
  description = "value to set the vm size"
  type        = string
  default     = null
}

variable "node_count" {
  description = "value to set the node count"
  type        = number
  default     = null
}

variable "auto_scaling_enabled" {
  description = "value to set the auto scaling enabled"
  type        = bool
  default     = null
}

variable "min_count" {
  description = "value to set the min count"
  type        = number
  default     = null
}

variable "max_count" {
  description = "value to set the max count"
  type        = number
  default     = null
}

variable "max_pods" {
  description = "value to set the max pods"
  type        = number
  default     = null
}

variable "mode" {
  description = "value to set the mode"
  type        = string
  default     = null
}

variable "node_labels" {
  description = "value to set the node labels"
  type        = map(string)
  default     = null
}

variable "node_public_ip_enabled" {
  description = "value to set the node public ip enabled"
  type        = bool
  default     = null
}

variable "node_public_ip_prefix_id" {
  description = "value to set the node public ip prefix id"
  type        = string
  default     = null
}

variable "node_taints" {
  description = "value to set the node taints"
  type        = list(string)
  default     = null
}

variable "orchestrator_version" {
  description = "value to set the orchestrator version"
  type        = string
  default     = null
}

variable "os_disk_size_gb" {
  description = "value to set the os disk size gb"
  type        = number
  default     = null
}

variable "os_disk_type" {
  description = "value to set the os disk type"
  type        = string
  default     = null
}

variable "os_sku" {
  description = "value to set the os sku"
  type        = string
  default     = null
}

variable "os_type" {
  description = "value to set the os type"
  type        = string
  default     = null
}

variable "pod_subnet_id" {
  description = "value to set the pod subnet id"
  type        = string
  default     = null
}

variable "priority" {
  description = "value to set the priority"
  type        = string
  default     = null
}

variable "scale_down_mode" {
  description = "value to set the scale down mode"
  type        = string
  default     = null
}

variable "spot_max_price" {
  description = "value to set the spot max price"
  type        = number
  default     = null
}

variable "temporary_name_for_rotation" {
  description = "value to set the temporary name for rotation"
  type        = string
  default     = null
}

variable "ultra_ssd_enabled" {
  description = "value to set the ultra ssd enabled"
  type        = bool
  default     = null
}

variable "vnet_subnet_id" {
  description = "value to set the vnet subnet id"
  type        = string
  default     = null
}

variable "workload_runtime" {
  description = "value to set the workload runtime"
  type        = string
  default     = null
}

variable "zones" {
  description = "value to set the zones"
  type        = list(string)
  default     = null
}

variable "kubelet_config" {
  description = "value to set the kubelet config"
  type = object({
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
  })
  default = null
}

variable "linux_os_config" {
  description = "value to set the linux os config"
  type = object({
    swap_file_size_mb            = optional(number)
    transparent_huge_page        = optional(string)
    transparent_huge_page_defrag = optional(string)
  })
  default = null
}

variable "upgrade_settings" {
  description = "value to set the upgrade settings"
  type = object({
    max_surge                     = string
    drain_timeout_in_minutes      = optional(number)
    node_soak_duration_in_minutes = optional(number)
    undrainable_node_behavior     = optional(string)
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
