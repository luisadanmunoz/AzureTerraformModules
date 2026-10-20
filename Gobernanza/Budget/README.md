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
| [azurerm_consumption_budget_management_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_management_group) | resource |
| [azurerm_consumption_budget_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_resource_group) | resource |
| [azurerm_consumption_budget_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_subscription) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_amount"></a> [amount](#input\_amount) | The budget amount. | `number` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_filter"></a> [filter](#input\_filter) | Filter configuration for the budget. | <pre>object({<br/>    dimensions = optional(list(object({<br/>      name   = string<br/>      values = list(string)<br/>    })), [])<br/>    tags = optional(list(object({<br/>      name   = string<br/>      values = list(string)<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | The ID of the Management Group for the budget (when scope\_type is management\_group). | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the budget. | `string` | n/a | yes |
| <a name="input_notifications"></a> [notifications](#input\_notifications) | List of budget notifications. | <pre>list(object({<br/>    enabled        = optional(bool, true)<br/>    threshold      = number<br/>    threshold_type = optional(string, "Actual")<br/>    operator       = string<br/>    contact_emails = optional(list(string), [])<br/>    contact_groups = optional(list(string), [])<br/>    contact_roles  = optional(list(string), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | The ID of the Resource Group for the budget (when scope\_type is resource\_group). | `string` | `null` | no |
| <a name="input_scope_type"></a> [scope\_type](#input\_scope\_type) | The type of scope for the budget: subscription, resource\_group, or management\_group. | `string` | `"subscription"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The ID of the Subscription for the budget (when scope\_type is subscription). Uses current if null. | `string` | `null` | no |
| <a name="input_time_grain"></a> [time\_grain](#input\_time\_grain) | The time grain for the budget. Possible values are BillingAnnual, BillingMonth, BillingQuarter, Annually, Monthly, Quarterly. | `string` | `"Monthly"` | no |
| <a name="input_time_period"></a> [time\_period](#input\_time\_period) | The time period for the budget. | <pre>object({<br/>    start_date = string<br/>    end_date   = optional(string)<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Budget. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Budget. |
<!-- END_TF_DOCS -->