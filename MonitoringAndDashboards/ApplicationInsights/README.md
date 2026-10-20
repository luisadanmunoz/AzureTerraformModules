# Azure Application Insights Terraform Module

This Terraform module creates an Azure Application Insights resource for application performance monitoring, diagnostics, and analytics.

## Features

- Support for both workspace-based (recommended) and classic Application Insights
- Configurable data retention and daily data caps
- Sampling configuration for high-volume telemetry
- Privacy controls including IP masking
- Network access controls for ingestion and querying
- Flexible naming with support for naming conventions

## Usage

### Workspace-based Application Insights (Recommended)

Microsoft recommends using workspace-based Application Insights for new deployments. This configuration stores telemetry data in a Log Analytics workspace, enabling unified querying across all Azure Monitor data.

```hcl
module "log_analytics" {
  source = "../LogAnalytics"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  workload            = "myapp"
  environment         = "prod"
}

module "application_insights" {
  source = "../ApplicationInsights"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  workload            = "myapp"
  environment         = "prod"

  # Link to Log Analytics workspace
  workspace_id = module.log_analytics.id

  application_type = "web"

  tags = {
    Application = "MyWebApp"
  }
}
```

### Classic Application Insights

For scenarios where workspace-based Application Insights is not suitable, you can create a classic (standalone) Application Insights resource.

```hcl
module "application_insights" {
  source = "../ApplicationInsights"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "appi-myapp-classic"

  application_type  = "web"
  retention_in_days = 90

  # Classic Application Insights (no workspace_id)

  tags = {
    Application = "MyWebApp"
  }
}
```

### With Data Cap and Sampling

```hcl
module "application_insights" {
  source = "../ApplicationInsights"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  workload            = "highvolume"
  environment         = "prod"

  workspace_id     = module.log_analytics.id
  application_type = "web"

  # Limit daily data ingestion to 10 GB
  daily_data_cap_in_gb                  = 10
  daily_data_cap_notifications_disabled = false

  # Sample only 50% of telemetry
  sampling_percentage = 50

  tags = {
    Application = "HighVolumeApp"
  }
}
```

### With Enhanced Security

```hcl
module "application_insights" {
  source = "../ApplicationInsights"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  workload            = "secure"
  environment         = "prod"

  workspace_id     = module.log_analytics.id
  application_type = "web"

  # Disable local (API key) authentication - require AAD
  local_authentication_disabled = true

  # Disable public internet access
  internet_ingestion_enabled = false
  internet_query_enabled     = false

  tags = {
    Application = "SecureApp"
  }
}
```

### Conditional Creation

```hcl
module "application_insights" {
  source = "../ApplicationInsights"

  # Only create in production
  create = var.environment == "prod"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  workload            = "myapp"
  environment         = var.environment

  workspace_id     = module.log_analytics.id
  application_type = "web"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.70.0, < 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | The name of the resource group where the Application Insights will be created. | `string` | n/a | yes |
| location | The Azure region where the Application Insights will be created. | `string` | n/a | yes |
| create | Controls whether the Application Insights resource should be created. | `bool` | `true` | no |
| name | The name of the Application Insights. If provided, overrides the generated name. | `string` | `null` | no |
| name_prefix | The prefix for the Application Insights name. Used when generating the name. | `string` | `"appi"` | no |
| workload | The workload name to use in the generated name. | `string` | `null` | no |
| environment | The environment name (e.g., dev, staging, prod) to use in the generated name. | `string` | `null` | no |
| instance | The instance identifier to use in the generated name. | `string` | `null` | no |
| tags | A map of tags to apply to the Application Insights resource. | `map(string)` | `{}` | no |
| application_type | Specifies the type of Application Insights to create. Valid values: ios, java, MobileCenter, Node.JS, other, phone, store, web. | `string` | `"web"` | no |
| workspace_id | The ID of the Log Analytics Workspace to associate with this Application Insights. | `string` | `null` | no |
| daily_data_cap_in_gb | The daily data volume cap in GB. When set, data ingestion will be stopped once the cap is hit. | `number` | `null` | no |
| daily_data_cap_notifications_disabled | Specifies if a notification email will be sent when the daily data volume cap is met. | `bool` | `false` | no |
| retention_in_days | The number of days to retain data. Valid values: 30, 60, 90, 120, 180, 270, 365, 550, 730. | `number` | `90` | no |
| sampling_percentage | The percentage of telemetry items that will be sampled (0-100). | `number` | `null` | no |
| disable_ip_masking | By default, the last octet of the IP address is masked to 0. Set to true to disable this behavior. | `bool` | `false` | no |
| local_authentication_disabled | Disable local authentication to disable non-AAD based access to Application Insights. | `bool` | `false` | no |
| internet_ingestion_enabled | Should the Application Insights component support ingestion over the public internet. | `bool` | `true` | no |
| internet_query_enabled | Should the Application Insights component support querying over the public internet. | `bool` | `true` | no |
| force_customer_storage_for_profiler | Should the Application Insights component force users to create their own storage account for profiling. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Application Insights resource. |
| name | The name of the Application Insights resource. |
| app_id | The App ID associated with this Application Insights resource. |
| instrumentation_key | The Instrumentation Key for this Application Insights resource. (sensitive) |
| connection_string | The Connection String for this Application Insights resource. (sensitive) |

## Dependencies

This module has the following dependencies:

- **Resource Group**: The resource group specified in `resource_group_name` must exist before creating the Application Insights resource.
- **Log Analytics Workspace** (optional): If `workspace_id` is provided, the Log Analytics workspace must exist. This is recommended for workspace-based Application Insights.

## Notes

### Workspace-based vs Classic Application Insights

- **Workspace-based** (recommended): Telemetry data is stored in a Log Analytics workspace, enabling unified querying with other Azure Monitor data. Retention is controlled by the Log Analytics workspace settings.
- **Classic**: Telemetry data is stored within the Application Insights resource. The `retention_in_days` setting controls data retention.

### Sensitive Outputs

The `instrumentation_key` and `connection_string` outputs are marked as sensitive. These values are used to configure your application to send telemetry to Application Insights. Store them securely and avoid exposing them in logs or version control.

### Application Types

The `application_type` parameter affects some behaviors in the Azure portal but does not change the underlying data collection:

- `web` - ASP.NET, Java, Node.js web applications
- `java` - Java applications
- `Node.JS` - Node.js applications
- `ios` - iOS applications
- `phone` - Windows Phone applications
- `store` - Windows Store applications
- `MobileCenter` - Mobile applications using App Center
- `other` - Other application types

## License

This module is open source and available under the MIT License.
