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
| [azurerm_machine_learning_datastore_datalake_gen2.machine_learning_datastore_datalake_gen2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_datastore_datalake_gen2) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_authority_url"></a> [authority\_url](#input\_authority\_url) | value to set the authority url | `string` | `null` | no |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | value to set the client id | `string` | `null` | no |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | value to set the client secret | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | value to set the description | `string` | `null` | no |
| <a name="input_machine_learning_datastore_datalake_gen2_name"></a> [machine\_learning\_datastore\_datalake\_gen2\_name](#input\_machine\_learning\_datastore\_datalake\_gen2\_name) | value to set the machine learning datastore datalake gen2 name | `string` | n/a | yes |
| <a name="input_service_data_identity"></a> [service\_data\_identity](#input\_service\_data\_identity) | value to set the service data identity | `string` | `null` | no |
| <a name="input_storage_container_id"></a> [storage\_container\_id](#input\_storage\_container\_id) | value to set the storage container id | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | value to set the tenant id | `string` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | value to set the machine learning workspace id | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT MACHINE LEARNING DATASTORE DATALAKE GEN2 ############################################################################ |
| <a name="output_is_default"></a> [is\_default](#output\_is\_default) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->