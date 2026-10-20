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
| [azurerm_portal_dashboard.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/portal_dashboard) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Dashboard. | `bool` | `true` | no |
| <a name="input_dashboard_properties"></a> [dashboard\_properties](#input\_dashboard\_properties) | The JSON definition of the dashboard layout and tiles. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Dashboard. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Dashboard. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Dashboard. |
<!-- END_TF_DOCS -->