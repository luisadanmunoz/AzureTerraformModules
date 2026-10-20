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
| [azurerm_cdn_frontdoor_profile.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_profile) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Front Door Profile. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Front Door Profile. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_response_timeout_seconds"></a> [response\_timeout\_seconds](#input\_response\_timeout\_seconds) | The maximum response timeout in seconds. | `number` | `120` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name. Possible values: Standard\_AzureFrontDoor, Premium\_AzureFrontDoor. | `string` | `"Standard_AzureFrontDoor"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Front Door Profile. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Front Door Profile. |
| <a name="output_resource_guid"></a> [resource\_guid](#output\_resource\_guid) | The UUID of the Front Door Profile. |
<!-- END_TF_DOCS -->