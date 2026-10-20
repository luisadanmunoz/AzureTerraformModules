################################################################################
# Azure Arc-enabled Kubernetes Cluster
################################################################################

resource "azurerm_arc_kubernetes_cluster" "this" {
  count = var.create ? 1 : 0

  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  agent_public_key_certificate = var.agent_public_key_certificate

  identity {
    type = var.identity_type
  }

  tags = local.tags
}
