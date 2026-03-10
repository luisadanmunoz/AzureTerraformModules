# Azure Portal Dashboard

Terraform module for creating Azure Portal Dashboard resources.

## Features

- Custom Azure portal dashboards
- JSON-based dashboard layout definition
- Shared dashboards across the organization
- Conditional resource creation

## Usage

```hcl
module "dashboard" {
  source = "path/to/MonitoringAndDashboards/Dashboard"

  name                = "dash-operations"
  resource_group_name = azurerm_resource_group.monitoring.name
  location            = "eastus"

  dashboard_properties = jsonencode({
    lenses = {
      "0" = {
        order = 0
        parts = {}
      }
    }
  })

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
| name | Dashboard name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| dashboard_properties | JSON dashboard definition | `string` | `null` | no |
| create | Whether to create | `bool` | `true` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The dashboard ID |
| name | The dashboard name |
