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
| [azurerm_container_app_environment.container_app_environment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_container_app_environment_name"></a> [container\_app\_environment\_name](#input\_container\_app\_environment\_name) | value to set the container app environment name | `string` | n/a | yes |
| <a name="input_dapr_application_insights_connection_string"></a> [dapr\_application\_insights\_connection\_string](#input\_dapr\_application\_insights\_connection\_string) | value to set the dapr application insights connection string | `string` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | value to set the identity | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_infrastructure_resource_group_name"></a> [infrastructure\_resource\_group\_name](#input\_infrastructure\_resource\_group\_name) | value to set the infrastructure resource group name | `string` | `null` | no |
| <a name="input_infrastructure_subnet_id"></a> [infrastructure\_subnet\_id](#input\_infrastructure\_subnet\_id) | value to set the infrastructure subnet id | `string` | `null` | no |
| <a name="input_internal_load_balancer_enabled"></a> [internal\_load\_balancer\_enabled](#input\_internal\_load\_balancer\_enabled) | value to set the internal load balancer enabled flag | `bool` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | value to set the log analytics workspace id | `string` | `null` | no |
| <a name="input_logs_destination"></a> [logs\_destination](#input\_logs\_destination) | value to set the logs destination | `string` | `null` | no |
| <a name="input_mutual_tls_enabled"></a> [mutual\_tls\_enabled](#input\_mutual\_tls\_enabled) | value to set the mutual tls enabled flag | `bool` | `null` | no |
| <a name="input_public_network_access"></a> [public\_network\_access](#input\_public\_network\_access) | value to set the public network access | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_workload_profile"></a> [workload\_profile](#input\_workload\_profile) | value to set the workload profile | <pre>list(object({<br/>    name                  = string<br/>    workload_profile_type = string<br/>    maximum_count         = optional(number)<br/>    minimum_count         = optional(number)<br/>  }))</pre> | `null` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled) | value to set the zone redundancy enabled flag | `bool` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_custom_domain_verification_id"></a> [custom\_domain\_verification\_id](#output\_custom\_domain\_verification\_id) | n/a |
| <a name="output_default_domain"></a> [default\_domain](#output\_default\_domain) | n/a |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT CONTAINER APP ENVIRONMENT ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_static_ip_address"></a> [static\_ip\_address](#output\_static\_ip\_address) | n/a |
<!-- END_TF_DOCS -->