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
| <a name="module_vnm"></a> [vnm](#module\_vnm) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cross_tenant_scopes"></a> [cross\_tenant\_scopes](#output\_cross\_tenant\_scopes) | The cross-tenant scopes of the Virtual Network Manager |
| <a name="output_network_group_ids"></a> [network\_group\_ids](#output\_network\_group\_ids) | Map of Network Group names to their IDs |
| <a name="output_vnm_id"></a> [vnm\_id](#output\_vnm\_id) | The ID of the created Virtual Network Manager |
| <a name="output_vnm_name"></a> [vnm\_name](#output\_vnm\_name) | The name of the created Virtual Network Manager |
<!-- END_TF_DOCS -->