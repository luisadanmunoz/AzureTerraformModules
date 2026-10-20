#############################################################################
# CONTAINER APP ENVIRONMENT STORAGE
#############################################################################
resource "azurerm_container_app_environment_storage" "container_app_environment_storage" {
  name                         = var.container_app_environment_storage_name
  container_app_environment_id = var.container_app_environment_id
  account_name                 = var.account_name
  access_key                   = var.access_key
  share_name                   = var.share_name
  access_mode                  = var.access_mode
  nfs_server_url               = var.nfs_server_url

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
