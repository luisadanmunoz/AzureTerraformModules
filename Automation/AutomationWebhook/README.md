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
