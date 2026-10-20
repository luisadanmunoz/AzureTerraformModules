# Azure Site Recovery Replication Policy

Terraform module for creating Azure Site Recovery Replication Policy resources.

## Features

- Configurable recovery point retention
- Application-consistent snapshot frequency
- Integration with Recovery Services Vault
- Conditional resource creation

## Usage

```hcl
module "replication_policy" {
  source = "path/to/Migrate/SiteRecoveryReplicationPolicy"

  name                = "replication-policy-24h"
  resource_group_name = azurerm_resource_group.dr.name
  recovery_vault_name = azurerm_recovery_services_vault.main.name

  recovery_point_retention_in_minutes                  = 1440
  application_consistent_snapshot_frequency_in_minutes = 240
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
| name | Policy name | `string` | n/a | yes |
| resource_group_name | Resource group | `string` | n/a | yes |
| recovery_vault_name | Recovery Services Vault name | `string` | n/a | yes |
| recovery_point_retention_in_minutes | Recovery point retention (minutes) | `number` | `1440` | no |
| application_consistent_snapshot_frequency_in_minutes | App-consistent snapshot frequency (minutes) | `number` | `240` | no |
| create | Whether to create | `bool` | `true` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The policy ID |
| name | The policy name |
