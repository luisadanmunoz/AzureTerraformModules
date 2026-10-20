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
| [azurerm_site_recovery_replication_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_replication_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_application_consistent_snapshot_frequency_in_minutes"></a> [application\_consistent\_snapshot\_frequency\_in\_minutes](#input\_application\_consistent\_snapshot\_frequency\_in\_minutes) | The frequency in minutes for application-consistent snapshots. | `number` | `240` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the replication policy. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the replication policy. | `string` | n/a | yes |
| <a name="input_recovery_point_retention_in_minutes"></a> [recovery\_point\_retention\_in\_minutes](#input\_recovery\_point\_retention\_in\_minutes) | The duration in minutes for which recovery points are retained. | `number` | `1440` | no |
| <a name="input_recovery_vault_name"></a> [recovery\_vault\_name](#input\_recovery\_vault\_name) | The name of the Recovery Services Vault. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Replication Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Replication Policy. |
<!-- END_TF_DOCS -->