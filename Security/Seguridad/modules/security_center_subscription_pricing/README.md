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
| [azurerm_security_center_subscription_pricing.security_center_subscription_pricing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_extensions"></a> [extensions](#input\_extensions) | value to set the extensions | <pre>list(object({<br/>    name                            = string<br/>    additional_extension_properties = optional(map(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_resource_type"></a> [resource\_type](#input\_resource\_type) | value to set the resource type | `string` | `null` | no |
| <a name="input_subplan"></a> [subplan](#input\_subplan) | value to set the subplan | `string` | `null` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | value to set the tier | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | value to set the timeouts | <pre>object({<br/>    create = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT SECURITY CENTER SUBSCRIPTION PRICING ############################################################################ |
| <a name="output_resource_type"></a> [resource\_type](#output\_resource\_type) | n/a |
<!-- END_TF_DOCS -->