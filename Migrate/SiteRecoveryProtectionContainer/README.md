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
| [azurerm_site_recovery_protection_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the protection container. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the protection container. | `string` | n/a | yes |
| <a name="input_recovery_fabric_name"></a> [recovery\_fabric\_name](#input\_recovery\_fabric\_name) | The name of the Site Recovery Fabric. | `string` | n/a | yes |
| <a name="input_recovery_vault_name"></a> [recovery\_vault\_name](#input\_recovery\_vault\_name) | The name of the Recovery Services Vault. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Protection Container. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Protection Container. |
<!-- END_TF_DOCS -->