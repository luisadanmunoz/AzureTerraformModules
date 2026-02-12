################################################################################
# Basic Example - Automation Credential Module
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

resource "azurerm_resource_group" "example" {
  name     = "rg-automation-example-dev-001"
  location = "westeurope"
}

resource "azurerm_automation_account" "example" {
  name                = "aa-credentials-example-dev-001"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "Basic"
}

################################################################################
# Variables for sensitive passwords (passed via tfvars or environment)
################################################################################

variable "sql_admin_password" {
  description = "SQL Admin password"
  type        = string
  sensitive   = true
  default     = "P@ssw0rd123!" # Only for demo - use tfvars in production
}

variable "vm_admin_password" {
  description = "VM Admin password"
  type        = string
  sensitive   = true
  default     = "P@ssw0rd456!" # Only for demo - use tfvars in production
}

################################################################################
# Automation Credentials
################################################################################

module "automation_credentials" {
  source = "../../"

  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name

  credentials = {
    "SQLServerAdmin" = {
      username    = "sqladmin"
      password    = var.sql_admin_password
      description = "SQL Server administrator credentials"
    }
    "VMLocalAdmin" = {
      username    = "localadmin"
      password    = var.vm_admin_password
      description = "Local administrator for Windows VMs"
    }
    "ServiceAccount" = {
      username    = "svc-automation@contoso.com"
      password    = "ServiceP@ss123!"
      description = "Service account for external API"
    }
  }
}

################################################################################
# Outputs
################################################################################

output "credential_ids" {
  description = "Map of credential names to IDs"
  value       = module.automation_credentials.credential_ids
}

output "credential_names" {
  description = "List of credential names"
  value       = module.automation_credentials.credential_names
}
