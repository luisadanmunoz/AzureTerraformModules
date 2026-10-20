# Azure Monitor Action Group

Terraform module for creating Azure Monitor Action Group resources.

## Features

- Email, SMS, and push notification receivers
- Webhook integration
- Logic App and Azure Function receivers
- Common alert schema support
- Conditional resource creation

## Usage

```hcl
module "action_group" {
  source = "path/to/MonitoringAndDashboards/ActionGroup"

  name                = "ag-critical-alerts"
  resource_group_name = azurerm_resource_group.monitoring.name
  short_name          = "critical"

  email_receivers = [
    {
      name          = "oncall-team"
      email_address = "oncall@contoso.com"
    }
  ]

  tags = {
    Environment = "Production"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Action group name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| short_name | Short name (max 12 chars) | `string` | n/a | yes |
| enabled | Whether enabled | `bool` | `true` | no |
| email_receivers | Email receivers | `list(object)` | `[]` | no |
| sms_receivers | SMS receivers | `list(object)` | `[]` | no |
| webhook_receivers | Webhook receivers | `list(object)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The action group ID |
| name | The action group name |
