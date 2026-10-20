################################################################################
# Example: Azure Key Vault Keys
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
  name     = "rg-keyvaultkey-demo-001"
  location = "westeurope"
}

resource "azurerm_key_vault" "example" {
  name                       = "kv-keys-demo-001"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  enable_rbac_authorization  = true
  purge_protection_enabled   = false
  soft_delete_retention_days = 7
}

resource "azurerm_role_assignment" "crypto_officer" {
  scope                = azurerm_key_vault.example.id
  role_definition_name = "Key Vault Crypto Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

################################################################################
# RSA Key for Encryption
################################################################################

module "rsa_encryption_key" {
  source = "../../"

  name         = "rsa-encryption-key"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "RSA"
  key_size     = 4096

  key_opts = ["decrypt", "encrypt", "wrapKey", "unwrapKey"]

  tags = {
    Purpose = "Encryption"
    KeyType = "RSA"
  }

  depends_on = [azurerm_role_assignment.crypto_officer]
}

################################################################################
# EC Key for Signing
################################################################################

module "ec_signing_key" {
  source = "../../"

  name         = "ec-signing-key"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "EC"
  curve        = "P-256"

  key_opts = ["sign", "verify"]

  tags = {
    Purpose = "Signing"
    KeyType = "EC"
  }

  depends_on = [azurerm_role_assignment.crypto_officer]
}

################################################################################
# RSA Key with Rotation Policy
################################################################################

module "rotating_key" {
  source = "../../"

  name         = "auto-rotating-key"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "RSA"
  key_size     = 2048

  expiration_date = "2026-12-31T23:59:59Z"

  rotation_policy = {
    expire_after         = "P90D"
    notify_before_expiry = "P30D"
    automatic = {
      time_before_expiry = "P30D"
    }
  }

  tags = {
    Purpose  = "Encryption"
    Rotation = "Automatic"
  }

  depends_on = [azurerm_role_assignment.crypto_officer]
}

################################################################################
# Outputs
################################################################################

output "rsa_key_id" {
  value = module.rsa_encryption_key.id
}

output "ec_key_id" {
  value = module.ec_signing_key.id
}

output "rotating_key_versionless_id" {
  value = module.rotating_key.versionless_id
}

output "rsa_public_key_pem" {
  value = module.rsa_encryption_key.public_key_pem
}
