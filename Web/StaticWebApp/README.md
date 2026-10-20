# Azure Static Web App

Terraform module for creating Azure Static Web App resources.

## Features

- Static web app hosting with global CDN
- Free and Standard SKU tiers
- Application settings configuration
- Managed identity support
- Conditional resource creation

## Usage

```hcl
module "static_web_app" {
  source = "path/to/Web/StaticWebApp"

  name                = "swa-frontend-prod"
  resource_group_name = azurerm_resource_group.web.name
  location            = "eastus2"
  sku_tier            = "Standard"
  sku_size            = "Standard"

  app_settings = {
    API_URL = "https://api.contoso.com"
  }

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
| name | App name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| sku_tier | SKU tier | `string` | `"Free"` | no |
| sku_size | SKU size | `string` | `"Free"` | no |
| app_settings | Application settings | `map(string)` | `{}` | no |
| identity_type | Managed identity type | `string` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The app ID |
| name | The app name |
| default_host_name | The default hostname |
| api_key | Deployment API key (sensitive) |
| principal_id | System identity principal ID |
