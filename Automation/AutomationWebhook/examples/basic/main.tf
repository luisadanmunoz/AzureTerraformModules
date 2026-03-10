################################################################################
# Basic Example - Automation Webhook Module
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
  name                = "aa-webhooks-example-dev-001"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "Basic"
}

################################################################################
# Create a Runbook to trigger via webhook
################################################################################

resource "azurerm_automation_runbook" "example" {
  name                    = "Process-WebhookRequest"
  location                = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  runbook_type            = "PowerShell"
  log_verbose             = true
  log_progress            = true

  content = <<-EOT
    param(
        [Parameter(Mandatory=$false)]
        [object]$WebhookData
    )

    if ($WebhookData) {
        Write-Output "Webhook triggered!"
        Write-Output "Request body: $($WebhookData.RequestBody)"

        $params = ConvertFrom-Json $WebhookData.RequestBody
        Write-Output "Parameters received: $($params | ConvertTo-Json)"
    } else {
        Write-Output "No webhook data received"
    }
  EOT
}

################################################################################
# Automation Webhooks
################################################################################

module "automation_webhooks" {
  source = "../../"

  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name

  webhooks = {
    "ProcessRequest" = {
      runbook_name = azurerm_automation_runbook.example.name
      expiry_time  = timeadd(timestamp(), "8760h") # 1 year from now
      enabled      = true
      parameters = {
        DefaultParam = "DefaultValue"
      }
    }
    "ProcessRequest-Disabled" = {
      runbook_name = azurerm_automation_runbook.example.name
      expiry_time  = timeadd(timestamp(), "8760h")
      enabled      = false
    }
  }

  lifecycle {
    ignore_changes = [webhooks]
  }
}

################################################################################
# Outputs
################################################################################

output "webhook_ids" {
  value = module.automation_webhooks.webhook_ids
}

output "webhook_uris" {
  value     = module.automation_webhooks.webhook_uris
  sensitive = true
}

output "webhook_expiry_times" {
  value = module.automation_webhooks.webhook_expiry_times
}
