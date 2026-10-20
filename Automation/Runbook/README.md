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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_automation_job_schedule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_job_schedule) | resource |
| [azurerm_automation_runbook.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_runbook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_automation_account_name"></a> [automation\_account\_name](#input\_automation\_account\_name) | (Required) The name of the Automation Account where the Runbook will be created. DEPENDENCY: Automation Account must exist. | `string` | n/a | yes |
| <a name="input_content"></a> [content](#input\_content) | (Optional) The inline content of the Runbook script. Conflicts with publish\_content\_link. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Runbook. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description for this Runbook. | `string` | `null` | no |
| <a name="input_draft"></a> [draft](#input\_draft) | (Optional) Draft configuration for unpublished Runbook.<br/>- edit\_mode\_enabled: (Optional) Enable edit mode.<br/>- content\_link: (Optional) Content link for draft.<br/>- output\_types: (Optional) List of output types.<br/>- parameters: (Optional) List of parameters with name, type, mandatory, position, default\_value. | <pre>object({<br/>    edit_mode_enabled = optional(bool, false)<br/>    content_link = optional(object({<br/>      uri     = string<br/>      version = optional(string, null)<br/>      hash = optional(object({<br/>        algorithm = string<br/>        value     = string<br/>      }), null)<br/>    }), null)<br/>    output_types = optional(list(string), [])<br/>    parameters = optional(list(object({<br/>      key           = string<br/>      type          = string<br/>      mandatory     = optional(bool, false)<br/>      position      = optional(number, null)<br/>      default_value = optional(string, null)<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_job_schedules"></a> [job\_schedules](#input\_job\_schedules) | (Optional) List of schedules to associate with this Runbook.<br/>- schedule\_name: (Required) The name of the Schedule. DEPENDENCY: Schedule must exist.<br/>- parameters: (Optional) Map of parameters to pass to the Runbook.<br/>- run\_on: (Optional) Name of Hybrid Worker Group to run on. | <pre>list(object({<br/>    schedule_name = string<br/>    parameters    = optional(map(string), {})<br/>    run_on        = optional(string, null)<br/>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Runbook should exist. | `string` | n/a | yes |
| <a name="input_log_activity_trace_level"></a> [log\_activity\_trace\_level](#input\_log\_activity\_trace\_level) | (Optional) The activity-level tracing for this Runbook. Possible values: 0 (disabled), 1-99. | `number` | `0` | no |
| <a name="input_log_progress"></a> [log\_progress](#input\_log\_progress) | (Optional) Enable progress logging. Default: false. | `bool` | `false` | no |
| <a name="input_log_verbose"></a> [log\_verbose](#input\_log\_verbose) | (Optional) Enable verbose logging. Default: false. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Runbook. | `string` | n/a | yes |
| <a name="input_publish_content_link"></a> [publish\_content\_link](#input\_publish\_content\_link) | (Optional) Publish content from a URI. Conflicts with content.<br/>- uri: (Required) The URI of the Runbook content.<br/>- version: (Optional) The version of the content.<br/>- hash: (Optional) Hash configuration for validation.<br/>  - algorithm: Hash algorithm (e.g., SHA256).<br/>  - value: The hash value. | <pre>object({<br/>    uri     = string<br/>    version = optional(string, null)<br/>    hash = optional(object({<br/>      algorithm = string<br/>      value     = string<br/>    }), null)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Automation Account exists. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_runbook_type"></a> [runbook\_type](#input\_runbook\_type) | (Required) The type of the Runbook. Possible values: PowerShell, PowerShellWorkflow, Python2, Python3, Graph, GraphPowerShell, GraphPowerShellWorkflow, PowerShell72. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Automation Runbook. |
| <a name="output_job_schedule_ids"></a> [job\_schedule\_ids](#output\_job\_schedule\_ids) | Map of job schedule keys to their IDs. |
| <a name="output_job_schedule_job_ids"></a> [job\_schedule\_job\_ids](#output\_job\_schedule\_job\_ids) | Map of job schedule keys to their job schedule UUIDs. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Automation Runbook. |
| <a name="output_runbook_type"></a> [runbook\_type](#output\_runbook\_type) | The type of the Runbook. |
<!-- END_TF_DOCS -->