################################################################################
# General
################################################################################

variable "create" {
  description = "Controls whether to create the AKS cluster."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the AKS cluster should exist."
  type        = string
}

################################################################################
# Naming
################################################################################

variable "name" {
  description = "(Optional) The name of the AKS cluster. If not provided, a name will be generated."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Prefix for the generated name. Default: 'aks'."
  type        = string
  default     = "aks"
}

variable "workload" {
  description = "(Optional) Workload name for the naming convention."
  type        = string
  default     = "app"
}

variable "environment" {
  description = "(Optional) Environment name (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "instance" {
  description = "(Optional) Instance number for the naming convention."
  type        = string
  default     = "001"
}

variable "dns_prefix" {
  description = "(Optional) DNS prefix for the cluster. If not provided, uses the cluster name."
  type        = string
  default     = null
}

################################################################################
# Cluster Configuration
################################################################################

variable "kubernetes_version" {
  description = "(Optional) Kubernetes version. If not specified, latest is used."
  type        = string
  default     = null
}

variable "sku_tier" {
  description = "(Optional) SKU tier. Values: Free, Standard, Premium. Default: Free."
  type        = string
  default     = "Free"

  validation {
    condition     = contains(["Free", "Standard", "Premium"], var.sku_tier)
    error_message = "sku_tier must be Free, Standard, or Premium."
  }
}

variable "private_cluster_enabled" {
  description = "(Optional) Enable private cluster. Default: false."
  type        = bool
  default     = false
}

variable "private_dns_zone_id" {
  description = "(Optional) Private DNS Zone ID for private cluster. DEPENDENCY: Private DNS Zone must exist."
  type        = string
  default     = null
}

variable "automatic_upgrade_channel" {
  description = "(Optional) Upgrade channel. Values: none, patch, rapid, stable, node-image."
  type        = string
  default     = "stable"
}

variable "azure_policy_enabled" {
  description = "(Optional) Enable Azure Policy add-on. Default: false."
  type        = bool
  default     = false
}

variable "local_account_disabled" {
  description = "(Optional) Disable local accounts. Default: false."
  type        = bool
  default     = false
}

################################################################################
# Default Node Pool
################################################################################

variable "default_node_pool" {
  description = <<-EOT
    (Required) Default node pool configuration.
    - name: Node pool name. Default: system.
    - vm_size: VM size. Default: Standard_D2s_v5.
    - node_count: Number of nodes (if autoscaling disabled).
    - min_count: Minimum nodes (if autoscaling enabled).
    - max_count: Maximum nodes (if autoscaling enabled).
    - enable_auto_scaling: Enable autoscaling. Default: true.
    - os_disk_size_gb: OS disk size in GB.
    - os_disk_type: Managed, Ephemeral. Default: Managed.
    - os_sku: Ubuntu, AzureLinux, Windows2019, Windows2022. Default: Ubuntu.
    - zones: Availability zones.
    - vnet_subnet_id: Subnet ID for nodes.
    - max_pods: Max pods per node. Default: 30.
    - only_critical_addons_enabled: Only schedule critical add-ons.
  EOT
  type = object({
    name                         = optional(string, "system")
    vm_size                      = optional(string, "Standard_D2s_v5")
    node_count                   = optional(number, null)
    min_count                    = optional(number, 1)
    max_count                    = optional(number, 3)
    enable_auto_scaling          = optional(bool, true)
    os_disk_size_gb              = optional(number, 128)
    os_disk_type                 = optional(string, "Managed")
    os_sku                       = optional(string, "Ubuntu")
    zones                        = optional(list(string), ["1", "2", "3"])
    vnet_subnet_id               = optional(string, null)
    max_pods                     = optional(number, 30)
    only_critical_addons_enabled = optional(bool, false)
    node_labels                  = optional(map(string), {})
    node_taints                  = optional(list(string), [])
  })
  default = {}
}

################################################################################
# Additional Node Pools
################################################################################

variable "node_pools" {
  description = "(Optional) Additional node pools."
  type = list(object({
    name                 = string
    vm_size              = optional(string, "Standard_D2s_v5")
    node_count           = optional(number, null)
    min_count            = optional(number, 1)
    max_count            = optional(number, 3)
    enable_auto_scaling  = optional(bool, true)
    os_disk_size_gb      = optional(number, 128)
    os_disk_type         = optional(string, "Managed")
    os_type              = optional(string, "Linux")
    zones                = optional(list(string), ["1", "2", "3"])
    vnet_subnet_id       = optional(string, null)
    max_pods             = optional(number, 30)
    mode                 = optional(string, "User")
    node_labels          = optional(map(string), {})
    node_taints          = optional(list(string), [])
    priority             = optional(string, "Regular")
    spot_max_price       = optional(number, -1)
    eviction_policy      = optional(string, "Delete")
  }))
  default = []
}

################################################################################
# Network Configuration
################################################################################

variable "network_profile" {
  description = <<-EOT
    (Optional) Network profile configuration.
    - network_plugin: azure, kubenet, none. Default: azure.
    - network_plugin_mode: overlay (for azure CNI overlay).
    - network_policy: azure, calico. Default: azure.
    - dns_service_ip: DNS service IP.
    - service_cidr: Service CIDR.
    - pod_cidr: Pod CIDR (for kubenet).
    - outbound_type: loadBalancer, userDefinedRouting, managedNATGateway.
    - load_balancer_sku: basic, standard. Default: standard.
  EOT
  type = object({
    network_plugin      = optional(string, "azure")
    network_plugin_mode = optional(string, null)
    network_policy      = optional(string, "azure")
    dns_service_ip      = optional(string, null)
    service_cidr        = optional(string, null)
    pod_cidr            = optional(string, null)
    outbound_type       = optional(string, "loadBalancer")
    load_balancer_sku   = optional(string, "standard")
  })
  default = {}
}

################################################################################
# Identity
################################################################################

variable "identity" {
  description = <<-EOT
    (Optional) Identity configuration.
    - type: SystemAssigned, UserAssigned. Default: SystemAssigned.
    - identity_ids: User Assigned Identity IDs.
  EOT
  type = object({
    type         = optional(string, "SystemAssigned")
    identity_ids = optional(list(string), [])
  })
  default = {}
}

################################################################################
# Azure AD Integration
################################################################################

variable "azure_active_directory_role_based_access_control" {
  description = <<-EOT
    (Optional) Azure AD RBAC configuration.
    - azure_rbac_enabled: Enable Azure RBAC for Kubernetes. Default: true.
    - admin_group_object_ids: Admin group IDs.
    - tenant_id: Azure AD tenant ID.
  EOT
  type = object({
    azure_rbac_enabled      = optional(bool, true)
    admin_group_object_ids  = optional(list(string), [])
    tenant_id               = optional(string, null)
  })
  default = null
}

################################################################################
# Add-ons
################################################################################

variable "oms_agent" {
  description = <<-EOT
    (Optional) OMS Agent (Container Insights) configuration.
    - enabled: Enable OMS agent. Default: false.
    - log_analytics_workspace_id: Log Analytics Workspace ID.
  EOT
  type = object({
    enabled                    = optional(bool, false)
    log_analytics_workspace_id = string
  })
  default = null
}

variable "key_vault_secrets_provider" {
  description = <<-EOT
    (Optional) Key Vault Secrets Provider configuration.
    - enabled: Enable secrets provider. Default: false.
    - secret_rotation_enabled: Enable secret rotation.
    - secret_rotation_interval: Rotation interval.
  EOT
  type = object({
    enabled                  = optional(bool, false)
    secret_rotation_enabled  = optional(bool, true)
    secret_rotation_interval = optional(string, "2m")
  })
  default = null
}

variable "ingress_application_gateway" {
  description = <<-EOT
    (Optional) Application Gateway Ingress Controller configuration.
    - enabled: Enable AGIC. Default: false.
    - gateway_id: Existing App Gateway ID.
    - subnet_id: Subnet for new App Gateway.
  EOT
  type = object({
    enabled    = optional(bool, false)
    gateway_id = optional(string, null)
    subnet_id  = optional(string, null)
  })
  default = null
}

################################################################################
# Maintenance Window
################################################################################

variable "maintenance_window" {
  description = <<-EOT
    (Optional) Maintenance window configuration.
    - allowed: List of allowed maintenance windows.
    - not_allowed: List of disallowed maintenance windows.
  EOT
  type = object({
    allowed = optional(list(object({
      day   = string
      hours = list(number)
    })), [])
    not_allowed = optional(list(object({
      start = string
      end   = string
    })), [])
  })
  default = null
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
