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
  name     = "rg-iot-consumer-group-example"
  location = "eastus"
}

################################################################################
# IoT Hub
################################################################################

module "iot_hub" {
  source = "../../../IoTHub"

  name                = "iot-hub-cg-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku_name     = "S1"
  sku_capacity = 1

  tags = {
    Environment = "Example"
  }
}

################################################################################
# IoT Hub Consumer Groups
################################################################################

module "consumer_group_analytics" {
  source = "../../"

  name                   = "analytics-consumer"
  iothub_name            = module.iot_hub.name
  resource_group_name    = azurerm_resource_group.main.name
  eventhub_endpoint_name = "events"

  depends_on = [module.iot_hub]
}

module "consumer_group_processing" {
  source = "../../"

  name                   = "processing-consumer"
  iothub_name            = module.iot_hub.name
  resource_group_name    = azurerm_resource_group.main.name
  eventhub_endpoint_name = "events"

  depends_on = [module.iot_hub]
}

################################################################################
# Outputs
################################################################################

output "analytics_consumer_group_id" {
  description = "The ID of the analytics consumer group."
  value       = module.consumer_group_analytics.id
}

output "processing_consumer_group_id" {
  description = "The ID of the processing consumer group."
  value       = module.consumer_group_processing.id
}
