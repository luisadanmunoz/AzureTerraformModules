##############################################################################
# AKS
##############################################################################
resource "azurerm_kubernetes_cluster" "aks" {
  name                       = var.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  node_resource_group        = var.node_resource_group
  dns_prefix_private_cluster = var.dns_prefix_private_cluster
  private_cluster_enabled    = true
  private_dns_zone_id        = var.private_dns_zone_id

  identity {
    type         = "UserAssigned"
    identity_ids = var.identity_ids
  }

  default_node_pool {
    name           = "default"
    node_count     = 2
    vm_size        = "Standard_D2_v2"
    vnet_subnet_id = var.vnet_subnet_id
  }

  network_profile {
    network_plugin = "kubenet"
    network_policy = "calico"
    dns_service_ip = "10.52.4.100"
    //docker_bridge_cidr = "10.52.3.0/22"
    service_cidr = "10.52.4.0/24"
    pod_cidrs    = ["10.53.0.0/22"] //10.55.0.0/22
  }

  ingress_application_gateway {
    gateway_id = var.gateway_id
  }

  tags = var.tags

  depends_on = [azurerm_role_assignment.dns_zone_contributor, azurerm_role_assignment.network_contributor]

}
#############################################################################
# ROLE ASSIGMENT - DNS
#############################################################################
resource "azurerm_role_assignment" "dns_zone_contributor" {
  scope                = var.scope_dns
  role_definition_name = "DNS Zone Contributor"

  principal_id = var.principal_id_identity
}
#############################################################################
# ROLE ASSIGMENT - RG
#############################################################################
resource "azurerm_role_assignment" "network_contributor" {
  scope                = var.scope_rg
  role_definition_name = "Network Contributor"

  principal_id = var.principal_id_identity
}