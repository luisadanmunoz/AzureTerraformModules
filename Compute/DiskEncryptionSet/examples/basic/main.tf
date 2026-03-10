################################################################################
# Example: Disk Encryption Set
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

# ──────────────────────────────────────────────────────────────────────────────
# Resource Group
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_resource_group" "example" {
  name     = "rg-des-dev-001"
  location = "westeurope"
}

# ──────────────────────────────────────────────────────────────────────────────
# Key Vault
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_key_vault" "example" {
  name                        = "kv-des-dev-001"
  resource_group_name         = azurerm_resource_group.example.name
  location                    = azurerm_resource_group.example.location
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7
  enable_rbac_authorization   = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create", "Delete", "Get", "List", "Purge", "Recover", "Update",
      "GetRotationPolicy", "SetRotationPolicy", "WrapKey", "UnwrapKey"
    ]
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Key Vault Key
# ──────────────────────────────────────────────────────────────────────────────

resource "azurerm_key_vault_key" "disk" {
  name         = "disk-encryption-key"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "RSA"
  key_size     = 4096

  key_opts = ["decrypt", "encrypt", "sign", "verify", "wrapKey", "unwrapKey"]
}

# ──────────────────────────────────────────────────────────────────────────────
# Disk Encryption Set
# ──────────────────────────────────────────────────────────────────────────────

module "disk_encryption_set" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  workload    = "vm"
  environment = "dev"

  key_vault_key_id              = azurerm_key_vault_key.disk.id
  key_vault_id                  = azurerm_key_vault.example.id
  auto_key_rotation_enabled     = true
  create_key_vault_access_policy = true

  tags = {
    Environment = "Development"
    Purpose     = "DiskEncryption"
  }
}

# ──────────────────────────────────────────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────────────────────────────────────────

output "disk_encryption_set_id" {
  description = "Disk Encryption Set ID"
  value       = module.disk_encryption_set.id
}

output "disk_encryption_set_principal_id" {
  description = "Disk Encryption Set Principal ID"
  value       = module.disk_encryption_set.principal_id
}
