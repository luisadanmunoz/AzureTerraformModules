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
  name     = "rg-iot-route-example"
  location = "eastus"
}

################################################################################
# Storage Account
################################################################################

resource "azurerm_storage_account" "main" {
  name                     = "stiotrouteexample"
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
# IoT Hub
################################################################################

module "iot_hub" {
  source = "../../../IoTHub"

  name                = "iot-hub-route-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku_name     = "S1"
  sku_capacity = 1

  tags = {
    Environment = "Example"
  }
}

################################################################################
# IoT Hub Endpoint
################################################################################

module "iot_hub_endpoint" {
  source = "../../../IoTHubEndpoint"

  iothub_id           = module.iot_hub.id
  resource_group_name = azurerm_resource_group.main.name

  storage_container_endpoint = {
    name                       = "storage-endpoint"
    container_name             = azurerm_storage_container.main.name
    connection_string          = azurerm_storage_account.main.primary_blob_connection_string
    batch_frequency_in_seconds = 60
    encoding                   = "JSON"
  }

  depends_on = [
    module.iot_hub,
    azurerm_storage_container.main
  ]
}

################################################################################
# IoT Hub Routes
################################################################################

module "iot_hub_route_telemetry" {
  source = "../../"

  name                = "telemetry-to-storage"
  iothub_name         = module.iot_hub.name
  resource_group_name = azurerm_resource_group.main.name
  source_type         = "DeviceMessages"
  endpoint_names      = [module.iot_hub_endpoint.storage_container_endpoint_name]
  condition           = "true"
  enabled             = true

  depends_on = [module.iot_hub_endpoint]
}

module "iot_hub_route_critical" {
  source = "../../"

  name                = "critical-alerts"
  iothub_name         = module.iot_hub.name
  resource_group_name = azurerm_resource_group.main.name
  source_type         = "DeviceMessages"
  endpoint_names      = [module.iot_hub_endpoint.storage_container_endpoint_name]
  condition           = "$body.severity = 'critical'"
  enabled             = true

  depends_on = [module.iot_hub_endpoint]
}

################################################################################
# Outputs
################################################################################

output "telemetry_route_id" {
  description = "The ID of the telemetry route."
  value       = module.iot_hub_route_telemetry.id
}

output "critical_route_id" {
  description = "The ID of the critical alerts route."
  value       = module.iot_hub_route_critical.id
}
