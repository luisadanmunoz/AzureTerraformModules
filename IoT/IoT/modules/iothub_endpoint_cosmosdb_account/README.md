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
| [azurerm_iothub_endpoint_cosmosdb_account.iothub_endpoint_cosmosdb_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_endpoint_cosmosdb_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_authentication_type"></a> [authentication\_type](#input\_authentication\_type) | value to set the authentication type | `string` | `null` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | value to set the container name | `string` | n/a | yes |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | value to set the database name | `string` | n/a | yes |
| <a name="input_endpoint_uri"></a> [endpoint\_uri](#input\_endpoint\_uri) | value to set the endpoint uri | `string` | n/a | yes |
| <a name="input_identity_id"></a> [identity\_id](#input\_identity\_id) | value to set the identity id | `string` | `null` | no |
| <a name="input_iothub_endpoint_cosmosdb_account_name"></a> [iothub\_endpoint\_cosmosdb\_account\_name](#input\_iothub\_endpoint\_cosmosdb\_account\_name) | value to set the iot hub endpoint cosmosdb account name | `string` | n/a | yes |
| <a name="input_iothub_id"></a> [iothub\_id](#input\_iothub\_id) | value to set the iot hub id | `string` | n/a | yes |
| <a name="input_partition_key_name"></a> [partition\_key\_name](#input\_partition\_key\_name) | value to set the partition key name | `string` | `null` | no |
| <a name="input_partition_key_template"></a> [partition\_key\_template](#input\_partition\_key\_template) | value to set the partition key template | `string` | `null` | no |
| <a name="input_primary_key"></a> [primary\_key](#input\_primary\_key) | value to set the primary key | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_secondary_key"></a> [secondary\_key](#input\_secondary\_key) | value to set the secondary key | `string` | `null` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | value to set the subscription id | `string` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the iot hub endpoint cosmosdb account id |
| <a name="output_name"></a> [name](#output\_name) | value of the iot hub endpoint cosmosdb account name |
<!-- END_TF_DOCS -->