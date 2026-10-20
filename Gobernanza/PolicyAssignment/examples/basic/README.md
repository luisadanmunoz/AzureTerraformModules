<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_allowed_locations_assignment"></a> [allowed\_locations\_assignment](#module\_allowed\_locations\_assignment) | ../../ | n/a |
| <a name="module_inherit_environment_tag"></a> [inherit\_environment\_tag](#module\_inherit\_environment\_tag) | ../../ | n/a |
| <a name="module_production_storage_https"></a> [production\_storage\_https](#module\_production\_storage\_https) | ../../ | n/a |
| <a name="module_require_costcenter_tag"></a> [require\_costcenter\_tag](#module\_require\_costcenter\_tag) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.policy_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_policy_definition.allowed_locations](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |
| [azurerm_policy_definition.inherit_tag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |
| [azurerm_policy_definition.require_tag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_allowed_locations_assignment_id"></a> [allowed\_locations\_assignment\_id](#output\_allowed\_locations\_assignment\_id) | n/a |
| <a name="output_inherit_tag_assignment_id"></a> [inherit\_tag\_assignment\_id](#output\_inherit\_tag\_assignment\_id) | n/a |
| <a name="output_inherit_tag_principal_id"></a> [inherit\_tag\_principal\_id](#output\_inherit\_tag\_principal\_id) | n/a |
| <a name="output_require_tag_assignment_id"></a> [require\_tag\_assignment\_id](#output\_require\_tag\_assignment\_id) | n/a |
<!-- END_TF_DOCS -->