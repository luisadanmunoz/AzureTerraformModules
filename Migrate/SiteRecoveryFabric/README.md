# Azure Site Recovery Fabric

Terraform module for creating Azure Site Recovery Fabric resources.

## Features

- Site Recovery Fabric for disaster recovery replication
- Integration with Recovery Services Vault
- Conditional resource creation

## Usage

```hcl
module "recovery_fabric" {
  source = "path/to/Migrate/SiteRecoveryFabric"

  name                = "fabric-eastus"
  resource_group_name = azurerm_resource_group.dr.name
  recovery_vault_name = azurerm_recovery_services_vault.main.name
  location            = "eastus"
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
| name | Fabric name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| recovery_vault_name | Recovery Services Vault name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| create | Whether to create | `bool` | `true` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The fabric ID |
| name | The fabric name |
