################################################################################
# Basic Example - Runbook Module
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
  name                = "aa-runbooks-example-dev-001"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "Basic"

  identity {
    type = "SystemAssigned"
  }
}

################################################################################
# Schedule for automated execution
################################################################################

resource "azurerm_automation_schedule" "daily" {
  name                    = "daily-morning"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  frequency               = "Day"
  interval                = 1
  timezone                = "UTC"
  start_time              = timeadd(timestamp(), "24h")
  description             = "Runs daily"

  lifecycle {
    ignore_changes = [start_time]
  }
}

################################################################################
# PowerShell Runbook with inline content
################################################################################

module "runbook_powershell" {
  source = "../../"

  resource_group_name     = azurerm_resource_group.example.name
  location                = azurerm_resource_group.example.location
  automation_account_name = azurerm_automation_account.example.name
  name                    = "Get-AzureVMs"
  runbook_type            = "PowerShell"
  description             = "Lists all VMs in a subscription"

  log_verbose  = true
  log_progress = true

  content = <<-EOT
    param(
        [Parameter(Mandatory=$false)]
        [string]$ResourceGroupName = "*"
    )

    # Connect using Managed Identity
    Connect-AzAccount -Identity

    # Get VMs
    if ($ResourceGroupName -eq "*") {
        $vms = Get-AzVM
    } else {
        $vms = Get-AzVM -ResourceGroupName $ResourceGroupName
    }

    # Output VM information
    foreach ($vm in $vms) {
        Write-Output "VM: $($vm.Name) | RG: $($vm.ResourceGroupName) | Size: $($vm.HardwareProfile.VmSize)"
    }

    Write-Output "Total VMs found: $($vms.Count)"
  EOT

  job_schedules = [
    {
      schedule_name = azurerm_automation_schedule.daily.name
      parameters = {
        ResourceGroupName = "*"
      }
    }
  ]

  tags = {
    Environment = "Development"
    Purpose     = "Inventory"
  }
}

################################################################################
# Python 3 Runbook
################################################################################

module "runbook_python" {
  source = "../../"

  resource_group_name     = azurerm_resource_group.example.name
  location                = azurerm_resource_group.example.location
  automation_account_name = azurerm_automation_account.example.name
  name                    = "hello-python"
  runbook_type            = "Python3"
  description             = "Simple Python 3 runbook"

  content = <<-EOT
    #!/usr/bin/env python3
    import sys
    print(f"Python version: {sys.version}")
    print("Hello from Azure Automation!")
  EOT

  tags = {
    Environment = "Development"
  }
}

################################################################################
# Outputs
################################################################################

output "powershell_runbook_id" {
  value = module.runbook_powershell.id
}

output "powershell_runbook_name" {
  value = module.runbook_powershell.name
}

output "python_runbook_id" {
  value = module.runbook_python.id
}

output "job_schedule_ids" {
  value = module.runbook_powershell.job_schedule_ids
}
