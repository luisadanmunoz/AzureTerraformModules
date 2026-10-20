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
| [azurerm_policy_definition.policy_definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | value to set the display name | `string` | n/a | yes |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | value to set the management group id | `string` | `null` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | value to set the metadata | `any` | `{}` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | value to set the mode | `string` | `"All"` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | value to set the parameters | `any` | `null` | no |
| <a name="input_policy_definition_name"></a> [policy\_definition\_name](#input\_policy\_definition\_name) | value to set the policy definition name | `string` | n/a | yes |
| <a name="input_policy_rule"></a> [policy\_rule](#input\_policy\_rule) | value to set the policy rule | `any` | n/a | yes |
| <a name="input_policy_type"></a> [policy\_type](#input\_policy\_type) | value to set the policy type | `string` | `"Custom"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT POLICY DEFINITION ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->