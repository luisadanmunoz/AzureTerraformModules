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
| <a name="module_block_legacy"></a> [block\_legacy](#module\_block\_legacy) | ../../ | n/a |
| <a name="module_require_mfa"></a> [require\_mfa](#module\_require\_mfa) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azuread_group.break_glass](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_legacy_block_policy_id"></a> [legacy\_block\_policy\_id](#output\_legacy\_block\_policy\_id) | n/a |
| <a name="output_mfa_policy_id"></a> [mfa\_policy\_id](#output\_mfa\_policy\_id) | n/a |
<!-- END_TF_DOCS -->