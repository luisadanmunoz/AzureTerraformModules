################################################################################
# Azure Kubernetes Service (AKS)
################################################################################

# DEPENDENCY: Resource Group must exist
# DEPENDENCY: Subnet must exist (if using Azure CNI)

resource "azurerm_kubernetes_cluster" "this" {
  count = var.create ? 1 : 0

  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  dns_prefix          = local.dns_prefix

  kubernetes_version            = var.kubernetes_version
  sku_tier                      = var.sku_tier
  private_cluster_enabled       = var.private_cluster_enabled
  private_dns_zone_id           = var.private_dns_zone_id
  automatic_upgrade_channel     = var.automatic_upgrade_channel
  azure_policy_enabled          = var.azure_policy_enabled
  local_account_disabled        = var.local_account_disabled

  # Default Node Pool
  default_node_pool {
    name                         = var.default_node_pool.name
    vm_size                      = var.default_node_pool.vm_size
    node_count                   = var.default_node_pool.enable_auto_scaling ? null : var.default_node_pool.node_count
    min_count                    = var.default_node_pool.enable_auto_scaling ? var.default_node_pool.min_count : null
    max_count                    = var.default_node_pool.enable_auto_scaling ? var.default_node_pool.max_count : null
    auto_scaling_enabled         = var.default_node_pool.enable_auto_scaling
    os_disk_size_gb              = var.default_node_pool.os_disk_size_gb
    os_disk_type                 = var.default_node_pool.os_disk_type
    os_sku                       = var.default_node_pool.os_sku
    zones                        = var.default_node_pool.zones
    vnet_subnet_id               = var.default_node_pool.vnet_subnet_id
    max_pods                     = var.default_node_pool.max_pods
    only_critical_addons_enabled = var.default_node_pool.only_critical_addons_enabled
    node_labels                  = var.default_node_pool.node_labels
    //node_taints                  = var.default_node_pool.node_taints
  }

  # Network Profile
  network_profile {
    network_plugin      = var.network_profile.network_plugin
    network_plugin_mode = var.network_profile.network_plugin_mode
    network_policy      = var.network_profile.network_policy
    dns_service_ip      = var.network_profile.dns_service_ip
    service_cidr        = var.network_profile.service_cidr
    pod_cidr            = var.network_profile.pod_cidr
    outbound_type       = var.network_profile.outbound_type
    load_balancer_sku   = var.network_profile.load_balancer_sku
  }

  # Identity
  identity {
    type         = var.identity.type
    identity_ids = var.identity.type == "UserAssigned" ? var.identity.identity_ids : null
  }

  # Azure AD RBAC
  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.azure_active_directory_role_based_access_control != null ? [var.azure_active_directory_role_based_access_control] : []
    content {
      azure_rbac_enabled     = azure_active_directory_role_based_access_control.value.azure_rbac_enabled
      admin_group_object_ids = azure_active_directory_role_based_access_control.value.admin_group_object_ids
      tenant_id              = azure_active_directory_role_based_access_control.value.tenant_id
    }
  }

  # OMS Agent (Container Insights)
  dynamic "oms_agent" {
    for_each = var.oms_agent != null && var.oms_agent.enabled ? [var.oms_agent] : []
    content {
      log_analytics_workspace_id = oms_agent.value.log_analytics_workspace_id
    }
  }

  # Key Vault Secrets Provider
  dynamic "key_vault_secrets_provider" {
    for_each = var.key_vault_secrets_provider != null && var.key_vault_secrets_provider.enabled ? [var.key_vault_secrets_provider] : []
    content {
      secret_rotation_enabled  = key_vault_secrets_provider.value.secret_rotation_enabled
      secret_rotation_interval = key_vault_secrets_provider.value.secret_rotation_interval
    }
  }

  # Application Gateway Ingress Controller
  dynamic "ingress_application_gateway" {
    for_each = var.ingress_application_gateway != null && var.ingress_application_gateway.enabled ? [var.ingress_application_gateway] : []
    content {
      gateway_id = ingress_application_gateway.value.gateway_id
      subnet_id  = ingress_application_gateway.value.subnet_id
    }
  }

  # Maintenance Window
  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? [var.maintenance_window] : []
    content {
      dynamic "allowed" {
        for_each = maintenance_window.value.allowed
        content {
          day   = allowed.value.day
          hours = allowed.value.hours
        }
      }
      dynamic "not_allowed" {
        for_each = maintenance_window.value.not_allowed
        content {
          start = not_allowed.value.start
          end   = not_allowed.value.end
        }
      }
    }
  }

  tags = local.tags
}

################################################################################
# Additional Node Pools
################################################################################

resource "azurerm_kubernetes_cluster_node_pool" "this" {
  for_each = var.create ? { for np in var.node_pools : np.name => np } : {}

  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this[0].id
  vm_size               = each.value.vm_size
  node_count            = each.value.enable_auto_scaling ? null : each.value.node_count
  min_count             = each.value.enable_auto_scaling ? each.value.min_count : null
  max_count             = each.value.enable_auto_scaling ? each.value.max_count : null
  auto_scaling_enabled  = each.value.enable_auto_scaling
  os_disk_size_gb       = each.value.os_disk_size_gb
  os_disk_type          = each.value.os_disk_type
  os_type               = each.value.os_type
  zones                 = each.value.zones
  vnet_subnet_id        = each.value.vnet_subnet_id
  max_pods              = each.value.max_pods
  mode                  = each.value.mode
  node_labels           = each.value.node_labels
  node_taints           = each.value.node_taints
  priority              = each.value.priority
  spot_max_price        = each.value.priority == "Spot" ? each.value.spot_max_price : null
  eviction_policy       = each.value.priority == "Spot" ? each.value.eviction_policy : null

  tags = local.tags
}
