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
| [azurerm_management_group_policy_exemption.policy_exemption_management_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_exemption) | resource |
| [azurerm_resource_group_policy_exemption.policy_exemption_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_exemption) | resource |
| [azurerm_resource_policy_exemption.policy_exemption_resource](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_policy_exemption) | resource |
| [azurerm_subscription_policy_exemption.policy_exemption_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_exemption) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | value to set the display name | `string` | `null` | no |
| <a name="input_exemption_category"></a> [exemption\_category](#input\_exemption\_category) | value to set the exemption category | `string` | `"Waiver"` | no |
| <a name="input_expires_on"></a> [expires\_on](#input\_expires\_on) | value to set the expires on | `string` | `null` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | value to set the metadata | `any` | `null` | no |
| <a name="input_policy_assignment_id"></a> [policy\_assignment\_id](#input\_policy\_assignment\_id) | value to set the policy assignment id | `string` | n/a | yes |
| <a name="input_policy_definition_reference_ids"></a> [policy\_definition\_reference\_ids](#input\_policy\_definition\_reference\_ids) | value to set the policy definition reference ids | `list(string)` | `[]` | no |
| <a name="input_policy_exemption_name"></a> [policy\_exemption\_name](#input\_policy\_exemption\_name) | value to set the policy exemption name | `string` | n/a | yes |
| <a name="input_scope_id"></a> [scope\_id](#input\_scope\_id) | value to set the scope id | `string` | n/a | yes |
| <a name="input_scope_type"></a> [scope\_type](#input\_scope\_type) | value to set the scope type | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT POLICY EXEMPTION ############################################################################ |
<!-- END_TF_DOCS -->