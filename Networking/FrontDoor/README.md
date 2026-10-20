# Azure Front Door (CDN Profile) Terraform Module

This module creates and manages an Azure Front Door profile using the modern CDN-based resources (`azurerm_cdn_frontdoor_*`). It supports endpoints, origin groups, origins, routes, custom domains, security policies, and diagnostic settings.

## Features

- Azure Front Door profile with Standard or Premium SKU
- Multiple endpoints with configurable enable/disable
- Origin groups with health probes and load balancing
- Origins with optional Private Link support (Premium SKU)
- Routes with optional caching configuration
- Custom domains with managed or customer-provided TLS certificates
- Security policies for WAF integration
- Diagnostic settings for monitoring
- Conditional resource creation via `create` flag
- Automatic name generation or explicit naming

## Usage

### Basic Example

```hcl
module "front_door" {
  source = "../../Networking/FrontDoor"

  resource_group_name = "rg-myapp-prod"
  workload            = "myapp"
  environment         = "prod"

  sku_name = "Standard_AzureFrontDoor"

  endpoints = [
    {
      name    = "ep-myapp"
      enabled = true
    }
  ]

  origin_groups = [
    {
      name = "og-webapp"
      health_probe = {
        interval_in_seconds = 100
        path                = "/"
        protocol            = "Https"
        request_type        = "HEAD"
      }
      load_balancing = {
        additional_latency_in_milliseconds = 50
        sample_size                        = 4
        successful_samples_required        = 3
      }
    }
  ]

  origins = [
    {
      name              = "origin-webapp"
      origin_group_name = "og-webapp"
      host_name         = "myapp.azurewebsites.net"
    }
  ]

  routes = [
    {
      name              = "route-default"
      endpoint_name     = "ep-myapp"
      origin_group_name = "og-webapp"
      origin_names      = ["origin-webapp"]
      patterns_to_match = ["/*"]
    }
  ]

  tags = {
    project = "myapp"
  }
}
```

### Premium with WAF and Custom Domain

```hcl
module "front_door_premium" {
  source = "../../Networking/FrontDoor"

  resource_group_name = "rg-myapp-prod"
  workload            = "myapp"
  environment         = "prod"

  sku_name = "Premium_AzureFrontDoor"

  endpoints = [
    { name = "ep-myapp", enabled = true }
  ]

  origin_groups = [
    {
      name = "og-webapp"
      health_probe = {
        interval_in_seconds = 60
        path                = "/health"
        protocol            = "Https"
        request_type        = "GET"
      }
    }
  ]

  origins = [
    {
      name              = "origin-webapp"
      origin_group_name = "og-webapp"
      host_name         = "myapp.azurewebsites.net"
    }
  ]

  routes = [
    {
      name              = "route-default"
      endpoint_name     = "ep-myapp"
      origin_group_name = "og-webapp"
      origin_names      = ["origin-webapp"]
      cache = {
        query_string_caching_behavior = "UseQueryString"
        compression_enabled           = true
        content_types_to_compress     = ["text/html", "application/javascript", "text/css"]
      }
    }
  ]

  custom_domains = [
    {
      name      = "cd-example"
      host_name = "www.example.com"
      tls = {
        certificate_type    = "ManagedCertificate"
        minimum_tls_version = "TLS12"
      }
    }
  ]

  security_policies = [
    {
      name               = "sp-waf"
      patterns_to_match  = ["/*"]
      firewall_policy_id = "/subscriptions/.../frontDoorWebApplicationFirewallPolicies/mywafpolicy"
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.70.0, < 5.0.0 |

## Resources

| Name | Type |
|------|------|
| azurerm_cdn_frontdoor_profile | resource |
| azurerm_cdn_frontdoor_endpoint | resource |
| azurerm_cdn_frontdoor_origin_group | resource |
| azurerm_cdn_frontdoor_origin | resource |
| azurerm_cdn_frontdoor_route | resource |
| azurerm_cdn_frontdoor_custom_domain | resource |
| azurerm_cdn_frontdoor_security_policy | resource |
| azurerm_monitor_diagnostic_setting | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| create | Controls whether to create resources | `bool` | `true` | no |
| resource_group_name | Resource group name (must exist) | `string` | n/a | yes |
| name | Explicit name for the profile | `string` | `null` | no |
| name_prefix | Prefix for generated name | `string` | `"afd"` | no |
| workload | Workload name | `string` | `"web"` | no |
| environment | Environment name | `string` | `"prod"` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| sku_name | SKU: Standard_AzureFrontDoor or Premium_AzureFrontDoor | `string` | `"Standard_AzureFrontDoor"` | no |
| response_timeout_seconds | Maximum response timeout (16-240) | `number` | `120` | no |
| endpoints | List of Front Door endpoints | `list(object)` | `[]` | no |
| origin_groups | List of origin groups | `list(object)` | `[]` | no |
| origins | List of origins | `list(object)` | `[]` | no |
| routes | List of routes | `list(object)` | `[]` | no |
| custom_domains | List of custom domains | `list(object)` | `[]` | no |
| security_policies | List of security policies | `list(object)` | `[]` | no |
| tags | Tags to assign to resources | `map(string)` | `{}` | no |
| diagnostic_settings | Diagnostic settings configuration | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| profile_id | The ID of the Front Door profile |
| profile_name | The name of the Front Door profile |
| resource_guid | The UUID of the Front Door profile |
| endpoint_ids | Map of endpoint names to resource IDs |
| endpoint_host_names | Map of endpoint names to host names |
| origin_group_ids | Map of origin group names to resource IDs |
| origin_ids | Map of origin names to resource IDs |
| route_ids | Map of route names to resource IDs |
| custom_domain_ids | Map of custom domain names to resource IDs |
| custom_domain_validation_tokens | Map of custom domain names to DNS validation tokens |
| security_policy_ids | Map of security policy names to resource IDs |

## Dependencies

Resources that must exist before using this module:

- **Resource Group**: The resource group specified by `resource_group_name`.
- **WAF Policy** (optional): Required if `security_policies` is configured.
- **Private Link Target** (optional): Required if any origin uses `private_link`.
- **Key Vault Secret** (optional): Required if any custom domain uses `CustomerCertificate` TLS type.
- **Log Analytics Workspace / Storage Account** (optional): Required if `diagnostic_settings` is configured.

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
| [azurerm_cdn_frontdoor_custom_domain.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_custom_domain) | resource |
| [azurerm_cdn_frontdoor_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_endpoint) | resource |
| [azurerm_cdn_frontdoor_origin.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_origin) | resource |
| [azurerm_cdn_frontdoor_origin_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_origin_group) | resource |
| [azurerm_cdn_frontdoor_profile.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_profile) | resource |
| [azurerm_cdn_frontdoor_route.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_route) | resource |
| [azurerm_cdn_frontdoor_security_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_security_policy) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Front Door profile and associated resources. | `bool` | `true` | no |
| <a name="input_custom_domains"></a> [custom\_domains](#input\_custom\_domains) | (Optional) List of custom domains to associate with the Front Door profile.<br/><br/>Attributes:<br/>  - name:      Unique name for the custom domain resource.<br/>  - host\_name: The FQDN of the custom domain.<br/>  - tls:       TLS configuration (optional).<br/>    - certificate\_type:    ManagedCertificate or CustomerCertificate. Defaults to "ManagedCertificate".<br/>    - minimum\_tls\_version: TLS1\_0, TLS1\_2. Defaults to "TLS12".<br/>    - cdn\_frontdoor\_secret\_id: Secret ID for CustomerCertificate type.<br/>      DEPENDENCY: Secret must exist when using CustomerCertificate. | <pre>list(object({<br/>    name      = string<br/>    host_name = string<br/>    tls = optional(object({<br/>      certificate_type        = optional(string, "ManagedCertificate")<br/>      minimum_tls_version     = optional(string, "TLS12")<br/>      cdn_frontdoor_secret_id = optional(string, null)<br/>    }), {})<br/>  }))</pre> | `[]` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | (Optional) Diagnostic settings configuration.<br/>DEPENDENCY: Log Analytics workspace and/or Storage account must exist. | <pre>object({<br/>    name                           = optional(string, "diag-afd")<br/>    log_analytics_workspace_id     = optional(string, null)<br/>    storage_account_id             = optional(string, null)<br/>    eventhub_authorization_rule_id = optional(string, null)<br/>    log_categories = optional(list(string), [<br/>      "FrontDoorAccessLog",<br/>      "FrontDoorHealthProbeLog",<br/>      "FrontDoorWebApplicationFirewallLog"<br/>    ])<br/>    metric_categories = optional(list(string), ["AllMetrics"])<br/>  })</pre> | `null` | no |
| <a name="input_endpoints"></a> [endpoints](#input\_endpoints) | (Optional) List of Front Door endpoints.<br/><br/>Attributes:<br/>  - name:    Unique name for the endpoint.<br/>  - enabled: Whether the endpoint is enabled. Defaults to true. | <pre>list(object({<br/>    name    = string<br/>    enabled = optional(bool, true)<br/>  }))</pre> | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name. | `string` | `"prod"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Explicit name for the Front Door profile. Overrides generated name. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"afd"` | no |
| <a name="input_origin_groups"></a> [origin\_groups](#input\_origin\_groups) | (Optional) List of Front Door origin groups.<br/><br/>Attributes:<br/>  - name:                          Unique name for the origin group.<br/>  - session\_affinity\_enabled:      Enable session affinity. Defaults to false.<br/>  - restore\_traffic\_time\_to\_healed\_or\_new\_endpoint\_in\_minutes:<br/>      Time in minutes to shift traffic to a healed or new endpoint. Defaults to 10.<br/>  - health\_probe:                  Health probe settings (optional).<br/>    - interval\_in\_seconds:         Probe interval (5-31536000). Defaults to 100.<br/>    - path:                        Probe path. Defaults to "/".<br/>    - protocol:                    Http or Https. Defaults to "Https".<br/>    - request\_type:                GET or HEAD. Defaults to "HEAD".<br/>  - load\_balancing:                Load balancing settings.<br/>    - additional\_latency\_in\_milliseconds: Extra latency threshold. Defaults to 50.<br/>    - sample\_size:                 Number of samples. Defaults to 4.<br/>    - successful\_samples\_required: Successful samples needed. Defaults to 3. | <pre>list(object({<br/>    name                                                          = string<br/>    session_affinity_enabled                                      = optional(bool, false)<br/>    restore_traffic_time_to_healed_or_new_endpoint_in_minutes     = optional(number, 10)<br/>    health_probe = optional(object({<br/>      interval_in_seconds = optional(number, 100)<br/>      path                = optional(string, "/")<br/>      protocol            = optional(string, "Https")<br/>      request_type        = optional(string, "HEAD")<br/>    }), null)<br/>    load_balancing = optional(object({<br/>      additional_latency_in_milliseconds = optional(number, 50)<br/>      sample_size                        = optional(number, 4)<br/>      successful_samples_required        = optional(number, 3)<br/>    }), {})<br/>  }))</pre> | `[]` | no |
| <a name="input_origins"></a> [origins](#input\_origins) | (Optional) List of Front Door origins.<br/><br/>Attributes:<br/>  - name:                            Unique name for the origin.<br/>  - origin\_group\_name:               Name of the origin group this origin belongs to.<br/>  - host\_name:                       The hostname/IP of the origin.<br/>  - http\_port:                       HTTP port. Defaults to 80.<br/>  - https\_port:                      HTTPS port. Defaults to 443.<br/>  - origin\_host\_header:              Host header sent to the origin. Defaults to host\_name.<br/>  - priority:                        Priority (1-5). Defaults to 1.<br/>  - weight:                          Weight (1-1000). Defaults to 1000.<br/>  - enabled:                         Whether the origin is enabled. Defaults to true.<br/>  - certificate\_name\_check\_enabled:  Whether certificate name check is enabled. Defaults to true.<br/>  - private\_link:                    Private Link configuration (Premium SKU only, optional).<br/>    - request\_message:               Approval request message.<br/>    - target\_type:                   Target type (e.g., "blob", "sites").<br/>    - location:                      Azure region of the Private Link resource.<br/>    - private\_link\_target\_id:        Resource ID of the Private Link target.<br/>      DEPENDENCY: Private Link target must exist. | <pre>list(object({<br/>    name                           = string<br/>    origin_group_name              = string<br/>    host_name                      = string<br/>    http_port                      = optional(number, 80)<br/>    https_port                     = optional(number, 443)<br/>    origin_host_header             = optional(string, null)<br/>    priority                       = optional(number, 1)<br/>    weight                         = optional(number, 1000)<br/>    enabled                        = optional(bool, true)<br/>    certificate_name_check_enabled = optional(bool, true)<br/>    private_link = optional(object({<br/>      request_message        = optional(string, "Please approve this Private Link connection.")<br/>      target_type            = optional(string, null)<br/>      location               = string<br/>      private_link_target_id = string<br/>    }), null)<br/>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource Group name. DEPENDENCY: Must exist. | `string` | n/a | yes |
| <a name="input_response_timeout_seconds"></a> [response\_timeout\_seconds](#input\_response\_timeout\_seconds) | (Optional) Specifies the maximum response timeout in seconds. Possible values are between 16 and 240 seconds. | `number` | `120` | no |
| <a name="input_routes"></a> [routes](#input\_routes) | (Optional) List of Front Door routes.<br/><br/>Attributes:<br/>  - name:                    Unique name for the route.<br/>  - endpoint\_name:           Name of the endpoint this route is associated with.<br/>  - origin\_group\_name:       Name of the origin group for this route.<br/>  - origin\_names:            List of origin names within the origin group.<br/>  - patterns\_to\_match:       URL patterns to match. Defaults to ["/*"].<br/>  - supported\_protocols:     List of supported protocols. Defaults to ["Http", "Https"].<br/>  - forwarding\_protocol:     Forwarding protocol: HttpOnly, HttpsOnly, or MatchRequest. Defaults to "HttpsOnly".<br/>  - https\_redirect\_enabled:  Redirect HTTP to HTTPS. Defaults to true.<br/>  - link\_to\_default\_domain:  Link to the default (.azurefd.net) domain. Defaults to true.<br/>  - cache:                   Cache configuration (optional).<br/>    - query\_string\_caching\_behavior: IgnoreQueryString, UseQueryString, IgnoreSpecifiedQueryStrings, IncludeSpecifiedQueryStrings. Defaults to "IgnoreQueryString".<br/>    - query\_strings:                 List of query string parameters.<br/>    - compression\_enabled:           Enable compression. Defaults to false.<br/>    - content\_types\_to\_compress:     List of MIME types to compress. | <pre>list(object({<br/>    name                   = string<br/>    endpoint_name          = string<br/>    origin_group_name      = string<br/>    origin_names           = optional(list(string), [])<br/>    patterns_to_match      = optional(list(string), ["/*"])<br/>    supported_protocols    = optional(list(string), ["Http", "Https"])<br/>    forwarding_protocol    = optional(string, "HttpsOnly")<br/>    https_redirect_enabled = optional(bool, true)<br/>    link_to_default_domain = optional(bool, true)<br/>    cache = optional(object({<br/>      query_string_caching_behavior = optional(string, "IgnoreQueryString")<br/>      query_strings                 = optional(list(string), [])<br/>      compression_enabled           = optional(bool, false)<br/>      content_types_to_compress     = optional(list(string), [])<br/>    }), null)<br/>  }))</pre> | `[]` | no |
| <a name="input_security_policies"></a> [security\_policies](#input\_security\_policies) | (Optional) List of security policies to associate with the Front Door profile.<br/>DEPENDENCY: Firewall policy must exist.<br/><br/>Attributes:<br/>  - name:               Unique name for the security policy.<br/>  - patterns\_to\_match:  List of endpoint/domain association patterns (e.g., endpoint IDs, domain IDs).<br/>  - firewall\_policy\_id: Resource ID of the Front Door Firewall Policy. | <pre>list(object({<br/>    name               = string<br/>    patterns_to_match  = list(string)<br/>    firewall_policy_id = string<br/>  }))</pre> | `[]` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Optional) SKU name for the Front Door profile.<br/><br/>Allowed values:<br/>  - Standard\_AzureFrontDoor: Standard tier with basic CDN/routing capabilities.<br/>  - Premium\_AzureFrontDoor:  Premium tier with WAF, Private Link, and advanced features. | `string` | `"Standard_AzureFrontDoor"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name. | `string` | `"web"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_custom_domain_ids"></a> [custom\_domain\_ids](#output\_custom\_domain\_ids) | Map of custom domain names to their resource IDs. |
| <a name="output_custom_domain_validation_tokens"></a> [custom\_domain\_validation\_tokens](#output\_custom\_domain\_validation\_tokens) | Map of custom domain names to their DNS validation tokens. |
| <a name="output_endpoint_host_names"></a> [endpoint\_host\_names](#output\_endpoint\_host\_names) | Map of endpoint names to their host names (.azurefd.net). |
| <a name="output_endpoint_ids"></a> [endpoint\_ids](#output\_endpoint\_ids) | Map of endpoint names to their resource IDs. |
| <a name="output_origin_group_ids"></a> [origin\_group\_ids](#output\_origin\_group\_ids) | Map of origin group names to their resource IDs. |
| <a name="output_origin_ids"></a> [origin\_ids](#output\_origin\_ids) | Map of origin names to their resource IDs. |
| <a name="output_profile_id"></a> [profile\_id](#output\_profile\_id) | The ID of the Front Door profile. |
| <a name="output_profile_name"></a> [profile\_name](#output\_profile\_name) | The name of the Front Door profile. |
| <a name="output_resource_guid"></a> [resource\_guid](#output\_resource\_guid) | The UUID of the Front Door profile. |
| <a name="output_route_ids"></a> [route\_ids](#output\_route\_ids) | Map of route names to their resource IDs. |
| <a name="output_security_policy_ids"></a> [security\_policy\_ids](#output\_security\_policy\_ids) | Map of security policy names to their resource IDs. |
<!-- END_TF_DOCS -->