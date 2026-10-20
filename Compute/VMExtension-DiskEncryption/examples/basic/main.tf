################################################################################
# Example: Azure Disk Encryption Extension
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
  name     = "rg-ade-dev-001"
  location = "westeurope"
}

# Key Vault for disk encryption
resource "azurerm_key_vault" "example" {
  name                        = "kv-ade-dev-001"
  resource_group_name         = azurerm_resource_group.example.name
  location                    = azurerm_resource_group.example.location
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  enabled_for_disk_encryption = true
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create", "Delete", "Get", "List", "Purge", "Recover", "Update",
      "WrapKey", "UnwrapKey"
    ]
    secret_permissions = ["Get", "List", "Set", "Delete", "Purge"]
  }
}

# Key Encryption Key (KEK)
resource "azurerm_key_vault_key" "kek" {
  name         = "disk-kek"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "RSA"
  key_size     = 4096

  key_opts = ["wrapKey", "unwrapKey"]
}

# Existing VM
data "azurerm_virtual_machine" "example" {
  name                = "vm-windows-prod-001"
  resource_group_name = "rg-compute-prod-001"
}

module "disk_encryption" {
  source = "../../"

  virtual_machine_id     = data.azurerm_virtual_machine.example.id
  os_type                = "Windows"
  key_vault_url          = azurerm_key_vault.example.vault_uri
  key_vault_resource_id  = azurerm_key_vault.example.id
  key_encryption_key_url = azurerm_key_vault_key.kek.id
  volume_type            = "All"
}

output "extension_id" {
  value = module.disk_encryption.id
}
