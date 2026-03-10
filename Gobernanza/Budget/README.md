# Budget

Terraform module for Azure Consumption Budget.

## Features

- Budget creation at subscription, resource group, or management group scope
- Multiple notification thresholds
- Actual and forecasted spend alerts
- Filter by dimensions and tags
- Email, action group, and role-based notifications

## Usage

### Subscription Budget

```hcl
module "budget_subscription" {
  source = "./Gobernanza/Budget"

  name       = "monthly-budget"
  amount     = 10000
  time_grain = "Monthly"

  time_period = {
    start_date = "2024-01-01T00:00:00Z"
  }

  notifications = [
    {
      threshold      = 80
      operator       = "GreaterThanOrEqualTo"
      contact_emails = ["finance@company.com"]
    },
    {
      threshold      = 100
      operator       = "GreaterThanOrEqualTo"
      contact_emails = ["finance@company.com", "cto@company.com"]
    }
  ]
}
```

### Resource Group Budget with Filters

```hcl
module "budget_rg" {
  source = "./Gobernanza/Budget"

  name              = "project-budget"
  amount            = 5000
  time_grain        = "Monthly"
  scope_type        = "resource_group"
  resource_group_id = azurerm_resource_group.project.id

  time_period = {
    start_date = "2024-01-01T00:00:00Z"
  }

  filter = {
    tags = [
      {
        name   = "Environment"
        values = ["Production"]
      }
    ]
  }

  notifications = [
    {
      threshold      = 50
      threshold_type = "Forecasted"
      operator       = "GreaterThan"
      contact_emails = ["team@company.com"]
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Budget name | `string` | n/a | yes |
| amount | Budget amount | `number` | n/a | yes |
| time_grain | Time grain | `string` | `"Monthly"` | no |
| time_period | Time period | `object` | n/a | yes |
| scope_type | Scope type | `string` | `"subscription"` | no |
| resource_group_id | Resource group ID | `string` | `null` | no |
| subscription_id | Subscription ID | `string` | `null` | no |
| management_group_id | Management group ID | `string` | `null` | no |
| notifications | Notification list | `list(object)` | `[]` | no |
| filter | Filter configuration | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Budget ID |
| name | Budget name |

## Best Practices

1. **Set multiple thresholds** - Alert at 50%, 80%, and 100%
2. **Use forecasted alerts** - Get early warnings
3. **Include stakeholders** - Notify finance and engineering
4. **Filter appropriately** - Target specific resources or tags
