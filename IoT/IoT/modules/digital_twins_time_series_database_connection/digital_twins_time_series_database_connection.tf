#############################################################################
# DIGITAL TWINS TIME SERIES DATABASE CONNECTION
#############################################################################
resource "azurerm_digital_twins_time_series_database_connection" "digital_twins_time_series_database_connection" {
  name                            = var.digital_twins_time_series_database_connection_name
  digital_twins_id                = var.digital_twins_id
  eventhub_name                   = var.eventhub_name
  eventhub_namespace_endpoint_uri = var.eventhub_namespace_endpoint_uri
  eventhub_namespace_id           = var.eventhub_namespace_id
  eventhub_consumer_group_name    = var.eventhub_consumer_group_name
  kusto_cluster_id                = var.kusto_cluster_id
  kusto_cluster_uri               = var.kusto_cluster_uri
  kusto_database_name             = var.kusto_database_name
  kusto_table_name                = var.kusto_table_name

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = try(timeouts.value["create"], null)
      read   = try(timeouts.value["read"], null)
      delete = try(timeouts.value["delete"], null)
    }
  }
}
