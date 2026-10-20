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
| [azurerm_machine_learning_workspace.machine_learning_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_application_insights_id"></a> [application\_insights\_id](#input\_application\_insights\_id) | value to set the application insights id | `string` | n/a | yes |
| <a name="input_container_registry_id"></a> [container\_registry\_id](#input\_container\_registry\_id) | value to set the container registry id | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | value to set the encryption | <pre>object({<br/>    key_id                    = string<br/>    key_vault_id              = string<br/>    user_assigned_identity_id = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_feature_store"></a> [feature\_store](#input\_feature\_store) | value to set the feature store | <pre>object({<br/>    computer_spark_runtime_version = optional(string)<br/>    offline_connection_name        = optional(string)<br/>    online_connection_name         = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_friendly_name"></a> [friendly\_name](#input\_friendly\_name) | value to set the friendly name | `string` | `null` | no |
| <a name="input_high_business_impact"></a> [high\_business\_impact](#input\_high\_business\_impact) | value to set the high business impact flag | `bool` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | value to set the identity | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | n/a | yes |
| <a name="input_image_build_compute_name"></a> [image\_build\_compute\_name](#input\_image\_build\_compute\_name) | value to set the image build compute name | `string` | `null` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | value to set the key vault id | `string` | n/a | yes |
| <a name="input_kind"></a> [kind](#input\_kind) | value to set the kind | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_machine_learning_workspace_name"></a> [machine\_learning\_workspace\_name](#input\_machine\_learning\_workspace\_name) | value to set the machine learning workspace name | `string` | n/a | yes |
| <a name="input_managed_network"></a> [managed\_network](#input\_managed\_network) | value to set the managed network | <pre>object({<br/>    isolation_mode                = optional(string)<br/>    provision_on_creation_enabled = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_primary_user_assigned_identity"></a> [primary\_user\_assigned\_identity](#input\_primary\_user\_assigned\_identity) | value to set the primary user assigned identity | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | value to set the public network access enabled flag | `bool` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_serverless_compute"></a> [serverless\_compute](#input\_serverless\_compute) | value to set the serverless compute | <pre>object({<br/>    public_ip_enabled = optional(bool)<br/>    subnet_id         = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_service_side_encryption_enabled"></a> [service\_side\_encryption\_enabled](#input\_service\_side\_encryption\_enabled) | value to set the service side encryption enabled flag | `bool` | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | value to set the sku name | `string` | `null` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | value to set the storage account id | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_v1_legacy_mode_enabled"></a> [v1\_legacy\_mode\_enabled](#input\_v1\_legacy\_mode\_enabled) | value to set the v1 legacy mode enabled flag | `bool` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT MACHINE LEARNING WORKSPACE ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | n/a |
<!-- END_TF_DOCS -->