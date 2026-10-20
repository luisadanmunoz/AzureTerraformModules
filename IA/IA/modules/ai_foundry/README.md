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
| [azurerm_ai_foundry.ai_foundry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ai_foundry) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_ai_foundry_name"></a> [ai\_foundry\_name](#input\_ai\_foundry\_name) | value to set the ai foundry name | `string` | n/a | yes |
| <a name="input_application_insights_id"></a> [application\_insights\_id](#input\_application\_insights\_id) | value to set the application insights id | `string` | `null` | no |
| <a name="input_container_registry_id"></a> [container\_registry\_id](#input\_container\_registry\_id) | value to set the container registry id | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | value to set the encryption | <pre>object({<br/>    key_id                    = string<br/>    key_vault_id              = string<br/>    user_assigned_identity_id = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_friendly_name"></a> [friendly\_name](#input\_friendly\_name) | value to set the friendly name | `string` | `null` | no |
| <a name="input_high_business_impact_enabled"></a> [high\_business\_impact\_enabled](#input\_high\_business\_impact\_enabled) | value to set the high business impact enabled flag | `bool` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | value to set the identity | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | n/a | yes |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | value to set the key vault id | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_managed_network"></a> [managed\_network](#input\_managed\_network) | value to set the managed network | <pre>object({<br/>    isolation_mode = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_primary_user_assigned_identity"></a> [primary\_user\_assigned\_identity](#input\_primary\_user\_assigned\_identity) | value to set the primary user assigned identity | `string` | `null` | no |
| <a name="input_public_network_access"></a> [public\_network\_access](#input\_public\_network\_access) | value to set the public network access | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | value to set the storage account id | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT AI FOUNDRY ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | n/a |
<!-- END_TF_DOCS -->