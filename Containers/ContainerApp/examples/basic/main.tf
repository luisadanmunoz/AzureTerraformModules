################################################################################
# Example: Azure Container App
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
  name     = "rg-containerapp-dev-001"
  location = "westeurope"
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "log-containerapp-dev-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "PerGB2018"
}

resource "azurerm_container_app_environment" "example" {
  name                       = "cae-demo-dev-001"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
}

################################################################################
# Simple Web App
################################################################################

module "webapp" {
  source = "../../"

  resource_group_name          = azurerm_resource_group.example.name
  container_app_environment_id = azurerm_container_app_environment.example.id

  workload    = "webapp"
  environment = "dev"

  template = {
    min_replicas = 0
    max_replicas = 5

    containers = [
      {
        name   = "nginx"
        image  = "nginx:latest"
        cpu    = 0.25
        memory = "0.5Gi"
      }
    ]

    http_scale_rule = [
      {
        name                = "http-scaling"
        concurrent_requests = 50
      }
    ]
  }

  ingress = {
    target_port      = 80
    external_enabled = true
    traffic_weight = [
      {
        latest_revision = true
        percentage      = 100
      }
    ]
  }

  tags = {
    Environment = "Development"
  }
}

################################################################################
# API with Health Checks
################################################################################

module "api" {
  source = "../../"

  resource_group_name          = azurerm_resource_group.example.name
  container_app_environment_id = azurerm_container_app_environment.example.id

  workload    = "api"
  environment = "dev"

  revision_mode = "Single"

  template = {
    min_replicas = 1
    max_replicas = 10

    containers = [
      {
        name   = "api"
        image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
        cpu    = 0.5
        memory = "1Gi"
        env = [
          {
            name  = "PORT"
            value = "80"
          }
        ]
        liveness_probe = {
          transport        = "HTTP"
          port             = 80
          path             = "/"
          initial_delay    = 5
          interval_seconds = 30
        }
        readiness_probe = {
          transport        = "HTTP"
          port             = 80
          path             = "/"
          initial_delay    = 0
          interval_seconds = 10
        }
      }
    ]
  }

  ingress = {
    target_port      = 80
    external_enabled = true
    traffic_weight = [
      {
        latest_revision = true
        percentage      = 100
      }
    ]
  }

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
    Purpose     = "Demo"
  }
}

################################################################################
# Outputs
################################################################################

output "webapp_url" {
  value = "https://${module.webapp.latest_revision_fqdn}"
}

output "api_url" {
  value = "https://${module.api.latest_revision_fqdn}"
}

output "api_principal_id" {
  value = module.api.principal_id
}
