################################################################################
# Example: Azure Key Vault Access Policies
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

resource "azurerm_resource_group" "example" {
  name     = "rg-accesspolicy-demo-001"
  location = "westeurope"
}

resource "azurerm_key_vault" "example" {
  name                       = "kv-accesspol-demo-001"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  enable_rbac_authorization  = false
  purge_protection_enabled   = false
  soft_delete_retention_days = 7
}

################################################################################
# Admin Access Policy - Full Permissions
################################################################################

module "admin_policy" {
  source = "../../"

  key_vault_id = azurerm_key_vault.example.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  certificate_permissions = ["Get", "List", "Create", "Delete", "Import", "Update", "Purge", "Recover"]
  key_permissions         = ["Get", "List", "Create", "Delete", "Import", "Update", "Recover", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "WrapKey", "UnwrapKey"]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Recover", "Purge", "Backup", "Restore"]
  storage_permissions     = ["Get", "List", "Set", "Delete", "Update", "RegenerateKey", "Recover", "Purge"]
}

################################################################################
# Read-Only Access Policy
################################################################################

module "readonly_policy" {
  source = "../../"

  key_vault_id = azurerm_key_vault.example.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = "00000000-0000-0000-0000-000000000001" # Replace with actual reader object ID

  secret_permissions      = ["Get", "List"]
  key_permissions         = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
}

################################################################################
# Application-Specific Access Policy
################################################################################

module "app_policy" {
  source = "../../"

  key_vault_id   = azurerm_key_vault.example.id
  tenant_id      = data.azurerm_client_config.current.tenant_id
  object_id      = "00000000-0000-0000-0000-000000000002" # Replace with actual service principal object ID
  application_id = "00000000-0000-0000-0000-000000000003" # Replace with actual application ID

  secret_permissions = ["Get", "List"]
  key_permissions    = ["Get", "List", "Sign", "Verify"]
}

################################################################################
# Outputs
################################################################################

output "admin_policy_id" {
  value = module.admin_policy.id
}

output "readonly_policy_id" {
  value = module.readonly_policy.id
}

output "app_policy_id" {
  value = module.app_policy.id
}
