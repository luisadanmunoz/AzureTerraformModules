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
| [azurerm_static_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/static_web_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | A map of application settings. | `map(string)` | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Static Web App. | `bool` | `true` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | List of User Assigned Identity IDs. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of managed identity. Possible values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Static Web App. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_sku_size"></a> [sku\_size](#input\_sku\_size) | The SKU size. Possible values: Free, Standard. | `string` | `"Free"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | The SKU tier. Possible values: Free, Standard. | `string` | `"Free"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_api_key"></a> [api\_key](#output\_api\_key) | The API key for deployment. |
| <a name="output_default_host_name"></a> [default\_host\_name](#output\_default\_host\_name) | The default hostname of the Static Web App. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Static Web App. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Static Web App. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system-assigned identity. |
<!-- END_TF_DOCS -->