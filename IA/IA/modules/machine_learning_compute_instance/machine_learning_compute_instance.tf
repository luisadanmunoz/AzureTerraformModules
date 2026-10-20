#############################################################################
# MACHINE LEARNING COMPUTE INSTANCE
#############################################################################
resource "azurerm_machine_learning_compute_instance" "machine_learning_compute_instance" {
  name                          = var.machine_learning_compute_instance_name
  machine_learning_workspace_id = var.machine_learning_workspace_id
  virtual_machine_size          = var.virtual_machine_size
  authorization_type            = var.authorization_type
  description                   = var.description
  local_auth_enabled            = var.local_auth_enabled
  node_public_ip_enabled        = var.node_public_ip_enabled
  subnet_resource_id            = var.subnet_resource_id
  tags                          = var.tags

  dynamic "assign_to_user" {
    for_each = var.assign_to_user != null ? [var.assign_to_user] : []

    content {
      object_id = try(assign_to_user.value["object_id"], null)
      tenant_id = try(assign_to_user.value["tenant_id"], null)
    }
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
      public_key = ssh.value["public_key"]
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }

  lifecycle {
    precondition {
      condition = (
        coalesce(var.node_public_ip_enabled, true) == true ||
        var.subnet_resource_id != null
      )
      error_message = "subnet_resource_id is required when node_public_ip_enabled is false."
    }
  }
}
