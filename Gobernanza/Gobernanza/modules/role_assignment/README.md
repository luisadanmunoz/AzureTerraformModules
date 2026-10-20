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
| [azurerm_role_assignment.role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_condition"></a> [condition](#input\_condition) | value to set the condition | `string` | `null` | no |
| <a name="input_condition_version"></a> [condition\_version](#input\_condition\_version) | value to set the condition version | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_principal_id"></a> [principal\_id](#input\_principal\_id) | value to set the principal id | `string` | n/a | yes |
| <a name="input_principal_type"></a> [principal\_type](#input\_principal\_type) | value to set the principal type | `string` | `null` | no |
| <a name="input_role_definition_id"></a> [role\_definition\_id](#input\_role\_definition\_id) | value to set the role definition id | `string` | `null` | no |
| <a name="input_role_definition_name"></a> [role\_definition\_name](#input\_role\_definition\_name) | value to set the role definition name | `string` | `null` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | value to set the scope | `string` | n/a | yes |
| <a name="input_skip_service_principal_aad_check"></a> [skip\_service\_principal\_aad\_check](#input\_skip\_service\_principal\_aad\_check) | value to skip service principal aad check | `bool` | `false` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT ROLE ASSIGNMENT ############################################################################ |
<!-- END_TF_DOCS -->