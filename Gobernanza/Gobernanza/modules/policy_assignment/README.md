<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_management_group_policy_assignment.policy_assignment_management_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) | resource |
| [azurerm_resource_group_policy_assignment.policy_assignment_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_assignment) | resource |
| [azurerm_resource_policy_assignment.policy_assignment_resource](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_assignment) | resource |
| [azurerm_subscription_policy_assignment.policy_assignment_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | value to set the display name | `string` | `null` | no |
| <a name="input_enforce"></a> [enforce](#input\_enforce) | value to set the enforce | `bool` | `true` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | value to set the identity ids | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | value to set the identity type | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | `null` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | value to set the metadata | `any` | `null` | no |
| <a name="input_not_scopes"></a> [not\_scopes](#input\_not\_scopes) | value to set the not scopes | `list(string)` | `[]` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | value to set the parameters | `any` | `null` | no |
| <a name="input_policy_assignment_name"></a> [policy\_assignment\_name](#input\_policy\_assignment\_name) | value to set the policy assignment name | `string` | n/a | yes |
| <a name="input_policy_definition_id"></a> [policy\_definition\_id](#input\_policy\_definition\_id) | value to set the policy definition id | `string` | n/a | yes |
| <a name="input_scope_id"></a> [scope\_id](#input\_scope\_id) | value to set the scope id | `string` | n/a | yes |
| <a name="input_scope_type"></a> [scope\_type](#input\_scope\_type) | value to set the scope type | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT POLICY ASSIGNMENT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->