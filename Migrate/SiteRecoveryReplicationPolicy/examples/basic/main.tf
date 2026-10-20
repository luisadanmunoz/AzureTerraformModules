################################################################################
# Provider Configuration
################################################################################

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

################################################################################
# Resource Group
################################################################################

resource "azurerm_resource_group" "main" {
  name     = "rg-replication-policy-example"
  location = "eastus"
}

################################################################################
# Recovery Services Vault
################################################################################

resource "azurerm_recovery_services_vault" "main" {
  name                = "rsv-repl-policy-example"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"
}

################################################################################
# Replication Policy - Standard 24h Retention
################################################################################

module "replication_policy_standard" {
  source = "../../"

  name                = "policy-standard-24h"
  resource_group_name = azurerm_resource_group.main.name
  recovery_vault_name = azurerm_recovery_services_vault.main.name

  recovery_point_retention_in_minutes                  = 1440
  application_consistent_snapshot_frequency_in_minutes = 240
}

################################################################################
# Replication Policy - Extended 72h Retention
################################################################################

module "replication_policy_extended" {
  source = "../../"

  name                = "policy-extended-72h"
  resource_group_name = azurerm_resource_group.main.name
  recovery_vault_name = azurerm_recovery_services_vault.main.name

  recovery_point_retention_in_minutes                  = 4320
  application_consistent_snapshot_frequency_in_minutes = 60
}

################################################################################
# Outputs
################################################################################

output "standard_policy_id" {
  description = "The ID of the standard replication policy."
  value       = module.replication_policy_standard.id
}

output "extended_policy_id" {
  description = "The ID of the extended replication policy."
  value       = module.replication_policy_extended.id
}
