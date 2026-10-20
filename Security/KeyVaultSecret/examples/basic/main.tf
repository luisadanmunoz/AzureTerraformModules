################################################################################
# Example: Azure Key Vault Secrets
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "rg-secrets-demo-001"
  location = "westeurope"
}

resource "azurerm_key_vault" "example" {
  name                       = "kv-secrets-demo-001"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  enable_rbac_authorization  = true
  purge_protection_enabled   = false
  soft_delete_retention_days = 7
}

resource "azurerm_role_assignment" "secrets_officer" {
  scope                = azurerm_key_vault.example.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

################################################################################
# Database Password Secret
################################################################################

resource "random_password" "db" {
  length  = 32
  special = true
}

module "db_password" {
  source = "../../"

  name         = "database-admin-password"
  key_vault_id = azurerm_key_vault.example.id
  value        = random_password.db.result
  content_type = "password"

  tags = {
    Application = "Database"
    Type        = "Password"
  }

  depends_on = [azurerm_role_assignment.secrets_officer]
}

################################################################################
# API Key with Expiration
################################################################################

module "api_key" {
  source = "../../"

  name            = "external-api-key"
  key_vault_id    = azurerm_key_vault.example.id
  value           = "sk-demo-api-key-12345"
  content_type    = "api-key"
  expiration_date = "2025-12-31T23:59:59Z"

  tags = {
    Application = "ExternalAPI"
    Type        = "APIKey"
  }

  depends_on = [azurerm_role_assignment.secrets_officer]
}

################################################################################
# Connection String
################################################################################

module "connection_string" {
  source = "../../"

  name         = "storage-connection-string"
  key_vault_id = azurerm_key_vault.example.id
  value        = "DefaultEndpointsProtocol=https;AccountName=demo;AccountKey=xxx"
  content_type = "connection-string"

  tags = {
    Application = "Storage"
    Type        = "ConnectionString"
  }

  depends_on = [azurerm_role_assignment.secrets_officer]
}

################################################################################
# Outputs
################################################################################

output "db_password_id" {
  value = module.db_password.id
}

output "api_key_versionless_id" {
  value = module.api_key.versionless_id
}
