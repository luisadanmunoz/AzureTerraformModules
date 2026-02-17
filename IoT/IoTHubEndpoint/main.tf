################################################################################
# Azure IoT Hub Endpoint - Storage Container
################################################################################

resource "azurerm_iothub_endpoint_storage_container" "this" {
  count = var.create && var.storage_container_endpoint != null ? 1 : 0

  name                       = var.storage_container_endpoint.name
  iothub_id                  = var.iothub_id
  resource_group_name        = var.resource_group_name
  container_name             = var.storage_container_endpoint.container_name
  authentication_type        = var.storage_container_endpoint.authentication_type
  connection_string          = var.storage_container_endpoint.connection_string
  identity_id                = var.storage_container_endpoint.identity_id
  endpoint_uri               = var.storage_container_endpoint.endpoint_uri
  batch_frequency_in_seconds = var.storage_container_endpoint.batch_frequency_in_seconds
  max_chunk_size_in_bytes    = var.storage_container_endpoint.max_chunk_size_in_bytes
  encoding                   = var.storage_container_endpoint.encoding
  file_name_format           = var.storage_container_endpoint.file_name_format
}

################################################################################
# Azure IoT Hub Endpoint - Event Hub
################################################################################

resource "azurerm_iothub_endpoint_eventhub" "this" {
  count = var.create && var.eventhub_endpoint != null ? 1 : 0

  name                = var.eventhub_endpoint.name
  iothub_id           = var.iothub_id
  resource_group_name = var.resource_group_name
  authentication_type = var.eventhub_endpoint.authentication_type
  connection_string   = var.eventhub_endpoint.connection_string
  identity_id         = var.eventhub_endpoint.identity_id
  endpoint_uri        = var.eventhub_endpoint.endpoint_uri
  entity_path         = var.eventhub_endpoint.entity_path
}

################################################################################
# Azure IoT Hub Endpoint - Service Bus Queue
################################################################################

resource "azurerm_iothub_endpoint_servicebus_queue" "this" {
  count = var.create && var.servicebus_queue_endpoint != null ? 1 : 0

  name                = var.servicebus_queue_endpoint.name
  iothub_id           = var.iothub_id
  resource_group_name = var.resource_group_name
  authentication_type = var.servicebus_queue_endpoint.authentication_type
  connection_string   = var.servicebus_queue_endpoint.connection_string
  identity_id         = var.servicebus_queue_endpoint.identity_id
  endpoint_uri        = var.servicebus_queue_endpoint.endpoint_uri
  entity_path         = var.servicebus_queue_endpoint.entity_path
}

################################################################################
# Azure IoT Hub Endpoint - Service Bus Topic
################################################################################

resource "azurerm_iothub_endpoint_servicebus_topic" "this" {
  count = var.create && var.servicebus_topic_endpoint != null ? 1 : 0

  name                = var.servicebus_topic_endpoint.name
  iothub_id           = var.iothub_id
  resource_group_name = var.resource_group_name
  authentication_type = var.servicebus_topic_endpoint.authentication_type
  connection_string   = var.servicebus_topic_endpoint.connection_string
  identity_id         = var.servicebus_topic_endpoint.identity_id
  endpoint_uri        = var.servicebus_topic_endpoint.endpoint_uri
  entity_path         = var.servicebus_topic_endpoint.entity_path
}

################################################################################
# Azure IoT Hub Endpoint - Cosmos DB
################################################################################

resource "azurerm_iothub_endpoint_cosmosdb_account" "this" {
  count = var.create && var.cosmosdb_endpoint != null ? 1 : 0

  name                   = var.cosmosdb_endpoint.name
  iothub_id              = var.iothub_id
  resource_group_name    = var.resource_group_name
  container_name         = var.cosmosdb_endpoint.container_name
  database_name          = var.cosmosdb_endpoint.database_name
  authentication_type    = var.cosmosdb_endpoint.authentication_type
  primary_key            = var.cosmosdb_endpoint.primary_key
  secondary_key          = var.cosmosdb_endpoint.secondary_key
  identity_id            = var.cosmosdb_endpoint.identity_id
  endpoint_uri           = var.cosmosdb_endpoint.endpoint_uri
  partition_key_name     = var.cosmosdb_endpoint.partition_key_name
  partition_key_template = var.cosmosdb_endpoint.partition_key_template
}
