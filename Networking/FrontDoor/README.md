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
