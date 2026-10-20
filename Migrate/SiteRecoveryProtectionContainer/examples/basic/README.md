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

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_container_primary"></a> [container\_primary](#module\_container\_primary) | ../../ | n/a |
| <a name="module_container_secondary"></a> [container\_secondary](#module\_container\_secondary) | ../../ | n/a |
| <a name="module_fabric_primary"></a> [fabric\_primary](#module\_fabric\_primary) | ../../../SiteRecoveryFabric | n/a |
| <a name="module_fabric_secondary"></a> [fabric\_secondary](#module\_fabric\_secondary) | ../../../SiteRecoveryFabric | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_recovery_services_vault.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_primary_container_id"></a> [primary\_container\_id](#output\_primary\_container\_id) | The ID of the primary protection container. |
| <a name="output_secondary_container_id"></a> [secondary\_container\_id](#output\_secondary\_container\_id) | The ID of the secondary protection container. |
<!-- END_TF_DOCS -->