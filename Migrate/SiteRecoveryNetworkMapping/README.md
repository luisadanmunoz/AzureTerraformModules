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
| [azurerm_site_recovery_network_mapping.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_network_mapping) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the network mapping. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the network mapping. | `string` | n/a | yes |
| <a name="input_recovery_vault_name"></a> [recovery\_vault\_name](#input\_recovery\_vault\_name) | The name of the Recovery Services Vault. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_source_network_id"></a> [source\_network\_id](#input\_source\_network\_id) | The ID of the source virtual network. | `string` | n/a | yes |
| <a name="input_source_recovery_fabric_name"></a> [source\_recovery\_fabric\_name](#input\_source\_recovery\_fabric\_name) | The name of the source Site Recovery Fabric. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |
| <a name="input_target_network_id"></a> [target\_network\_id](#input\_target\_network\_id) | The ID of the target virtual network. | `string` | n/a | yes |
| <a name="input_target_recovery_fabric_name"></a> [target\_recovery\_fabric\_name](#input\_target\_recovery\_fabric\_name) | The name of the target Site Recovery Fabric. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Network Mapping. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Network Mapping. |
<!-- END_TF_DOCS -->