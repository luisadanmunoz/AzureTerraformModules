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
