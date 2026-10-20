################################################################################
# Example: Azure Container App Environment
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
  name     = "rg-cae-dev-001"
  location = "westeurope"
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "log-cae-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

################################################################################
# Basic Environment (Consumption)
################################################################################

module "environment_basic" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "basic"
  environment = "dev"

  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id

  tags = {
    Environment = "Development"
  }
}

################################################################################
# Environment with Workload Profiles
################################################################################

module "environment_dedicated" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "dedicated"
  environment = "prod"

  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
  zone_redundancy_enabled    = true

  workload_profiles = [
    {
      name                  = "Consumption"
      workload_profile_type = "Consumption"
    },
    {
      name                  = "general-purpose"
      workload_profile_type = "D4"
      minimum_count         = 1
      maximum_count         = 3
    }
  ]

  tags = {
    Environment = "Production"
    Tier        = "Dedicated"
  }
}

################################################################################
# Environment with VNet Integration
################################################################################

resource "azurerm_virtual_network" "example" {
  name                = "vnet-cae-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "container_apps" {
  name                 = "snet-container-apps"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/23"]

  delegation {
    name = "container-apps-delegation"
    service_delegation {
      name = "Microsoft.App/environments"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

module "environment_vnet" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "internal"
  environment = "prod"

  log_analytics_workspace_id     = azurerm_log_analytics_workspace.example.id
  infrastructure_subnet_id       = azurerm_subnet.container_apps.id
  internal_load_balancer_enabled = true

  tags = {
    Environment = "Production"
    Network     = "Internal"
  }
}

################################################################################
# Outputs
################################################################################

output "basic_environment_id" {
  value = module.environment_basic.id
}

output "basic_default_domain" {
  value = module.environment_basic.default_domain
}

output "dedicated_environment_id" {
  value = module.environment_dedicated.id
}

output "vnet_environment_id" {
  value = module.environment_vnet.id
}

output "vnet_static_ip" {
  value = module.environment_vnet.static_ip_address
}
