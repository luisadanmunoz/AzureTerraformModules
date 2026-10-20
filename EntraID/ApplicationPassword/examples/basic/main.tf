################################################################################
# Example: Entra ID Application Password (Client Secret)
# Demonstrates various client secret configurations
################################################################################

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.45.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
  }
}

provider "azuread" {}

provider "azurerm" {
  features {}
}

data "azuread_client_config" "current" {}

################################################################################
# Application Registration
################################################################################

resource "azuread_application" "example" {
  display_name = "example-app-with-secrets"
  description  = "Example application demonstrating client secrets"

  owners = [data.azuread_client_config.current.object_id]
}

################################################################################
# Basic Client Secret
# Simple secret with default 2-year expiration
################################################################################

module "secret_basic" {
  source = "../../"

  application_id = azuread_application.example.id
  display_name   = "basic-secret"
}

################################################################################
# Short-Lived Secret
# 90-day expiration for higher security environments
################################################################################

module "secret_short_lived" {
  source = "../../"

  application_id    = azuread_application.example.id
  display_name      = "short-lived-secret"
  end_date_relative = "2160h"  # 90 days
}

################################################################################
# Fixed Date Secret
# Specific start and end dates
################################################################################

module "secret_fixed_dates" {
  source = "../../"

  application_id = azuread_application.example.id
  display_name   = "fixed-date-secret"

  start_date = timeadd(timestamp(), "24h")      # Starts tomorrow
  end_date   = timeadd(timestamp(), "4320h")    # Expires in 180 days
}

################################################################################
# Rotating Secrets for Zero-Downtime Rotation
# Two secrets that can be rotated independently
################################################################################

module "secret_primary" {
  source = "../../"

  application_id    = azuread_application.example.id
  display_name      = "primary-secret"
  end_date_relative = "4320h"  # 180 days
}

module "secret_secondary" {
  source = "../../"

  application_id    = azuread_application.example.id
  display_name      = "secondary-secret"
  end_date_relative = "4320h"  # 180 days
}

################################################################################
# Outputs
################################################################################

output "application_client_id" {
  description = "Client ID of the application"
  value       = azuread_application.example.client_id
}

output "basic_secret_id" {
  description = "Key ID of the basic secret"
  value       = module.secret_basic.key_id
}

output "basic_secret_end_date" {
  description = "Expiration date of the basic secret"
  value       = module.secret_basic.end_date
}

output "short_lived_secret_id" {
  description = "Key ID of the short-lived secret"
  value       = module.secret_short_lived.key_id
}

output "short_lived_secret_end_date" {
  description = "Expiration date of the short-lived secret"
  value       = module.secret_short_lived.end_date
}

output "primary_secret_id" {
  description = "Key ID of the primary rotating secret"
  value       = module.secret_primary.key_id
}

output "secondary_secret_id" {
  description = "Key ID of the secondary rotating secret"
  value       = module.secret_secondary.key_id
}

# Note: Secret values are sensitive and should be stored in Key Vault
# output "secret_value" {
#   value     = module.secret_basic.value
#   sensitive = true
# }
