# Azure Application Gateway Terraform Module

This module creates an Azure Application Gateway with support for WAF, SSL termination, path-based routing, and multi-site hosting.

## Features

- Standard_v2 and WAF_v2 SKU support
- Autoscaling configuration
- Zone redundancy
- WAF with OWASP rule sets
- SSL/TLS termination with Key Vault integration
- Health probes
- Path-based and multi-site routing
- Private frontend IP support
- Diagnostic settings

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| Subnet | **Yes** | Dedicated subnet (minimum /26) |
| Public IP | No | Created automatically if not provided |
| Key Vault | No | For SSL certificates |
| WAF Policy | No | Alternative to inline waf_configuration |

## Usage

### Basic HTTP Application Gateway

```hcl
module "appgw" {
  source = "../../Networking/ApplicationGateway"

  resource_group_name = "rg-appgw-prod-001"
  location            = "westeurope"
  subnet_id           = module.subnet_appgw.id

  name = "agw-web-prod-001"

  sku = {
    name = "Standard_v2"
    tier = "Standard_v2"
  }

  autoscale_configuration = {
    min_capacity = 1
    max_capacity = 10
  }

  backend_address_pools = {
    "pool-web" = {
      ip_addresses = ["10.0.1.10", "10.0.1.11"]
    }
  }

  backend_http_settings = {
    "http-settings-web" = {
      port     = 80
      protocol = "Http"
    }
  }

  http_listeners = {
    "listener-http" = {
      frontend_port_name = "http"
      protocol           = "Http"
    }
  }

  request_routing_rules = {
    "rule-basic" = {
      rule_type                  = "Basic"
      priority                   = 100
      http_listener_name         = "listener-http"
      backend_address_pool_name  = "pool-web"
      backend_http_settings_name = "http-settings-web"
    }
  }
}
```

### WAF with HTTPS

```hcl
module "appgw_waf" {
  source = "../../Networking/ApplicationGateway"

  resource_group_name = "rg-appgw-prod-001"
  location            = "westeurope"
  subnet_id           = module.subnet_appgw.id
  name                = "agw-web-prod-001"

  sku = {
    name = "WAF_v2"
    tier = "WAF_v2"
  }

  waf_configuration = {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.2"
  }

  ssl_certificates = {
    "cert-web" = {
      key_vault_secret_id = "https://kv-xxx.vault.azure.net/secrets/cert-web"
    }
  }

  identity = {
    identity_ids = [azurerm_user_assigned_identity.agw.id]
  }

  # ... listeners, backends, rules
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| subnet_id | Subnet ID | `string` | n/a | **yes** |
| name | Gateway name | `string` | auto | no |
| sku | SKU configuration | `object({...})` | Standard_v2 | no |
| autoscale_configuration | Autoscale config | `object({...})` | `null` | no |
| backend_address_pools | Backend pools | `map(object({...}))` | n/a | **yes** |
| backend_http_settings | HTTP settings | `map(object({...}))` | n/a | **yes** |
| http_listeners | Listeners | `map(object({...}))` | n/a | **yes** |
| request_routing_rules | Routing rules | `map(object({...}))` | n/a | **yes** |
| waf_configuration | WAF config | `object({...})` | `null` | no |
| ssl_certificates | SSL certs | `map(object({...}))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Gateway ID |
| name | Gateway name |
| public_ip_address | Public IP |
| backend_address_pools | Backend pool IDs |

## Security Recommendations

1. **Use WAF_v2** with Prevention mode for production
2. **Enable HTTPS** with TLS 1.2+ only
3. **Use Key Vault** for SSL certificate management
4. **Enable diagnostics** for monitoring and auditing

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
| [azurerm_application_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_autoscale_configuration"></a> [autoscale\_configuration](#input\_autoscale\_configuration) | (Optional) Autoscale configuration (v2 SKU only).<br/><br/>Attributes:<br/>  - min\_capacity: Minimum instances (0-100).<br/>  - max\_capacity: Maximum instances (2-125). | <pre>object({<br/>    min_capacity = number<br/>    max_capacity = optional(number, 10)<br/>  })</pre> | `null` | no |
| <a name="input_backend_address_pools"></a> [backend\_address\_pools](#input\_backend\_address\_pools) | (Required) Map of backend address pools.<br/><br/>Attributes:<br/>  - fqdns: List of FQDNs.<br/>  - ip\_addresses: List of IP addresses. | <pre>map(object({<br/>    fqdns        = optional(list(string), [])<br/>    ip_addresses = optional(list(string), [])<br/>  }))</pre> | n/a | yes |
| <a name="input_backend_http_settings"></a> [backend\_http\_settings](#input\_backend\_http\_settings) | (Required) Map of backend HTTP settings.<br/><br/>Attributes:<br/>  - port: Backend port.<br/>  - protocol: Http or Https.<br/>  - cookie\_based\_affinity: Enabled or Disabled.<br/>  - request\_timeout: Timeout in seconds.<br/>  - pick\_host\_name\_from\_backend\_address: Use backend FQDN as host header.<br/>  - host\_name: Custom host header.<br/>  - path: Path prefix.<br/>  - probe\_name: Associated probe name.<br/>  - trusted\_root\_certificate\_names: For HTTPS backends. | <pre>map(object({<br/>    port                                = number<br/>    protocol                            = string<br/>    cookie_based_affinity               = optional(string, "Disabled")<br/>    request_timeout                     = optional(number, 30)<br/>    pick_host_name_from_backend_address = optional(bool, false)<br/>    host_name                           = optional(string, null)<br/>    path                                = optional(string, null)<br/>    probe_name                          = optional(string, null)<br/>    trusted_root_certificate_names      = optional(list(string), [])<br/>  }))</pre> | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Application Gateway. | `bool` | `true` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | (Optional) Diagnostic settings configuration. | <pre>object({<br/>    name                           = optional(string, "diag-agw")<br/>    log_analytics_workspace_id     = optional(string, null)<br/>    storage_account_id             = optional(string, null)<br/>    eventhub_authorization_rule_id = optional(string, null)<br/>    log_categories = optional(list(string), [<br/>      "ApplicationGatewayAccessLog",<br/>      "ApplicationGatewayPerformanceLog",<br/>      "ApplicationGatewayFirewallLog"<br/>    ])<br/>    metric_categories = optional(list(string), ["AllMetrics"])<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"prod"` | no |
| <a name="input_firewall_policy_id"></a> [firewall\_policy\_id](#input\_firewall\_policy\_id) | (Optional) WAF Policy ID (alternative to waf\_configuration).<br/>DEPENDENCY: WAF Policy must exist. | `string` | `null` | no |
| <a name="input_frontend_ports"></a> [frontend\_ports](#input\_frontend\_ports) | (Required) Map of frontend ports.<br/>Example: { "http" = 80, "https" = 443 } | `map(number)` | <pre>{<br/>  "http": 80,<br/>  "https": 443<br/>}</pre> | no |
| <a name="input_gateway_ip_configuration_name"></a> [gateway\_ip\_configuration\_name](#input\_gateway\_ip\_configuration\_name) | (Optional) Name of the gateway IP configuration. | `string` | `"gateway-ip-config"` | no |
| <a name="input_http_listeners"></a> [http\_listeners](#input\_http\_listeners) | (Required) Map of HTTP listeners.<br/><br/>Attributes:<br/>  - frontend\_ip\_configuration\_name: public or private.<br/>  - frontend\_port\_name: Port name from frontend\_ports.<br/>  - protocol: Http or Https.<br/>  - ssl\_certificate\_name: Certificate name (for HTTPS).<br/>  - host\_name: Host header for multi-site.<br/>  - host\_names: Multiple host headers.<br/>  - require\_sni: Require SNI (HTTPS only). | <pre>map(object({<br/>    frontend_ip_configuration_name = optional(string, "public")<br/>    frontend_port_name             = string<br/>    protocol                       = string<br/>    ssl_certificate_name           = optional(string, null)<br/>    host_name                      = optional(string, null)<br/>    host_names                     = optional(list(string), null)<br/>    require_sni                    = optional(bool, false)<br/>  }))</pre> | n/a | yes |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Managed identity for Key Vault access.<br/>DEPENDENCY: User-assigned identity must exist. | <pre>object({<br/>    type         = optional(string, "UserAssigned")<br/>    identity_ids = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Azure region. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Explicit name for the Application Gateway. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"agw"` | no |
| <a name="input_private_ip_address"></a> [private\_ip\_address](#input\_private\_ip\_address) | (Optional) Private IP address for private frontend (from subnet range). | `string` | `null` | no |
| <a name="input_private_ip_address_allocation"></a> [private\_ip\_address\_allocation](#input\_private\_ip\_address\_allocation) | (Optional) Private IP allocation method: Static or Dynamic. | `string` | `"Dynamic"` | no |
| <a name="input_probes"></a> [probes](#input\_probes) | (Optional) Map of health probes.<br/><br/>Attributes:<br/>  - protocol: Http or Https.<br/>  - path: Probe path.<br/>  - host: Host header.<br/>  - interval: Probe interval in seconds.<br/>  - timeout: Timeout in seconds.<br/>  - unhealthy\_threshold: Failures before unhealthy.<br/>  - pick\_host\_name\_from\_backend\_http\_settings: Use backend host.<br/>  - minimum\_servers: Minimum healthy servers.<br/>  - match: Response match criteria. | <pre>map(object({<br/>    protocol                                  = string<br/>    path                                      = string<br/>    host                                      = optional(string, null)<br/>    interval                                  = optional(number, 30)<br/>    timeout                                   = optional(number, 30)<br/>    unhealthy_threshold                       = optional(number, 3)<br/>    pick_host_name_from_backend_http_settings = optional(bool, false)<br/>    minimum_servers                           = optional(number, 0)<br/>    match = optional(object({<br/>      body        = optional(string, null)<br/>      status_code = list(string)<br/>    }), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_public_ip_id"></a> [public\_ip\_id](#input\_public\_ip\_id) | (Optional) Existing Public IP ID. If not provided, a new one will be created.<br/>DEPENDENCY: Must be Standard SKU, Static allocation. | `string` | `null` | no |
| <a name="input_request_routing_rules"></a> [request\_routing\_rules](#input\_request\_routing\_rules) | (Required) Map of routing rules.<br/><br/>Attributes:<br/>  - rule\_type: Basic or PathBasedRouting.<br/>  - priority: Rule priority (1-20000).<br/>  - http\_listener\_name: Listener name.<br/>  - backend\_address\_pool\_name: Backend pool name (Basic rules).<br/>  - backend\_http\_settings\_name: HTTP settings name (Basic rules).<br/>  - url\_path\_map\_name: URL path map name (PathBased rules).<br/>  - redirect\_configuration\_name: Redirect config name.<br/>  - rewrite\_rule\_set\_name: Rewrite rule set name. | <pre>map(object({<br/>    rule_type                   = string<br/>    priority                    = number<br/>    http_listener_name          = string<br/>    backend_address_pool_name   = optional(string, null)<br/>    backend_http_settings_name  = optional(string, null)<br/>    url_path_map_name           = optional(string, null)<br/>    redirect_configuration_name = optional(string, null)<br/>    rewrite_rule_set_name       = optional(string, null)<br/>  }))</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource Group name. DEPENDENCY: Must exist. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | (Required) SKU configuration.<br/><br/>Attributes:<br/>  - name: Standard\_v2, WAF\_v2, Standard\_Small, Standard\_Medium, Standard\_Large, WAF\_Medium, WAF\_Large<br/>  - tier: Standard\_v2, WAF\_v2, Standard, WAF<br/>  - capacity: Instance count (1-125 for v2 without autoscale, 1-32 for v1) | <pre>object({<br/>    name     = string<br/>    tier     = string<br/>    capacity = optional(number, null)<br/>  })</pre> | <pre>{<br/>  "name": "Standard_v2",<br/>  "tier": "Standard_v2"<br/>}</pre> | no |
| <a name="input_ssl_certificates"></a> [ssl\_certificates](#input\_ssl\_certificates) | (Optional) Map of SSL certificates.<br/>DEPENDENCY: Key Vault certificate or PFX file must exist.<br/><br/>Attributes:<br/>  - data: Base64-encoded PFX certificate.<br/>  - password: PFX password.<br/>  - key\_vault\_secret\_id: Key Vault secret ID (preferred). | <pre>map(object({<br/>    data                = optional(string, null)<br/>    password            = optional(string, null)<br/>    key_vault_secret_id = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) Subnet ID for the Application Gateway.<br/>DEPENDENCY: Dedicated subnet must exist (recommended /24, minimum /26). | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_waf_configuration"></a> [waf\_configuration](#input\_waf\_configuration) | (Optional) WAF configuration (WAF/WAF\_v2 SKU only).<br/><br/>Attributes:<br/>  - enabled: Enable WAF.<br/>  - firewall\_mode: Detection or Prevention.<br/>  - rule\_set\_type: OWASP or Microsoft\_BotManagerRuleSet.<br/>  - rule\_set\_version: Rule set version (3.2, 3.1, 3.0, 2.2.9).<br/>  - file\_upload\_limit\_mb: Max upload size (1-750 MB).<br/>  - request\_body\_check: Enable body inspection.<br/>  - max\_request\_body\_size\_kb: Max body size (1-128 KB).<br/>  - disabled\_rule\_groups: Rules to disable.<br/>  - exclusions: WAF exclusions. | <pre>object({<br/>    enabled                  = optional(bool, true)<br/>    firewall_mode            = optional(string, "Prevention")<br/>    rule_set_type            = optional(string, "OWASP")<br/>    rule_set_version         = optional(string, "3.2")<br/>    file_upload_limit_mb     = optional(number, 100)<br/>    request_body_check       = optional(bool, true)<br/>    max_request_body_size_kb = optional(number, 128)<br/>    disabled_rule_groups = optional(list(object({<br/>      rule_group_name = string<br/>      rules           = optional(list(string), [])<br/>    })), [])<br/>    exclusions = optional(list(object({<br/>      match_variable          = string<br/>      selector_match_operator = optional(string, null)<br/>      selector                = optional(string, null)<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name. | `string` | `"web"` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | (Optional) Availability zones for the Application Gateway. | `list(string)` | <pre>[<br/>  "1",<br/>  "2",<br/>  "3"<br/>]</pre> | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_backend_address_pools"></a> [backend\_address\_pools](#output\_backend\_address\_pools) | Backend address pool IDs. |
| <a name="output_frontend_ip_configuration"></a> [frontend\_ip\_configuration](#output\_frontend\_ip\_configuration) | Frontend IP configuration. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Application Gateway. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Application Gateway. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The private IP address of the Application Gateway. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The public IP address of the Application Gateway. |
| <a name="output_public_ip_id"></a> [public\_ip\_id](#output\_public\_ip\_id) | The ID of the public IP (if created). |
<!-- END_TF_DOCS -->