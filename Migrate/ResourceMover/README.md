# Azure Resource Mover

Terraform module for creating Azure Resource Mover Move Collection resources.

## Features

- Move Collection for cross-region resource migration
- System-assigned managed identity
- Source and target region configuration
- Conditional resource creation

## Usage

```hcl
module "resource_mover" {
  source = "path/to/Migrate/ResourceMover"

  name                = "move-eastus-to-westus"
  resource_group_name = azurerm_resource_group.migrate.name
  source_region       = "eastus"
  target_region       = "westus"

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
| name | Move collection name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| source_region | Source Azure region | `string` | n/a | yes |
| target_region | Target Azure region | `string` | n/a | yes |
| identity_type | Managed identity type | `string` | `"SystemAssigned"` | no |
| create | Whether to create | `bool` | `true` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The move collection ID |
| name | The move collection name |
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
| [azurerm_resource_mover_move_collection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_mover_move_collection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Resource Mover Move Collection. | `bool` | `true` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of managed identity. Possible values: SystemAssigned. | `string` | `"SystemAssigned"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Resource Mover Move Collection. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_source_region"></a> [source\_region](#input\_source\_region) | The source Azure region. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |
| <a name="input_target_region"></a> [target\_region](#input\_target\_region) | The target Azure region. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Move Collection. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Move Collection. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The principal ID of the system-assigned identity. |
<!-- END_TF_DOCS -->