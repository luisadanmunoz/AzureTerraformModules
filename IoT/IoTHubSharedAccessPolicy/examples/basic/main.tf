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
  name     = "rg-iot-sap-example"
  location = "eastus"
}

################################################################################
# IoT Hub
################################################################################

module "iot_hub" {
  source = "../../../IoTHub"

  name                = "iot-hub-sap-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku_name     = "S1"
  sku_capacity = 1

  tags = {
    Environment = "Example"
  }
}

################################################################################
# IoT Hub Shared Access Policies
################################################################################

module "sap_service" {
  source = "../../"

  name                = "service-policy"
  iothub_name         = module.iot_hub.name
  resource_group_name = azurerm_resource_group.main.name

  registry_read   = true
  service_connect = true

  depends_on = [module.iot_hub]
}

module "sap_device" {
  source = "../../"

  name                = "device-policy"
  iothub_name         = module.iot_hub.name
  resource_group_name = azurerm_resource_group.main.name

  device_connect = true

  depends_on = [module.iot_hub]
}

module "sap_registry_manager" {
  source = "../../"

  name                = "registry-manager"
  iothub_name         = module.iot_hub.name
  resource_group_name = azurerm_resource_group.main.name

  registry_read  = true
  registry_write = true

  depends_on = [module.iot_hub]
}

################################################################################
# Outputs
################################################################################

output "service_policy_id" {
  description = "The ID of the service policy."
  value       = module.sap_service.id
}

output "device_policy_id" {
  description = "The ID of the device policy."
  value       = module.sap_device.id
}

output "registry_manager_policy_id" {
  description = "The ID of the registry manager policy."
  value       = module.sap_registry_manager.id
}

output "service_policy_connection_string" {
  description = "The connection string for the service policy."
  value       = module.sap_service.primary_connection_string
  sensitive   = true
}
