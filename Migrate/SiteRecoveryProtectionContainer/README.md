# Azure Site Recovery Protection Container

Terraform module for creating Azure Site Recovery Protection Container resources.

## Features

- Protection container for grouping replicated items
- Integration with Recovery Services Vault and Fabric
- Conditional resource creation

## Usage

```hcl
module "protection_container" {
  source = "path/to/Migrate/SiteRecoveryProtectionContainer"

  name                 = "container-primary"
  resource_group_name  = azurerm_resource_group.dr.name
  recovery_vault_name  = azurerm_recovery_services_vault.main.name
  recovery_fabric_name = module.fabric_primary.name
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
| name | Container name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| recovery_vault_name | Recovery Services Vault name | `string` | n/a | yes |
| recovery_fabric_name | Recovery Fabric name | `string` | n/a | yes |
| create | Whether to create | `bool` | `true` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The container ID |
| name | The container name |
