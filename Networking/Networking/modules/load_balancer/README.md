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
| [azurerm_lb.load_balancer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.backend_address_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_probe.probe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_backend_address_pools"></a> [backend\_address\_pools](#input\_backend\_address\_pools) | value to set the backend address pools | <pre>list(object({<br/>    name = string<br/>  }))</pre> | `[]` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | value to set the edge zone | `string` | `null` | no |
| <a name="input_frontend_ip_configurations"></a> [frontend\_ip\_configurations](#input\_frontend\_ip\_configurations) | value to set the frontend ip configurations | <pre>list(object({<br/>    name                          = string<br/>    subnet_id                     = optional(string)<br/>    private_ip_address            = optional(string)<br/>    private_ip_address_allocation = optional(string)<br/>    private_ip_address_version    = optional(string)<br/>    public_ip_address_id          = optional(string)<br/>    public_ip_prefix_id           = optional(string)<br/>    zones                         = optional(list(string))<br/>  }))</pre> | n/a | yes |
| <a name="input_load_balancer_name"></a> [load\_balancer\_name](#input\_load\_balancer\_name) | value to set the load balancer name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | value to set the location | `string` | n/a | yes |
| <a name="input_probes"></a> [probes](#input\_probes) | value to set the probes | <pre>list(object({<br/>    name                = string<br/>    protocol            = string<br/>    port                = number<br/>    request_path        = optional(string)<br/>    interval_in_seconds = optional(number)<br/>    number_of_probes    = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | value to set the resource group name | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | value to set the rules | <pre>list(object({<br/>    name                           = string<br/>    protocol                       = string<br/>    frontend_port                  = number<br/>    backend_port                   = number<br/>    frontend_ip_configuration_name = string<br/>    backend_address_pool_name      = optional(string)<br/>    probe_name                     = optional(string)<br/>    enable_floating_ip             = optional(bool)<br/>    idle_timeout_in_minutes        = optional(number)<br/>    load_distribution              = optional(string)<br/>    disable_outbound_snat          = optional(bool)<br/>    tcp_reset_enabled              = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | value to set the load balancer sku | `string` | `"Standard"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | value to set the load balancer sku tier | `string` | `"Regional"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | value to set the tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_frontend_ip_configuration_ids"></a> [frontend\_ip\_configuration\_ids](#output\_frontend\_ip\_configuration\_ids) | n/a |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################ OUTPUT LOAD BALANCER ############################################################################ |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->