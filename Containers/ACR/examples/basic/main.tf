################################################################################
# Example: Azure Container Registry
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
  name     = "rg-acr-dev-001"
  location = "westeurope"
}

################################################################################
# Standard ACR
################################################################################

module "acr_standard" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "myapp"
  environment = "dev"

  sku = "Standard"

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
    Project     = "Demo"
  }
}

################################################################################
# Premium ACR with Geo-replication
################################################################################

module "acr_premium" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "enterprise"
  environment = "prod"
  instance    = "001"

  sku                     = "Premium"
  zone_redundancy_enabled = true
  data_endpoint_enabled   = true

  georeplications = [
    {
      location                  = "northeurope"
      zone_redundancy_enabled   = true
      regional_endpoint_enabled = true
    }
  ]

  retention_policy = {
    days    = 30
    enabled = true
  }

  trust_policy = {
    enabled = true
  }

  identity = {
    type = "SystemAssigned"
  }

  webhooks = [
    {
      name        = "cicdwebhook"
      service_uri = "https://example.com/webhook"
      actions     = ["push", "delete"]
    }
  ]

  tags = {
    Environment = "Production"
    Project     = "Enterprise"
  }
}

################################################################################
# Outputs
################################################################################

output "standard_login_server" {
  value = module.acr_standard.login_server
}

output "premium_login_server" {
  value = module.acr_premium.login_server
}

output "docker_login_command" {
  value = "az acr login --name ${module.acr_standard.name}"
}
