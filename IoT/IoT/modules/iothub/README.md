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
| [azurerm_iothub.iothub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cloud_to_device"></a> [cloud\_to\_device](#input\_cloud\_to\_device) | value to set the cloud to device configuration | <pre>object({<br/>    default_ttl        = optional(string)<br/>    max_delivery_count = optional(number)<br/>    feedback = optional(object({<br/>      lock_duration      = optional(string)<br/>      max_delivery_count = optional(number)<br/>      time_to_live       = optional(string)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_event_hub_partition_count"></a> [event\_hub\_partition\_count](#input\_event\_hub\_partition\_count) | value to set the event hub partition count | `number` | `null` | no |
| <a name="input_event_hub_retention_in_days"></a> [event\_hub\_retention\_in\_days](#input\_event\_hub\_retention\_in\_days) | value to set the event hub retention in days | `number` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | value to set the identity | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_iothub_name"></a> [iothub\_name](#input\_iothub\_name) | value to set the iot hub name | `string` | n/a | yes |
| <a name="input_local_authentication_enabled"></a> [local\_authentication\_enabled](#input\_local\_authentication\_enabled) | value to set the local authentication enabled flag | `bool` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | value to set the minimum tls version | `string` | `null` | no |
| <a name="input_network_rule_set"></a> [network\_rule\_set](#input\_network\_rule\_set) | value to set the network rule set | <pre>object({<br/>    apply_to_builtin_eventhub_endpoint = optional(bool)<br/>    default_action                     = optional(string)<br/>    ip_rule = optional(list(object({<br/>      name    = string<br/>      ip_mask = string<br/>      action  = optional(string)<br/>    })))<br/>  })</pre> | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | value to set the public network access enabled flag | `bool` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | value to set the sku | <pre>object({<br/>    name     = string<br/>    capacity = number<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_event_hub_events_endpoint"></a> [event\_hub\_events\_endpoint](#output\_event\_hub\_events\_endpoint) | value of the iot hub event hub events endpoint |
| <a name="output_hostname"></a> [hostname](#output\_hostname) | value of the iot hub hostname |
| <a name="output_id"></a> [id](#output\_id) | value of the iot hub id |
| <a name="output_name"></a> [name](#output\_name) | value of the iot hub name |
| <a name="output_type"></a> [type](#output\_type) | value of the iot hub type |
<!-- END_TF_DOCS -->