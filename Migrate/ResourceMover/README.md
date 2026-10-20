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
