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
  name     = "rg-action-group-example"
  location = "eastus"
}

################################################################################
# Action Group - Email Only
################################################################################

module "ag_email" {
  source = "../../"

  name                = "ag-email-alerts"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "email"

  email_receivers = [
    {
      name          = "admin-team"
      email_address = "admin@contoso.com"
    },
    {
      name          = "devops-team"
      email_address = "devops@contoso.com"
    }
  ]

  tags = {
    Environment = "Example"
  }
}

################################################################################
# Action Group - Multi-Channel
################################################################################

module "ag_critical" {
  source = "../../"

  name                = "ag-critical-alerts"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "critical"

  email_receivers = [
    {
      name          = "oncall-team"
      email_address = "oncall@contoso.com"
    }
  ]

  sms_receivers = [
    {
      name         = "oncall-sms"
      country_code = "1"
      phone_number = "5551234567"
    }
  ]

  webhook_receivers = [
    {
      name        = "pagerduty"
      service_uri = "https://events.pagerduty.com/integration/example/enqueue"
    }
  ]

  tags = {
    Environment = "Example"
    Severity    = "Critical"
  }
}

################################################################################
# Outputs
################################################################################

output "email_ag_id" {
  description = "The ID of the email action group."
  value       = module.ag_email.id
}

output "critical_ag_id" {
  description = "The ID of the critical action group."
  value       = module.ag_critical.id
}
