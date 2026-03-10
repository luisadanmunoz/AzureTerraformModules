################################################################################
# Example: Entra ID Application Certificate
# Demonstrates certificate-based authentication configurations
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.45.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.0"
    }
  }
}

provider "azuread" {}

data "azuread_client_config" "current" {}

################################################################################
# Application Registration
################################################################################

resource "azuread_application" "example" {
  display_name = "example-app-with-certificate"
  description  = "Example application demonstrating certificate authentication"

  owners = [data.azuread_client_config.current.object_id]
}

################################################################################
# Generate Self-Signed Certificate
# In production, use certificates from a proper CA or Key Vault
################################################################################

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "example" {
  private_key_pem = tls_private_key.example.private_key_pem

  subject {
    common_name  = "example-app-with-certificate"
    organization = "Example Organization"
    country      = "US"
  }

  validity_period_hours = 8760  # 1 year

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}

################################################################################
# Application Certificate (Self-Signed)
################################################################################

module "cert_self_signed" {
  source = "../../"

  application_id = azuread_application.example.id
  value          = tls_self_signed_cert.example.cert_pem
  encoding       = "pem"
}

################################################################################
# Application Certificate with Custom Validity
################################################################################

resource "tls_private_key" "short_lived" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "short_lived" {
  private_key_pem = tls_private_key.short_lived.private_key_pem

  subject {
    common_name  = "example-short-lived-cert"
    organization = "Example Organization"
  }

  validity_period_hours = 2160  # 90 days

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}

module "cert_short_lived" {
  source = "../../"

  application_id    = azuread_application.example.id
  value             = tls_self_signed_cert.short_lived.cert_pem
  encoding          = "pem"
  end_date_relative = "2160h"  # 90 days
}

################################################################################
# Rotating Certificates Setup
# Two certificates for zero-downtime rotation
################################################################################

resource "tls_private_key" "primary" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "primary" {
  private_key_pem = tls_private_key.primary.private_key_pem

  subject {
    common_name  = "example-primary-cert"
    organization = "Example Organization"
  }

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}

resource "tls_private_key" "secondary" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "secondary" {
  private_key_pem = tls_private_key.secondary.private_key_pem

  subject {
    common_name  = "example-secondary-cert"
    organization = "Example Organization"
  }

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}

module "cert_primary" {
  source = "../../"

  application_id = azuread_application.example.id
  value          = tls_self_signed_cert.primary.cert_pem
  encoding       = "pem"
}

module "cert_secondary" {
  source = "../../"

  application_id = azuread_application.example.id
  value          = tls_self_signed_cert.secondary.cert_pem
  encoding       = "pem"
}

################################################################################
# Outputs
################################################################################

output "application_client_id" {
  description = "Client ID of the application"
  value       = azuread_application.example.client_id
}

output "self_signed_cert_key_id" {
  description = "Key ID of the self-signed certificate"
  value       = module.cert_self_signed.key_id
}

output "self_signed_cert_end_date" {
  description = "Expiration date of the self-signed certificate"
  value       = module.cert_self_signed.end_date
}

output "short_lived_cert_key_id" {
  description = "Key ID of the short-lived certificate"
  value       = module.cert_short_lived.key_id
}

output "primary_cert_key_id" {
  description = "Key ID of the primary certificate"
  value       = module.cert_primary.key_id
}

output "secondary_cert_key_id" {
  description = "Key ID of the secondary certificate"
  value       = module.cert_secondary.key_id
}

# Note: In production, store private keys securely
# output "private_key_pem" {
#   value     = tls_private_key.example.private_key_pem
#   sensitive = true
# }
