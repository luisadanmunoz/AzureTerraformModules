################################################################################
# Azure Machine Learning Compute Cluster
################################################################################

resource "azurerm_machine_learning_compute_cluster" "this" {
  count = var.create ? 1 : 0

  name                          = var.name
  machine_learning_workspace_id = var.machine_learning_workspace_id
  location                      = var.location
  vm_size                       = var.vm_size
  vm_priority                   = var.vm_priority

  subnet_resource_id     = var.subnet_resource_id
  local_auth_enabled     = var.local_auth_enabled
  node_public_ip_enabled = var.node_public_ip_enabled

  ssh_public_access_enabled = var.ssh_public_access_enabled

  scale_settings {
    min_node_count                       = var.min_node_count
    max_node_count                       = var.max_node_count
    scale_down_nodes_after_idle_duration = var.scale_down_nodes_after_idle_duration
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  dynamic "ssh" {
    for_each = var.ssh != null ? [var.ssh] : []
    content {
      admin_username = ssh.value.admin_username
      admin_password = ssh.value.admin_password
      key_value      = ssh.value.key_value
    }
  }

  tags = local.tags
}
