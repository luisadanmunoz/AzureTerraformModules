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
| [azurerm_management_lock.resource_lock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_lock_level"></a> [lock\_level](#input\_lock\_level) | value to set the lock level | `string` | n/a | yes |
| <a name="input_lock_name"></a> [lock\_name](#input\_lock\_name) | value to set the lock name | `string` | n/a | yes |
| <a name="input_notes"></a> [notes](#input\_notes) | value to set the notes | `string` | `null` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | value to set the scope | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT RESOURCE LOCK ############################################################################ |
<!-- END_TF_DOCS -->