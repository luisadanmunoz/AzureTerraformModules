################################################################################
# Example: Azure Machine Learning Workspace
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

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "ml" {
  name     = "rg-ml-workspace"
  location = "westeurope"
}

################################################################################
# Required Dependencies
################################################################################

resource "azurerm_application_insights" "ml" {
  name                = "appi-ml-prod"
  resource_group_name = azurerm_resource_group.ml.name
  location            = azurerm_resource_group.ml.location
  application_type    = "web"
}

resource "azurerm_key_vault" "ml" {
  name                = "kv-ml-prod-001"
  resource_group_name = azurerm_resource_group.ml.name
  location            = azurerm_resource_group.ml.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}

resource "azurerm_storage_account" "ml" {
  name                     = "stmlprod001"
  resource_group_name      = azurerm_resource_group.ml.name
  location                 = azurerm_resource_group.ml.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_container_registry" "ml" {
  name                = "crmlprod001"
  resource_group_name = azurerm_resource_group.ml.name
  location            = azurerm_resource_group.ml.location
  sku                 = "Basic"
  admin_enabled       = true
}

################################################################################
# ML Workspace
################################################################################

module "ml_workspace" {
  source = "../../"

  name                    = "mlw-prod-001"
  resource_group_name     = azurerm_resource_group.ml.name
  location                = azurerm_resource_group.ml.location
  application_insights_id = azurerm_application_insights.ml.id
  key_vault_id            = azurerm_key_vault.ml.id
  storage_account_id      = azurerm_storage_account.ml.id
  container_registry_id   = azurerm_container_registry.ml.id

  friendly_name = "Production ML Workspace"
  description   = "Machine Learning workspace for production workloads"

  tags = {
    Environment = "Production"
    Purpose     = "MachineLearning"
  }
}

################################################################################
# Outputs
################################################################################

output "workspace_id" {
  value = module.ml_workspace.id
}

output "workspace_discovery_url" {
  value = module.ml_workspace.discovery_url
}
