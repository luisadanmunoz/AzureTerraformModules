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
| [azurerm_iothub_dps_shared_access_policy.iothub_dps_shared_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_dps_shared_access_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_enrollment_read"></a> [enrollment\_read](#input\_enrollment\_read) | value to set the enrollment read permission | `bool` | `null` | no |
| <a name="input_enrollment_write"></a> [enrollment\_write](#input\_enrollment\_write) | value to set the enrollment write permission | `bool` | `null` | no |
| <a name="input_iothub_dps_name"></a> [iothub\_dps\_name](#input\_iothub\_dps\_name) | value to set the iot hub dps name | `string` | n/a | yes |
| <a name="input_iothub_dps_shared_access_policy_name"></a> [iothub\_dps\_shared\_access\_policy\_name](#input\_iothub\_dps\_shared\_access\_policy\_name) | value to set the iot hub dps shared access policy name | `string` | n/a | yes |
| <a name="input_registration_read"></a> [registration\_read](#input\_registration\_read) | value to set the registration read permission | `bool` | `null` | no |
| <a name="input_registration_write"></a> [registration\_write](#input\_registration\_write) | value to set the registration write permission | `bool` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_service_config"></a> [service\_config](#input\_service\_config) | value to set the service config permission | `bool` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | value of the iot hub dps shared access policy id |
| <a name="output_name"></a> [name](#output\_name) | value of the iot hub dps shared access policy name |
<!-- END_TF_DOCS -->