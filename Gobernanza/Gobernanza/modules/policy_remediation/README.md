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
| [azurerm_management_group_policy_remediation.policy_remediation_management_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_remediation) | resource |
| [azurerm_resource_group_policy_remediation.policy_remediation_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_policy_remediation) | resource |
| [azurerm_subscription_policy_remediation.policy_remediation_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_remediation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_policy_assignment_id"></a> [policy\_assignment\_id](#input\_policy\_assignment\_id) | value to set the policy assignment id | `string` | n/a | yes |
| <a name="input_policy_definition_reference_id"></a> [policy\_definition\_reference\_id](#input\_policy\_definition\_reference\_id) | value to set the policy definition reference id | `string` | `null` | no |
| <a name="input_remediation_name"></a> [remediation\_name](#input\_remediation\_name) | value to set the remediation name | `string` | n/a | yes |
| <a name="input_scope_id"></a> [scope\_id](#input\_scope\_id) | value to set the scope id | `string` | n/a | yes |
| <a name="input_scope_type"></a> [scope\_type](#input\_scope\_type) | value to set the scope type | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT POLICY REMEDIATION ############################################################################ |
<!-- END_TF_DOCS -->