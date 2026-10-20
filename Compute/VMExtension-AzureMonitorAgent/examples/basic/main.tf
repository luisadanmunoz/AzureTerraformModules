################################################################################
# Example: Azure Monitor Agent Extension
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-ama-dev-001"
  location = "westeurope"
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "example" {
  name                = "log-ama-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "PerGB2018"
}

# Data Collection Rule
resource "azurerm_monitor_data_collection_rule" "example" {
  name                = "dcr-linux-perf"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  destinations {
    log_analytics {
      workspace_resource_id = azurerm_log_analytics_workspace.example.id
      name                  = "log-analytics"
    }
  }

  data_flow {
    streams      = ["Microsoft-Perf"]
    destinations = ["log-analytics"]
  }

  data_sources {
    performance_counter {
      streams                       = ["Microsoft-Perf"]
      sampling_frequency_in_seconds = 60
      counter_specifiers            = ["\\Processor(*)\\% Processor Time"]
      name                          = "perfcounter-cpu"
    }
  }
}

# Example VM (simplified)
data "azurerm_virtual_machine" "example" {
  name                = "vm-existing"
  resource_group_name = azurerm_resource_group.example.name
}

module "ama" {
  source = "../../"

  virtual_machine_id      = data.azurerm_virtual_machine.example.id
  os_type                 = "Linux"
  data_collection_rule_id = azurerm_monitor_data_collection_rule.example.id
}

output "extension_id" {
  value = module.ama.id
}
