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
| [azurerm_machine_learning_datastore_blobstorage.machine_learning_datastore_blobstorage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_datastore_blobstorage) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_account_key"></a> [account\_key](#input\_account\_key) | value to set the account key | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_is_default"></a> [is\_default](#input\_is\_default) | value to set the default flag | `bool` | `null` | no |
| <a name="input_machine_learning_datastore_blobstorage_name"></a> [machine\_learning\_datastore\_blobstorage\_name](#input\_machine\_learning\_datastore\_blobstorage\_name) | value to set the machine learning datastore blobstorage name | `string` | n/a | yes |
| <a name="input_service_data_auth_identity"></a> [service\_data\_auth\_identity](#input\_service\_data\_auth\_identity) | value to set the service data auth identity | `string` | `null` | no |
| <a name="input_shared_access_signature"></a> [shared\_access\_signature](#input\_shared\_access\_signature) | value to set the shared access signature | `string` | `null` | no |
| <a name="input_storage_container_id"></a> [storage\_container\_id](#input\_storage\_container\_id) | value to set the storage container id | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | value to set the machine learning workspace id | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT MACHINE LEARNING DATASTORE BLOB STORAGE ############################################################################ |
| <a name="output_is_default"></a> [is\_default](#output\_is\_default) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->