#############################################################################
# MACHINE LEARNING COMPUTE CLUSTER
#############################################################################
resource "azurerm_machine_learning_compute_cluster" "machine_learning_compute_cluster" {
  name                          = var.machine_learning_compute_cluster_name
  machine_learning_workspace_id = var.machine_learning_workspace_id
  location                      = var.location
  vm_priority                   = var.vm_priority
  vm_size                       = var.vm_size
  description                   = var.description
  local_auth_enabled            = var.local_auth_enabled
  node_public_ip_enabled        = var.node_public_ip_enabled
  ssh_public_access_enabled     = var.ssh_public_access_enabled
  subnet_resource_id            = var.subnet_resource_id
  tags                          = var.tags

  scale_settings {
    max_node_count                       = var.scale_settings["max_node_count"]
    min_node_count                       = var.scale_settings["min_node_count"]
    scale_down_nodes_after_idle_duration = var.scale_settings["scale_down_nodes_after_idle_duration"]
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = try(identity.value["identity_ids"], null)
    }
  }

  dynamic "ssh" {
    for_each = var.ssh != null ? [var.ssh] : []

    content {
      admin_username = ssh.value["admin_username"]
      admin_password = try(ssh.value["admin_password"], null)
      key_value      = try(ssh.value["key_value"], null)
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
      condition = (
        var.ssh == null ||
        try(var.ssh["admin_password"], null) != null ||
        try(var.ssh["key_value"], null) != null
      )
      error_message = "When ssh is specified, at least one of admin_password or key_value must be set."
    }
  }
}
