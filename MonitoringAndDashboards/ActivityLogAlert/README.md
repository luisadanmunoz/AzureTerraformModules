# Azure Monitor Activity Log Alert

Terraform module for creating Azure Monitor Activity Log Alert resources.

## Features

- Activity log monitoring for administrative, service health, and recommendation events
- Configurable criteria filtering by category, operation, resource type, and level
- Action Group integration for notifications
- Conditional resource creation

## Usage

```hcl
module "activity_alert" {
  source = "path/to/MonitoringAndDashboards/ActivityLogAlert"

  name                = "alert-vm-delete"
  resource_group_name = azurerm_resource_group.monitoring.name
  scopes              = [data.azurerm_subscription.current.id]

  criteria = {
    category       = "Administrative"
    operation_name = "Microsoft.Compute/virtualMachines/delete"
    level          = "Error"
  }

  action_group_ids = [module.action_group.id]
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
| name | Alert name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| scopes | Resource IDs to scope | `list(string)` | n/a | yes |
| criteria | Alert criteria | `object` | n/a | yes |
| enabled | Whether enabled | `bool` | `true` | no |
| action_group_ids | Action Group IDs | `list(string)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The alert ID |
| name | The alert name |
