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
  name     = "rg-iot-dps-example"
  location = "eastus"
}

################################################################################
# IoT Hub (for linking to DPS)
################################################################################

module "iot_hub" {
  source = "../../../IoTHub"

  name                = "iot-hub-for-dps-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku_name     = "S1"
  sku_capacity = 1

  tags = {
    Environment = "Example"
  }
}

################################################################################
# IoT Hub DPS - Basic Configuration
################################################################################

module "iot_hub_dps_basic" {
  source = "../../"

  name                = "iot-dps-basic-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku_name     = "S1"
  sku_capacity = 1

  allocation_policy = "Hashed"

  tags = {
    Environment = "Example"
    Purpose     = "BasicDemo"
  }
}

################################################################################
# IoT Hub DPS - With Linked Hub
################################################################################

module "iot_hub_dps_linked" {
  source = "../../"

  name                = "iot-dps-linked-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  allocation_policy = "Hashed"

  linked_hubs = [
    {
      connection_string       = module.iot_hub.shared_access_policy[0].primary_connection_string
      location                = azurerm_resource_group.main.location
      apply_allocation_policy = true
      allocation_weight       = 1
    }
  ]

  tags = {
    Environment = "Example"
    Purpose     = "LinkedHubDemo"
  }

  depends_on = [module.iot_hub]
}

################################################################################
# Outputs
################################################################################

output "basic_dps_id" {
  description = "The ID of the basic DPS."
  value       = module.iot_hub_dps_basic.id
}

output "basic_dps_id_scope" {
  description = "The ID scope of the basic DPS."
  value       = module.iot_hub_dps_basic.id_scope
}

output "linked_dps_device_provisioning_host_name" {
  description = "The device provisioning host name of the linked DPS."
  value       = module.iot_hub_dps_linked.device_provisioning_host_name
}
