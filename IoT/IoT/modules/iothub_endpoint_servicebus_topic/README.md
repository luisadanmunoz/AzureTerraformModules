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
| [azurerm_iothub_endpoint_servicebus_topic.iothub_endpoint_servicebus_topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_endpoint_servicebus_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_authentication_type"></a> [authentication\_type](#input\_authentication\_type) | value to set the authentication type | `string` | `null` | no |
| <a name="input_connection_string"></a> [connection\_string](#input\_connection\_string) | value to set the connection string | `string` | `null` | no |
| <a name="input_endpoint_uri"></a> [endpoint\_uri](#input\_endpoint\_uri) | value to set the endpoint uri | `string` | `null` | no |
| <a name="input_entity_path"></a> [entity\_path](#input\_entity\_path) | value to set the entity path | `string` | `null` | no |
| <a name="input_identity_id"></a> [identity\_id](#input\_identity\_id) | value to set the identity id | `string` | `null` | no |
| <a name="input_iothub_endpoint_servicebus_topic_name"></a> [iothub\_endpoint\_servicebus\_topic\_name](#input\_iothub\_endpoint\_servicebus\_topic\_name) | value to set the iot hub endpoint servicebus topic name | `string` | n/a | yes |
| <a name="input_iothub_id"></a> [iothub\_id](#input\_iothub\_id) | value to set the iot hub id | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | value to set the subscription id | `string` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the iot hub endpoint servicebus topic id |
| <a name="output_name"></a> [name](#output\_name) | value of the iot hub endpoint servicebus topic name |
<!-- END_TF_DOCS -->