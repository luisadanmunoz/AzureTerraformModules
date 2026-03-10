# Azure Automation Runbook Module

Terraform module to create and manage **Azure Automation Runbooks** with support for multiple runbook types, inline content, external URIs, draft configurations, and job schedule associations.

## Features

- Support for all runbook types (PowerShell, PowerShell72, PowerShellWorkflow, Python2, Python3, Graph, GraphPowerShell, GraphPowerShellWorkflow)
- Inline script content or external URI publishing
- Draft mode with parameters and output types
- Job schedule associations for automated execution
- Hybrid Worker Group support
- Verbose and progress logging configuration
- Activity trace level configuration
- Conditional creation with `create = true/false`

## Usage - Basic PowerShell Runbook (Inline)

```hcl
module "runbook" {
  source = "path/to/Automation/Runbook"

  resource_group_name     = "rg-automation-dev-001"
  location                = "westeurope"
  automation_account_name = "aa-runbooks-dev-001"
  name                    = "Stop-VirtualMachines"
  runbook_type            = "PowerShell"
  description             = "Stops all VMs in a resource group"

  content = <<-EOT
    param(
        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName
    )

    Connect-AzAccount -Identity

    $vms = Get-AzVM -ResourceGroupName $ResourceGroupName
    foreach ($vm in $vms) {
        Write-Output "Stopping VM: $($vm.Name)"
        Stop-AzVM -ResourceGroupName $ResourceGroupName -Name $vm.Name -Force
    }
  EOT

  tags = {
    Environment = "Development"
  }
}
```

## Usage - PowerShell 7.2 Runbook

```hcl
module "runbook_ps72" {
  source = "path/to/Automation/Runbook"

  resource_group_name     = "rg-automation-dev-001"
  location                = "westeurope"
  automation_account_name = "aa-runbooks-dev-001"
  name                    = "Get-AzureResources"
  runbook_type            = "PowerShell72"
  description             = "Lists Azure resources using PowerShell 7.2"

  log_verbose  = true
  log_progress = true

  content = <<-EOT
    Connect-AzAccount -Identity
    Get-AzResource | Select-Object Name, ResourceType, Location
  EOT

  tags = {
    Environment = "Development"
  }
}
```

## Usage - Python 3 Runbook

```hcl
module "runbook_python" {
  source = "path/to/Automation/Runbook"

  resource_group_name     = "rg-automation-dev-001"
  location                = "westeurope"
  automation_account_name = "aa-runbooks-dev-001"
  name                    = "cleanup-storage"
  runbook_type            = "Python3"
  description             = "Cleanup old blobs from storage"

  content = <<-EOT
    #!/usr/bin/env python3
    import automationassets
    from azure.identity import DefaultAzureCredential
    from azure.storage.blob import BlobServiceClient

    credential = DefaultAzureCredential()
    # Your cleanup logic here
    print("Cleanup completed")
  EOT

  tags = {
    Environment = "Development"
  }
}
```

## Usage - External URI Content

```hcl
module "runbook_external" {
  source = "path/to/Automation/Runbook"

  resource_group_name     = "rg-automation-dev-001"
  location                = "westeurope"
  automation_account_name = "aa-runbooks-dev-001"
  name                    = "Start-VMs-FromGit"
  runbook_type            = "PowerShell"
  description             = "Start VMs - script from GitHub"

  publish_content_link = {
    uri     = "https://raw.githubusercontent.com/org/repo/main/runbooks/Start-VMs.ps1"
    version = "1.0.0"
    hash = {
      algorithm = "SHA256"
      value     = "abc123..."
    }
  }

  tags = {
    Environment = "Development"
  }
}
```

## Usage - With Job Schedule

```hcl
# First create a schedule
resource "azurerm_automation_schedule" "daily" {
  name                    = "daily-6am"
  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"
  frequency               = "Day"
  interval                = 1
  start_time              = "2024-01-01T06:00:00+00:00"
  timezone                = "UTC"
}

# Then create runbook with schedule association
module "runbook_scheduled" {
  source = "path/to/Automation/Runbook"

  resource_group_name     = "rg-automation-dev-001"
  location                = "westeurope"
  automation_account_name = "aa-runbooks-dev-001"
  name                    = "Daily-Cleanup"
  runbook_type            = "PowerShell"

  content = <<-EOT
    Write-Output "Running daily cleanup..."
    # Cleanup logic
  EOT

  job_schedules = [
    {
      schedule_name = azurerm_automation_schedule.daily.name
      parameters = {
        Environment = "Production"
        DryRun      = "false"
      }
    }
  ]

  tags = {
    Environment = "Development"
  }
}
```

## Usage - With Hybrid Worker

```hcl
module "runbook_hybrid" {
  source = "path/to/Automation/Runbook"

  resource_group_name     = "rg-automation-prod-001"
  location                = "westeurope"
  automation_account_name = "aa-runbooks-prod-001"
  name                    = "On-Premises-Task"
  runbook_type            = "PowerShell"

  content = <<-EOT
    # This runs on-premises via Hybrid Worker
    Get-Service | Where-Object {$_.Status -eq 'Stopped'}
  EOT

  job_schedules = [
    {
      schedule_name = "hourly-check"
      run_on        = "OnPremWorkerGroup"
    }
  ]

  tags = {
    Environment = "Production"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create the resource | `bool` | `true` | no |
| `resource_group_name` | Name of the Resource Group | `string` | - | yes |
| `location` | Azure Region | `string` | - | yes |
| `automation_account_name` | Name of the Automation Account | `string` | - | yes |
| `name` | Name of the Runbook | `string` | - | yes |
| `runbook_type` | Type of Runbook | `string` | - | yes |
| `description` | Description of the Runbook | `string` | `null` | no |
| `log_verbose` | Enable verbose logging | `bool` | `false` | no |
| `log_progress` | Enable progress logging | `bool` | `false` | no |
| `log_activity_trace_level` | Activity trace level (0-99) | `number` | `0` | no |
| `content` | Inline script content | `string` | `null` | no |
| `publish_content_link` | External URI content configuration | `object` | `null` | no |
| `draft` | Draft configuration | `object` | `null` | no |
| `job_schedules` | List of schedule associations | `list(object)` | `[]` | no |
| `tags` | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the Runbook |
| `name` | The name of the Runbook |
| `runbook_type` | The type of the Runbook |
| `job_schedule_ids` | Map of job schedule keys to their IDs |
| `job_schedule_job_ids` | Map of job schedule keys to their UUIDs |

## Dependencies

- **Resource Group** must exist
- **Automation Account** must exist before creating Runbooks
- **Automation Schedule** must exist before associating with job_schedules
- **Hybrid Worker Group** must exist if using run_on parameter
