#############################################################################
# MACHINE LEARNING SYNAPSE SPARK
#############################################################################
resource "azurerm_machine_learning_synapse_spark" "machine_learning_synapse_spark" {
  name                          = var.machine_learning_synapse_spark_name
  machine_learning_workspace_id = var.machine_learning_workspace_id
  location                      = var.location
  synapse_spark_pool_id         = var.synapse_spark_pool_id
  description                   = var.description
  local_auth_enabled            = var.local_auth_enabled
  tags                          = var.tags

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = try(identity.value["identity_ids"], null)
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
}
