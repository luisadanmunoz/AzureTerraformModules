# Azure Site Recovery Network Mapping

Terraform module for creating Azure Site Recovery Network Mapping resources.

## Features

- Maps source virtual networks to target virtual networks for failover
- Integration with Recovery Services Vault and Fabrics
- Conditional resource creation

## Usage

```hcl
module "network_mapping" {
  source = "path/to/Migrate/SiteRecoveryNetworkMapping"

  name                        = "network-mapping-eastus-westus"
  resource_group_name         = azurerm_resource_group.dr.name
  recovery_vault_name         = azurerm_recovery_services_vault.main.name
  source_recovery_fabric_name = module.fabric_primary.name
  target_recovery_fabric_name = module.fabric_secondary.name
  source_network_id           = azurerm_virtual_network.primary.id
  target_network_id           = azurerm_virtual_network.secondary.id
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
| name | Mapping name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| recovery_vault_name | Recovery Services Vault name | `string` | n/a | yes |
| source_recovery_fabric_name | Source fabric name | `string` | n/a | yes |
| target_recovery_fabric_name | Target fabric name | `string` | n/a | yes |
| source_network_id | Source VNet ID | `string` | n/a | yes |
| target_network_id | Target VNet ID | `string` | n/a | yes |
| create | Whether to create | `bool` | `true` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The mapping ID |
| name | The mapping name |
