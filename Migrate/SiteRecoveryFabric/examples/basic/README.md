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
| <a name="module_fabric_primary"></a> [fabric\_primary](#module\_fabric\_primary) | ../../ | n/a |
| <a name="module_fabric_secondary"></a> [fabric\_secondary](#module\_fabric\_secondary) | ../../ | n/a |

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
| <a name="output_primary_fabric_id"></a> [primary\_fabric\_id](#output\_primary\_fabric\_id) | The ID of the primary fabric. |
| <a name="output_secondary_fabric_id"></a> [secondary\_fabric\_id](#output\_secondary\_fabric\_id) | The ID of the secondary fabric. |
<!-- END_TF_DOCS -->