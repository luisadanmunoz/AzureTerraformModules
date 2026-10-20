################################################################################
# Example: Azure Key Vault Certificates
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
  name     = "rg-certificates-demo-001"
  location = "westeurope"
}

resource "azurerm_key_vault" "example" {
  name                       = "kv-certs-demo-001"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  enable_rbac_authorization  = true
  purge_protection_enabled   = false
  soft_delete_retention_days = 7
}

resource "azurerm_role_assignment" "certificates_officer" {
  scope                = azurerm_key_vault.example.id
  role_definition_name = "Key Vault Certificates Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

################################################################################
# Self-Signed Certificate
################################################################################

module "self_signed_cert" {
  source = "../../"

  name         = "app-self-signed"
  key_vault_id = azurerm_key_vault.example.id

  certificate_policy = {
    issuer_parameters = {
      name = "Self"
    }
    key_properties = {
      exportable = true
      key_type   = "RSA"
      key_size   = 2048
      reuse_key  = true
    }
    secret_properties = {
      content_type = "application/x-pkcs12"
    }
    lifetime_action = [
      {
        action = {
          action_type = "AutoRenew"
        }
        trigger = {
          days_before_expiry = 30
        }
      }
    ]
    x509_certificate_properties = {
      subject            = "CN=app.example.com"
      validity_in_months = 12
      key_usage = [
        "digitalSignature",
        "keyEncipherment",
      ]
      subject_alternative_names = {
        dns_names = ["app.example.com", "*.app.example.com"]
      }
    }
  }

  tags = {
    Application = "WebApp"
    Environment = "Demo"
  }

  depends_on = [azurerm_role_assignment.certificates_officer]
}

################################################################################
# Imported PFX Certificate
################################################################################

variable "pfx_content" {
  description = "Base64 encoded PFX certificate content."
  type        = string
  default     = ""
  sensitive   = true
}

variable "pfx_password" {
  description = "Password for the PFX certificate."
  type        = string
  default     = ""
  sensitive   = true
}

module "imported_cert" {
  source = "../../"

  create = var.pfx_content != "" ? true : false

  name         = "imported-wildcard"
  key_vault_id = azurerm_key_vault.example.id

  certificate = {
    contents = var.pfx_content
    password = var.pfx_password
  }

  certificate_policy = {
    issuer_parameters = {
      name = "Unknown"
    }
    key_properties = {
      exportable = true
      key_type   = "RSA"
      key_size   = 2048
      reuse_key  = false
    }
    secret_properties = {
      content_type = "application/x-pkcs12"
    }
    x509_certificate_properties = {
      subject            = "CN=*.example.com"
      validity_in_months = 12
      key_usage = [
        "digitalSignature",
        "keyEncipherment",
      ]
    }
  }

  tags = {
    Application = "Wildcard"
    Environment = "Demo"
  }

  depends_on = [azurerm_role_assignment.certificates_officer]
}

################################################################################
# Outputs
################################################################################

output "self_signed_cert_id" {
  value = module.self_signed_cert.id
}

output "self_signed_cert_thumbprint" {
  value = module.self_signed_cert.thumbprint
}

output "self_signed_cert_secret_id" {
  value = module.self_signed_cert.secret_id
}

output "imported_cert_id" {
  value = module.imported_cert.id
}
