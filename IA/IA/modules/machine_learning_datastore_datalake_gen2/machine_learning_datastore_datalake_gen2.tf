#############################################################################
# MACHINE LEARNING DATASTORE DATALAKE GEN2
#############################################################################
resource "azurerm_machine_learning_datastore_datalake_gen2" "machine_learning_datastore_datalake_gen2" {
  name                  = var.machine_learning_datastore_datalake_gen2_name
  workspace_id          = var.workspace_id
  storage_container_id  = var.storage_container_id
  authority_url         = var.authority_url
  client_id             = var.client_id
  client_secret         = var.client_secret
  description           = var.description
  service_data_identity = var.service_data_identity
  tenant_id             = var.tenant_id
  tags                  = var.tags

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      update = try(timeouts.value["update"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
