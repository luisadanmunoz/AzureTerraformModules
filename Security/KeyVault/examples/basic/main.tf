################################################################################
# Example: Azure Key Vault
# Following Microsoft Security Best Practices
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
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "rg-keyvault-prod-001"
  location = "westeurope"
}

################################################################################
# Network Infrastructure
################################################################################

resource "azurerm_virtual_network" "example" {
  name                = "vnet-keyvault-prod-001"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "app" {
  name                 = "snet-app"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.KeyVault"]
}

################################################################################
# Production Key Vault
# Best Practices:
# - RBAC authorization (modern approach)
# - Purge protection enabled
# - 90-day soft delete retention
# - Network restrictions with VNet integration
# - Premium SKU for HSM-backed keys
################################################################################

module "keyvault_prod" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  tenant_id           = data.azurerm_client_config.current.tenant_id

  workload    = "myapp"
  environment = "prod"

  # Premium for HSM-backed keys
  sku_name = "premium"

  # Security best practices
  enable_rbac_authorization     = true
  purge_protection_enabled      = true
  soft_delete_retention_days    = 90
  public_network_access_enabled = true

  # Network restrictions
  network_acls = {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.app.id]
  }

  # Enable for Azure services
  enabled_for_deployment          = true
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = false

  # Certificate contacts
  contacts = [
    {
      email = "security@company.com"
      name  = "Security Team"
    }
  ]

  tags = {
    Environment = "Production"
    Compliance  = "Required"
  }
}

################################################################################
# RBAC Role Assignments
# Best Practice: Use built-in roles for Key Vault access
################################################################################

# Key Vault Administrator for current user (for demo)
resource "azurerm_role_assignment" "kv_admin" {
  scope                = module.keyvault_prod.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

################################################################################
# Development Key Vault
# Simplified configuration for non-production
################################################################################

module "keyvault_dev" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  tenant_id           = data.azurerm_client_config.current.tenant_id

  workload    = "myapp"
  environment = "dev"

  sku_name                   = "standard"
  enable_rbac_authorization  = true
  purge_protection_enabled   = false  # Allow purge in dev
  soft_delete_retention_days = 7

  tags = {
    Environment = "Development"
  }
}

################################################################################
# Outputs
################################################################################

output "prod_keyvault_id" {
  value = module.keyvault_prod.id
}

output "prod_keyvault_uri" {
  value = module.keyvault_prod.vault_uri
}

output "dev_keyvault_id" {
  value = module.keyvault_dev.id
}

output "dev_keyvault_uri" {
  value = module.keyvault_dev.vault_uri
}
