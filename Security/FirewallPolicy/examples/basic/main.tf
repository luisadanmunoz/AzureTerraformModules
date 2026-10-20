################################################################################
# Example: Azure Firewall Policy
# Standard policy with DNS and threat intelligence configuration
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
  name     = "rg-firewall-prod-001"
  location = "westeurope"
}

################################################################################
# Log Analytics Workspace for Insights
################################################################################

resource "azurerm_log_analytics_workspace" "example" {
  name                = "law-firewall-prod-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

################################################################################
# Standard Firewall Policy
# Best Practices:
# - DNS proxy enabled for FQDN-based rules
# - Threat intelligence set to Alert mode
# - Custom DNS servers for private resolution
# - Insights enabled for monitoring
################################################################################

module "firewall_policy" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "hub"
  environment = "prod"

  # Standard SKU with threat intelligence
  sku                      = "Standard"
  threat_intelligence_mode = "Alert"

  # DNS configuration for FQDN rule support
  dns = {
    proxy_enabled = true
    servers       = ["10.0.1.4", "10.0.1.5"]
  }

  # Allowlist trusted FQDNs and IPs from threat intelligence filtering
  threat_intelligence_allowlist = {
    fqdns        = ["internal.company.com", "update.company.com"]
    ip_addresses = ["10.0.0.0/8", "172.16.0.0/12"]
  }

  # Enable insights for monitoring and compliance
  insights = {
    enabled                            = true
    default_log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
    retention_in_days                  = 30
  }

  tags = {
    Environment = "Production"
    Network     = "Hub"
  }
}

################################################################################
# Child Policy for Spoke Network
# Inherits rules from the parent hub policy
################################################################################

module "firewall_policy_spoke" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "spoke"
  environment = "prod"

  sku            = "Standard"
  base_policy_id = module.firewall_policy.id

  tags = {
    Environment = "Production"
    Network     = "Spoke"
  }
}

################################################################################
# Outputs
################################################################################

output "hub_policy_id" {
  value = module.firewall_policy.id
}

output "hub_policy_name" {
  value = module.firewall_policy.name
}

output "spoke_policy_id" {
  value = module.firewall_policy_spoke.id
}

output "spoke_policy_name" {
  value = module.firewall_policy_spoke.name
}
