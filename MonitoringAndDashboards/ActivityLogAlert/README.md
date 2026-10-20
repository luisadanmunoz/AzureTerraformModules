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
| [azurerm_monitor_activity_log_alert.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_activity_log_alert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_action_group_ids"></a> [action\_group\_ids](#input\_action\_group\_ids) | List of Action Group IDs to notify. | `list(string)` | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Activity Log Alert. | `bool` | `true` | no |
| <a name="input_criteria"></a> [criteria](#input\_criteria) | The criteria for the Activity Log Alert. | <pre>object({<br/>    category                = string<br/>    operation_name          = optional(string)<br/>    resource_provider       = optional(string)<br/>    resource_type           = optional(string)<br/>    resource_group          = optional(string)<br/>    caller                  = optional(string)<br/>    level                   = optional(string)<br/>    status                  = optional(string)<br/>    sub_status              = optional(string)<br/>    recommendation_type     = optional(string)<br/>    recommendation_category = optional(string)<br/>    recommendation_impact   = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description of the Activity Log Alert. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether the Activity Log Alert is enabled. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Activity Log Alert. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | List of resource IDs to scope the alert to. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Activity Log Alert. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Activity Log Alert. |
<!-- END_TF_DOCS -->