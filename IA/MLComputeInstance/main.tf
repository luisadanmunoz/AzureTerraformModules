################################################################################
# Azure Machine Learning Compute Instance
################################################################################

resource "azurerm_machine_learning_compute_instance" "this" {
  count = var.create ? 1 : 0

  name                          = var.name
  machine_learning_workspace_id = var.machine_learning_workspace_id
  virtual_machine_size          = var.virtual_machine_size

  authorization_type     = var.authorization_type
  description            = var.description
  local_auth_enabled     = var.local_auth_enabled
  node_public_ip_enabled = var.node_public_ip_enabled
  subnet_resource_id     = var.subnet_resource_id

  dynamic "ssh" {
    for_each = var.ssh != null ? [var.ssh] : []
    content {
      public_key = ssh.value.public_key
    }
  }

  dynamic "assign_to_user" {
    for_each = var.assign_to_user != null ? [var.assign_to_user] : []
    content {
      object_id = assign_to_user.value.object_id
      tenant_id = assign_to_user.value.tenant_id
    }
  }

  tags = local.tags
}
