################################################################################
# Provider Configuration
################################################################################

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

################################################################################
# Resource Group
################################################################################

resource "azurerm_resource_group" "main" {
  name     = "rg-iot-endpoint-example"
  location = "eastus"
}

################################################################################
# IoT Hub
################################################################################

module "iot_hub" {
  source = "../../../IoTHub"

  name                = "iot-hub-endpoint-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku_name     = "S1"
  sku_capacity = 1

  identity_type = "SystemAssigned"

  tags = {
    Environment = "Example"
  }
}

################################################################################
# Storage Account
################################################################################

resource "azurerm_storage_account" "main" {
  name                     = "stiotendpointexample"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "main" {
  name                  = "iot-data"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

################################################################################
# IoT Hub Endpoint - Storage Container
################################################################################

module "iot_hub_endpoint_storage" {
  source = "../../"

  iothub_id           = module.iot_hub.id
  resource_group_name = azurerm_resource_group.main.name

  storage_container_endpoint = {
    name                       = "storage-endpoint"
    container_name             = azurerm_storage_container.main.name
    connection_string          = azurerm_storage_account.main.primary_blob_connection_string
    batch_frequency_in_seconds = 60
    max_chunk_size_in_bytes    = 10485760
    encoding                   = "JSON"
    file_name_format           = "{iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}"
  }

  depends_on = [
    module.iot_hub,
    azurerm_storage_container.main
  ]
}

################################################################################
# Outputs
################################################################################

output "storage_endpoint_id" {
  description = "The ID of the storage endpoint."
  value       = module.iot_hub_endpoint_storage.storage_container_endpoint_id
}

output "storage_endpoint_name" {
  description = "The name of the storage endpoint."
  value       = module.iot_hub_endpoint_storage.storage_container_endpoint_name
}
