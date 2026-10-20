#############################################################################
# DIGITAL TWINS TIME SERIES DATABASE CONNECTIONS
#############################################################################
module "digital_twins_time_series_database_connection" {
  source = "./modules/digital_twins_time_series_database_connection"

  for_each = var.digital_twins_time_series_database_connections

  digital_twins_time_series_database_connection_name = each.value["digital_twins_time_series_database_connection_name"]
  digital_twins_id = try(
    element([for _, digital_twins in module.digital_twins_instance : digital_twins.id if digital_twins.name == each.value["digital_twins_instance_name"]], 0),
    each.value["digital_twins_id"]
  )
  eventhub_name                   = each.value["eventhub_name"]
  eventhub_namespace_endpoint_uri = each.value["eventhub_namespace_endpoint_uri"]
  eventhub_namespace_id           = each.value["eventhub_namespace_id"]
  eventhub_consumer_group_name    = try(each.value["eventhub_consumer_group_name"], null)
  kusto_cluster_id                = each.value["kusto_cluster_id"]
  kusto_cluster_uri               = each.value["kusto_cluster_uri"]
  kusto_database_name             = each.value["kusto_database_name"]
  kusto_table_name                = try(each.value["kusto_table_name"], null)
  timeouts                        = try(each.value["timeouts"], null)
}
