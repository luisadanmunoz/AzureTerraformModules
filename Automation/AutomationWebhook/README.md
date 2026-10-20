# Azure Automation Webhook Module

Terraform module to create and manage **Azure Automation Webhooks** for triggering runbooks via HTTP POST requests.

## Features

- Create webhooks to trigger runbooks externally
- Multiple webhooks in a single module call
- Pass parameters to runbooks
- Hybrid Worker Group support
- Configurable expiry time
- Enable/disable webhooks
- Conditional creation with `create = true/false`

## Usage - Single Webhook

```hcl
module "automation_webhook" {
  source = "path/to/Automation/AutomationWebhook"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  webhooks = {
    "StartVMs" = {
      runbook_name = "Start-VirtualMachines"
      expiry_time  = "2025-12-31T23:59:59Z"
      parameters = {
        ResourceGroupName = "rg-vms-prod"
        Environment       = "Production"
      }
    }
  }
}
```

## Usage - Multiple Webhooks

```hcl
module "automation_webhooks" {
  source = "path/to/Automation/AutomationWebhook"

  resource_group_name     = "rg-automation-dev-001"
  automation_account_name = "aa-runbooks-dev-001"

  webhooks = {
    "StartVMs-Prod" = {
      runbook_name = "Start-VirtualMachines"
      expiry_time  = timeadd(timestamp(), "8760h") # 1 year
      parameters = {
        Environment = "Production"
      }
    }
    "StopVMs-Prod" = {
      runbook_name = "Stop-VirtualMachines"
      expiry_time  = timeadd(timestamp(), "8760h")
      parameters = {
        Environment = "Production"
      }
    }
    "Cleanup-Dev" = {
      runbook_name = "Cleanup-Resources"
      expiry_time  = timeadd(timestamp(), "8760h")
      parameters = {
        Environment = "Development"
        DryRun      = "false"
      }
    }
  }

  lifecycle {
    ignore_changes = [webhooks["StartVMs-Prod"].expiry_time]
  }
}
```

## Usage - With Hybrid Worker

```hcl
module "automation_webhook" {
  source = "path/to/Automation/AutomationWebhook"

  resource_group_name     = "rg-automation-prod-001"
  automation_account_name = "aa-runbooks-prod-001"

  webhooks = {
    "OnPremTask" = {
      runbook_name        = "Run-OnPremisesTask"
      expiry_time         = "2025-12-31T23:59:59Z"
      run_on_worker_group = "OnPremWorkerGroup"
      parameters = {
        ServerName = "server01.domain.local"
      }
    }
  }
}
```

## Calling Webhooks

### PowerShell

```powershell
$webhookUri = "https://xxx.webhook.wus2.azure-automation.net/webhooks?token=xxx"

# Simple call
Invoke-RestMethod -Uri $webhookUri -Method Post

# With parameters (override module defaults)
$body = @{
    ResourceGroupName = "rg-custom"
    VMName = "vm-specific"
} | ConvertTo-Json

Invoke-RestMethod -Uri $webhookUri -Method Post -Body $body -ContentType "application/json"
```

### curl

```bash
# Simple call
curl -X POST "https://xxx.webhook.wus2.azure-automation.net/webhooks?token=xxx"

# With parameters
curl -X POST "https://xxx.webhook.wus2.azure-automation.net/webhooks?token=xxx" \
  -H "Content-Type: application/json" \
  -d '{"ResourceGroupName": "rg-custom", "VMName": "vm-specific"}'
```

### Azure Logic Apps / Power Automate

Use HTTP action with:
- Method: POST
- URI: (webhook URI from output)
- Body: JSON with parameters

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create the webhooks | `bool` | `true` | no |
| `resource_group_name` | Name of the Resource Group | `string` | - | yes |
| `automation_account_name` | Name of the Automation Account | `string` | - | yes |
| `webhooks` | Map of webhooks to create | `map(object)` | `{}` | no |

### Webhook Object Attributes

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| `runbook_name` | Name of the Runbook to trigger | `string` | yes |
| `expiry_time` | Expiry time in RFC3339 format | `string` | yes |
| `enabled` | Whether the webhook is enabled | `bool` | no (default: true) |
| `parameters` | Parameters to pass to the Runbook | `map(string)` | no |
| `run_on_worker_group` | Hybrid Worker Group name | `string` | no |
| `uri` | Custom URI (auto-generated if not set) | `string` | no |

## Outputs

| Name | Description |
|------|-------------|
| `webhook_ids` | Map of webhook names to their IDs |
| `webhook_names` | List of created webhook names |
| `webhook_uris` | Map of webhook names to their URIs (sensitive) |
| `webhook_expiry_times` | Map of webhook names to their expiry times |

## Dependencies

- **Resource Group** must exist
- **Automation Account** must exist
- **Runbook** must exist before creating webhook
- **Hybrid Worker Group** must exist if `run_on_worker_group` is specified

## Security Notes

- Webhook URIs are sensitive and should be stored securely
- URIs contain authentication tokens - treat as secrets
- Use short expiry times when possible
- Disable webhooks when not in use
- Consider IP restrictions at the network level
- Monitor webhook usage in Automation Account logs

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
| [azurerm_automation_webhook.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_webhook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_automation_account_name"></a> [automation\_account\_name](#input\_automation\_account\_name) | (Required) The name of the Automation Account. DEPENDENCY: Automation Account must exist. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Automation Webhooks. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Automation Account exists. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_webhooks"></a> [webhooks](#input\_webhooks) | (Optional) Map of webhooks to create. The key is the webhook name.<br/>- runbook\_name: (Required) The name of the Runbook to trigger. DEPENDENCY: Runbook must exist.<br/>- expiry\_time: (Required) The expiry time in RFC3339 format (e.g., "2025-12-31T23:59:59Z").<br/>- enabled: (Optional) Whether the webhook is enabled. Default: true.<br/>- parameters: (Optional) Map of parameters to pass to the Runbook.<br/>- run\_on\_worker\_group: (Optional) Name of Hybrid Worker Group. DEPENDENCY: Hybrid Worker Group must exist if specified.<br/>- uri: (Optional) Custom URI for the webhook. If not provided, Azure generates one. | <pre>map(object({<br/>    runbook_name        = string<br/>    expiry_time         = string<br/>    enabled             = optional(bool, true)<br/>    parameters          = optional(map(string), {})<br/>    run_on_worker_group = optional(string, null)<br/>    uri                 = optional(string, null)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_webhook_expiry_times"></a> [webhook\_expiry\_times](#output\_webhook\_expiry\_times) | Map of webhook names to their expiry times. |
| <a name="output_webhook_ids"></a> [webhook\_ids](#output\_webhook\_ids) | Map of webhook names to their IDs. |
| <a name="output_webhook_names"></a> [webhook\_names](#output\_webhook\_names) | List of created webhook names. |
| <a name="output_webhook_uris"></a> [webhook\_uris](#output\_webhook\_uris) | Map of webhook names to their URIs. SENSITIVE: Store securely. |
<!-- END_TF_DOCS -->