# Azure Monitor Diagnostic Setting

Terraform module for creating Azure Monitor Diagnostic Setting resources.

## Features

- Send logs and metrics to Log Analytics, Storage, or Event Hub
- Configurable log categories and category groups
- Metric collection with retention policies
- Multi-destination support
- Conditional resource creation

## Usage

```hcl
module "diagnostic_setting" {
  source = "path/to/MonitoringAndDashboards/DiagnosticSetting"

  name                       = "diag-keyvault"
  target_resource_id         = azurerm_key_vault.main.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_logs = [
    { category_group = "allLogs" }
  ]

  metrics = [
    { category = "AllMetrics" }
  ]
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
| name | Setting name | `string` | n/a | yes |
| target_resource_id | Target resource ID | `string` | n/a | yes |
| log_analytics_workspace_id | Log Analytics Workspace ID | `string` | `null` | no |
| storage_account_id | Storage Account ID | `string` | `null` | no |
| enabled_logs | Log categories to enable | `list(object)` | `[]` | no |
| metrics | Metric categories to enable | `list(object)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The setting ID |
| name | The setting name |

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
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Diagnostic Setting. | `bool` | `true` | no |
| <a name="input_enabled_logs"></a> [enabled\_logs](#input\_enabled\_logs) | List of log categories to enable. | <pre>list(object({<br/>    category       = optional(string)<br/>    category_group = optional(string)<br/>    retention_policy = optional(object({<br/>      enabled = bool<br/>      days    = optional(number, 0)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_eventhub_authorization_rule_id"></a> [eventhub\_authorization\_rule\_id](#input\_eventhub\_authorization\_rule\_id) | The ID of the Event Hub authorization rule. | `string` | `null` | no |
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | The name of the Event Hub. | `string` | `null` | no |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | The destination type for Log Analytics. Possible values: Dedicated, AzureDiagnostics. | `string` | `null` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID of the Log Analytics Workspace destination. | `string` | `null` | no |
| <a name="input_metrics"></a> [metrics](#input\_metrics) | List of metric categories to enable. | <pre>list(object({<br/>    category = string<br/>    enabled  = optional(bool, true)<br/>    retention_policy = optional(object({<br/>      enabled = bool<br/>      days    = optional(number, 0)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Diagnostic Setting. | `string` | n/a | yes |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | The ID of the Storage Account destination. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags (not applied to diagnostic settings, kept for consistency). | `map(string)` | `{}` | no |
| <a name="input_target_resource_id"></a> [target\_resource\_id](#input\_target\_resource\_id) | The ID of the resource to apply diagnostic settings to. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Diagnostic Setting. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Diagnostic Setting. |
<!-- END_TF_DOCS -->