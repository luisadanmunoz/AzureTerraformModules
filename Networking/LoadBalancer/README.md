# Azure Load Balancer Terraform Module

This module creates an Azure Load Balancer (Standard or Basic) with support for public and internal configurations, backend pools, health probes, and load balancing rules.

## Features

- Public and Internal Load Balancer support
- Standard and Basic SKU
- Zone redundancy (Standard SKU)
- Backend address pools
- Health probes (TCP, HTTP, HTTPS)
- Load balancing rules
- Inbound NAT rules
- Outbound rules (Standard SKU)
- Diagnostic settings

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| Public IP | No | For public LB (can be provided or created externally) |
| Subnet | No | For internal LB |
| Virtual Network | No | For IP-based backend pools |

## Usage

### Public Load Balancer

```hcl
module "lb_public" {
  source = "../../Networking/LoadBalancer"

  resource_group_name = "rg-lb-prod-001"
  location            = "westeurope"
  name                = "lb-web-prod-001"
  type                = "public"

  frontend_ip_configurations = {
    "frontend-public" = {
      public_ip_address_id = azurerm_public_ip.lb.id
      zones                = ["1", "2", "3"]
    }
  }

  backend_address_pools = {
    "pool-web" = {}
  }

  probes = {
    "probe-http" = {
      protocol     = "Http"
      port         = 80
      request_path = "/health"
    }
  }

  lb_rules = {
    "rule-http" = {
      frontend_ip_configuration_name = "frontend-public"
      backend_address_pool_names     = ["pool-web"]
      probe_name                     = "probe-http"
      protocol                       = "Tcp"
      frontend_port                  = 80
      backend_port                   = 80
    }
  }
}
```

### Internal Load Balancer

```hcl
module "lb_internal" {
  source = "../../Networking/LoadBalancer"

  resource_group_name = "rg-lb-prod-001"
  location            = "westeurope"
  name                = "lb-app-prod-001"
  type                = "internal"

  frontend_ip_configurations = {
    "frontend-internal" = {
      subnet_id          = module.subnet.id
      private_ip_address = "10.0.1.100"
      private_ip_address_allocation = "Static"
    }
  }

  backend_address_pools = {
    "pool-app" = {}
  }

  probes = {
    "probe-tcp" = {
      protocol = "Tcp"
      port     = 8080
    }
  }

  lb_rules = {
    "rule-app" = {
      frontend_ip_configuration_name = "frontend-internal"
      backend_address_pool_names     = ["pool-app"]
      probe_name                     = "probe-tcp"
      protocol                       = "Tcp"
      frontend_port                  = 8080
      backend_port                   = 8080
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | LB name | `string` | auto | no |
| sku | Basic, Standard, Gateway | `string` | `"Standard"` | no |
| type | public or internal | `string` | `"public"` | no |
| frontend_ip_configurations | Frontend configs | `map(object({...}))` | n/a | **yes** |
| backend_address_pools | Backend pools | `map(object({...}))` | `{}` | no |
| probes | Health probes | `map(object({...}))` | `{}` | no |
| lb_rules | LB rules | `map(object({...}))` | `{}` | no |
| nat_rules | NAT rules | `map(object({...}))` | `{}` | no |
| outbound_rules | Outbound rules | `map(object({...}))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Load Balancer ID |
| name | Load Balancer name |
| frontend_ip_configuration | Frontend configs |
| private_ip_address | Private IP (internal) |
| backend_address_pool_ids | Backend pool IDs |
| probe_ids | Probe IDs |
| lb_rule_ids | Rule IDs |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_lb.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_nat_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_nat_rule) | resource |
| [azurerm_lb_outbound_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_outbound_rule) | resource |
| [azurerm_lb_probe.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_backend_address_pools"></a> [backend\_address\_pools](#input\_backend\_address\_pools) | (Optional) Map of backend address pools.<br/><br/>Attributes:<br/>  - virtual\_network\_id: VNet ID for IP-based backends. | <pre>map(object({<br/>    virtual_network_id = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Load Balancer. | `bool` | `true` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | (Optional) Diagnostic settings configuration. | <pre>object({<br/>    name                       = optional(string, "diag-lb")<br/>    log_analytics_workspace_id = optional(string, null)<br/>    storage_account_id         = optional(string, null)<br/>    metric_categories          = optional(list(string), ["AllMetrics"])<br/>  })</pre> | `null` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | (Optional) Edge Zone for the Load Balancer. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"prod"` | no |
| <a name="input_frontend_ip_configurations"></a> [frontend\_ip\_configurations](#input\_frontend\_ip\_configurations) | (Required) Map of frontend IP configurations.<br/><br/>For public LB:<br/>  - public\_ip\_address\_id: Existing Public IP ID.<br/>  - public\_ip\_prefix\_id: Public IP Prefix ID.<br/>  - zones: Availability zones.<br/><br/>For internal LB:<br/>  - subnet\_id: Subnet ID. DEPENDENCY: Must exist.<br/>  - private\_ip\_address: Static IP from subnet.<br/>  - private\_ip\_address\_allocation: Static or Dynamic.<br/>  - private\_ip\_address\_version: IPv4 or IPv6. | <pre>map(object({<br/>    public_ip_address_id          = optional(string, null)<br/>    public_ip_prefix_id           = optional(string, null)<br/>    subnet_id                     = optional(string, null)<br/>    private_ip_address            = optional(string, null)<br/>    private_ip_address_allocation = optional(string, "Dynamic")<br/>    private_ip_address_version    = optional(string, "IPv4")<br/>    zones                         = optional(list(string), null)<br/>  }))</pre> | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_lb_rules"></a> [lb\_rules](#input\_lb\_rules) | (Optional) Map of load balancing rules.<br/><br/>Attributes:<br/>  - frontend\_ip\_configuration\_name: Frontend config name.<br/>  - backend\_address\_pool\_ids: Backend pool IDs (use names, resolved in module).<br/>  - probe\_name: Health probe name.<br/>  - protocol: Tcp, Udp, or All.<br/>  - frontend\_port: Frontend port.<br/>  - backend\_port: Backend port.<br/>  - enable\_floating\_ip: Enable direct server return.<br/>  - idle\_timeout\_in\_minutes: TCP idle timeout.<br/>  - load\_distribution: Default, SourceIP, SourceIPProtocol.<br/>  - disable\_outbound\_snat: Disable outbound SNAT.<br/>  - enable\_tcp\_reset: Enable TCP reset on idle. | <pre>map(object({<br/>    frontend_ip_configuration_name = string<br/>    backend_address_pool_names     = list(string)<br/>    probe_name                     = optional(string, null)<br/>    protocol                       = string<br/>    frontend_port                  = number<br/>    backend_port                   = number<br/>    enable_floating_ip             = optional(bool, false)<br/>    idle_timeout_in_minutes        = optional(number, 4)<br/>    load_distribution              = optional(string, "Default")<br/>    disable_outbound_snat          = optional(bool, false)<br/>    enable_tcp_reset               = optional(bool, true)<br/>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Explicit name for the Load Balancer. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"lb"` | no |
| <a name="input_nat_rules"></a> [nat\_rules](#input\_nat\_rules) | (Optional) Map of inbound NAT rules.<br/><br/>Attributes:<br/>  - frontend\_ip\_configuration\_name: Frontend config name.<br/>  - protocol: Tcp or Udp.<br/>  - frontend\_port: Frontend port (null for port range).<br/>  - backend\_port: Backend port.<br/>  - frontend\_port\_start: Start of port range.<br/>  - frontend\_port\_end: End of port range.<br/>  - backend\_address\_pool\_id: For NAT pool rules.<br/>  - idle\_timeout\_in\_minutes: TCP idle timeout.<br/>  - enable\_floating\_ip: Enable direct server return.<br/>  - enable\_tcp\_reset: Enable TCP reset on idle. | <pre>map(object({<br/>    frontend_ip_configuration_name = string<br/>    protocol                       = string<br/>    frontend_port                  = optional(number, null)<br/>    backend_port                   = number<br/>    frontend_port_start            = optional(number, null)<br/>    frontend_port_end              = optional(number, null)<br/>    backend_address_pool_id        = optional(string, null)<br/>    idle_timeout_in_minutes        = optional(number, 4)<br/>    enable_floating_ip             = optional(bool, false)<br/>    enable_tcp_reset               = optional(bool, true)<br/>  }))</pre> | `{}` | no |
| <a name="input_outbound_rules"></a> [outbound\_rules](#input\_outbound\_rules) | (Optional) Map of outbound rules (Standard SKU only).<br/><br/>Attributes:<br/>  - frontend\_ip\_configuration\_names: Frontend config names.<br/>  - backend\_address\_pool\_id: Backend pool name (resolved in module).<br/>  - protocol: Tcp, Udp, or All.<br/>  - allocated\_outbound\_ports: Ports per instance.<br/>  - idle\_timeout\_in\_minutes: TCP idle timeout.<br/>  - enable\_tcp\_reset: Enable TCP reset on idle. | <pre>map(object({<br/>    frontend_ip_configuration_names = list(string)<br/>    backend_address_pool_name       = string<br/>    protocol                        = string<br/>    allocated_outbound_ports        = optional(number, 1024)<br/>    idle_timeout_in_minutes         = optional(number, 4)<br/>    enable_tcp_reset                = optional(bool, true)<br/>  }))</pre> | `{}` | no |
| <a name="input_probes"></a> [probes](#input\_probes) | (Optional) Map of health probes.<br/><br/>Attributes:<br/>  - protocol: Tcp, Http, or Https.<br/>  - port: Port to probe.<br/>  - request\_path: HTTP path (for Http/Https).<br/>  - interval\_in\_seconds: Probe interval.<br/>  - number\_of\_probes: Failures before unhealthy.<br/>  - probe\_threshold: Successes before healthy. | <pre>map(object({<br/>    protocol            = string<br/>    port                = number<br/>    request_path        = optional(string, null)<br/>    interval_in_seconds = optional(number, 5)<br/>    number_of_probes    = optional(number, 2)<br/>    probe_threshold     = optional(number, 1)<br/>  }))</pre> | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource Group name. DEPENDENCY: Must exist. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) SKU: Basic, Standard, or Gateway. | `string` | `"Standard"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | (Optional) SKU tier: Regional or Global. | `string` | `"Regional"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | (Optional) Load Balancer type: public or internal. | `string` | `"public"` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name. | `string` | `"app"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_backend_address_pool_ids"></a> [backend\_address\_pool\_ids](#output\_backend\_address\_pool\_ids) | Map of backend pool names to IDs. |
| <a name="output_frontend_ip_configuration"></a> [frontend\_ip\_configuration](#output\_frontend\_ip\_configuration) | Frontend IP configurations. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Load Balancer. |
| <a name="output_lb_rule_ids"></a> [lb\_rule\_ids](#output\_lb\_rule\_ids) | Map of rule names to IDs. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Load Balancer. |
| <a name="output_nat_rule_ids"></a> [nat\_rule\_ids](#output\_nat\_rule\_ids) | Map of NAT rule names to IDs. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | Private IP address (internal LB). |
| <a name="output_probe_ids"></a> [probe\_ids](#output\_probe\_ids) | Map of probe names to IDs. |
<!-- END_TF_DOCS -->