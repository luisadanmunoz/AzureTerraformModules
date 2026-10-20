<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.45.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.45.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_dynamic_group"></a> [dynamic\_group](#module\_dynamic\_group) | ../../ | n/a |
| <a name="module_role_assignable_group"></a> [role\_assignable\_group](#module\_role\_assignable\_group) | ../../ | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_dynamic_group_id"></a> [dynamic\_group\_id](#output\_dynamic\_group\_id) | n/a |
| <a name="output_role_assignable_group_id"></a> [role\_assignable\_group\_id](#output\_role\_assignable\_group\_id) | n/a |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
<!-- END_TF_DOCS -->