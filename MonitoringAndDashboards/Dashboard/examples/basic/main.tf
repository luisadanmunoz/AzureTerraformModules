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
  name     = "rg-dashboard-example"
  location = "eastus"
}

################################################################################
# Dashboard - Operations Overview
################################################################################

module "dashboard_operations" {
  source = "../../"

  name                = "dash-operations-overview"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  dashboard_properties = jsonencode({
    lenses = {
      "0" = {
        order = 0
        parts = {
          "0" = {
            position = {
              x          = 0
              y          = 0
              colSpan    = 6
              rowSpan    = 4
            }
            metadata = {
              type = "Extension/Microsoft_Azure_Monitoring/PartType/MetricsChartPart"
              inputs = []
            }
          }
          "1" = {
            position = {
              x          = 6
              y          = 0
              colSpan    = 6
              rowSpan    = 4
            }
            metadata = {
              type = "Extension/HubsExtension/PartType/MarkdownPart"
              inputs = []
              settings = {
                content = {
                  settings = {
                    content = "## Operations Dashboard\nMonitoring overview for production resources."
                    title   = "Welcome"
                  }
                }
              }
            }
          }
        }
      }
    }
  })

  tags = {
    Environment = "Example"
    Purpose     = "Operations"
  }
}

################################################################################
# Outputs
################################################################################

output "dashboard_id" {
  description = "The ID of the operations dashboard."
  value       = module.dashboard_operations.id
}
