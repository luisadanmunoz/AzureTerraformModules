# SharedImageGallery

Terraform module for creating Azure Shared Image Galleries (Azure Compute Gallery).

## Features

- Private, Groups, or Community sharing
- Community gallery with EULA and publisher info
- Custom descriptions
- Conditional creation

## Usage

```hcl
module "gallery" {
  source = "./Compute/SharedImageGallery"

  resource_group_name = "rg-images-prod-001"
  location            = "westeurope"

  workload    = "golden"
  environment = "prod"

  description = "Golden images for production workloads"
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
| create | Controls creation | `bool` | `true` | no |
| resource_group_name | Resource Group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | Gallery name | `string` | `null` | no |
| description | Description | `string` | `null` | no |
| sharing | Sharing config | `object` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Gallery ID |
| name | Gallery name |
| unique_name | Unique gallery name |

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
| [azurerm_shared_image_gallery.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/shared_image_gallery) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Shared Image Gallery. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description for the Shared Image Gallery. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Gallery should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Gallery. Must be unique. Only alphanumeric, underscores, periods allowed. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'gal'. | `string` | `"gal"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_sharing"></a> [sharing](#input\_sharing) | (Optional) Sharing configuration.<br/>- permission: Sharing permission. Values: Community, Groups, Private. Default: Private.<br/>- community\_gallery: Community gallery configuration (for Community permission). | <pre>object({<br/>    permission = optional(string, "Private")<br/>    community_gallery = optional(object({<br/>      eula            = string<br/>      prefix          = string<br/>      publisher_email = string<br/>      publisher_uri   = string<br/>    }), null)<br/>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"images"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Shared Image Gallery. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Shared Image Gallery. |
| <a name="output_unique_name"></a> [unique\_name](#output\_unique\_name) | The unique name of the Shared Image Gallery. |
<!-- END_TF_DOCS -->