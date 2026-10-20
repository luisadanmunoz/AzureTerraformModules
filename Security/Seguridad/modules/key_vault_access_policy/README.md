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
| [azurerm_key_vault_access_policy.key_vault_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_application_id"></a> [application\_id](#input\_application\_id) | value to set the application id | `string` | `null` | no |
| <a name="input_certificate_permissions"></a> [certificate\_permissions](#input\_certificate\_permissions) | value to set the certificate permissions | `list(string)` | `null` | no |
| <a name="input_key_permissions"></a> [key\_permissions](#input\_key\_permissions) | value to set the key permissions | `list(string)` | `null` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | value to set the key vault id | `string` | n/a | yes |
| <a name="input_object_id"></a> [object\_id](#input\_object\_id) | value to set the object id | `string` | n/a | yes |
| <a name="input_secret_permissions"></a> [secret\_permissions](#input\_secret\_permissions) | value to set the secret permissions | `list(string)` | `null` | no |
| <a name="input_storage_permissions"></a> [storage\_permissions](#input\_storage\_permissions) | value to set the storage permissions | `list(string)` | `null` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | value to set the tenant id | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT KEY VAULT ACCESS POLICY ############################################################################ |
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | n/a |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | n/a |
<!-- END_TF_DOCS -->