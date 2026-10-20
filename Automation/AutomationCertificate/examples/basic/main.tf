################################################################################
# Basic Example - Automation Certificate Module
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0, < 5.0.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-automation-example-dev-001"
  location = "westeurope"
}

resource "azurerm_automation_account" "example" {
  name                = "aa-certs-example-dev-001"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "Basic"
}

################################################################################
# Generate a self-signed certificate for demo purposes
################################################################################

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "example" {
  private_key_pem = tls_private_key.example.private_key_pem

  subject {
    common_name  = "automation.example.com"
    organization = "Example Organization"
  }

  validity_period_hours = 8760 # 1 year

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}

# Create PFX from certificate and key
resource "pkcs12_from_pem" "example" {
  cert_pem        = tls_self_signed_cert.example.cert_pem
  private_key_pem = tls_private_key.example.private_key_pem
  password        = "ExampleP@ssword123"
}

################################################################################
# Automation Certificates
################################################################################

module "automation_certificates" {
  source = "../../"

  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name

  certificates = {
    "SelfSignedCert" = {
      base64      = pkcs12_from_pem.example.result
      password    = "ExampleP@ssword123"
      description = "Self-signed certificate for testing"
      exportable  = true
    }
  }
}

################################################################################
# Outputs
################################################################################

output "certificate_ids" {
  value = module.automation_certificates.certificate_ids
}

output "certificate_thumbprints" {
  value = module.automation_certificates.certificate_thumbprints
}

output "certificate_expiry_dates" {
  value = module.automation_certificates.certificate_expiry_dates
}
