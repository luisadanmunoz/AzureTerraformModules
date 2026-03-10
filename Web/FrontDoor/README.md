# Azure Front Door

Terraform module for creating Azure Front Door Profile resources.

## Features

- Global load balancing and CDN acceleration
- Standard and Premium SKU tiers
- Configurable response timeout
- Conditional resource creation

## Usage

```hcl
module "front_door" {
  source = "path/to/Web/FrontDoor"

  name                = "afd-webapp-prod"
  resource_group_name = azurerm_resource_group.web.name
  sku_name            = "Standard_AzureFrontDoor"

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
| name | Profile name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| sku_name | SKU name | `string` | `"Standard_AzureFrontDoor"` | no |
| response_timeout_seconds | Response timeout | `number` | `120` | no |
| create | Whether to create | `bool` | `true` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The profile ID |
| name | The profile name |
| resource_guid | The profile UUID |
