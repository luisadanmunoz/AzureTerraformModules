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
  name     = "rg-iot-hub-example"
  location = "eastus"
}

################################################################################
# IoT Hub - Basic Configuration
################################################################################

module "iot_hub_basic" {
  source = "../../"

  name                = "iot-hub-basic-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku_name     = "S1"
  sku_capacity = 1

  tags = {
    Environment = "Example"
    Purpose     = "BasicDemo"
  }
}

################################################################################
# IoT Hub - With Cloud-to-Device and Identity
################################################################################

module "iot_hub_advanced" {
  source = "../../"

  name                = "iot-hub-advanced-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  sku_name     = "S1"
  sku_capacity = 1

  min_tls_version              = "1.2"
  local_authentication_enabled = true

  cloud_to_device = {
    max_delivery_count = 10
    default_ttl        = "PT1H"
    feedback = {
      time_to_live       = "PT1H"
      max_delivery_count = 10
      lock_duration      = "PT60S"
    }
  }

  identity_type = "SystemAssigned"

  tags = {
    Environment = "Example"
    Purpose     = "AdvancedDemo"
  }
}

################################################################################
# Outputs
################################################################################

output "basic_iot_hub_id" {
  description = "The ID of the basic IoT Hub."
  value       = module.iot_hub_basic.id
}

output "basic_iot_hub_hostname" {
  description = "The hostname of the basic IoT Hub."
  value       = module.iot_hub_basic.hostname
}

output "advanced_iot_hub_id" {
  description = "The ID of the advanced IoT Hub."
  value       = module.iot_hub_advanced.id
}

output "advanced_iot_hub_principal_id" {
  description = "The principal ID of the advanced IoT Hub managed identity."
  value       = module.iot_hub_advanced.principal_id
}
