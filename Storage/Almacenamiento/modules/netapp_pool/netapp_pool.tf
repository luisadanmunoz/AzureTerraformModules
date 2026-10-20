#############################################################################
# NETAPP POOL
#############################################################################
resource "azurerm_netapp_pool" "netapp_pool" {
  name                    = var.netapp_pool_name
  account_name            = var.account_name
  resource_group_name     = var.resource_group_name
  location                = var.location
  service_level           = var.service_level
  size_in_tb              = var.size_in_tb
  cool_access_enabled     = var.cool_access_enabled
  custom_throughput_mibps = var.custom_throughput_mibps
  encryption_type         = var.encryption_type
  qos_type                = var.qos_type
  tags                    = var.tags

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
