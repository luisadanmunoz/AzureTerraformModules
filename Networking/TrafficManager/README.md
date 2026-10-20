# Azure Traffic Manager Terraform Module

This module creates an Azure Traffic Manager profile with support for multiple routing methods, endpoint types (Azure, External, Nested), health monitoring, and diagnostic settings.

## Features

- Multiple traffic routing methods: Performance, Priority, Weighted, Geographic, MultiValue, Subnet
- Azure Endpoints (Public IPs, App Services, etc.)
- External Endpoints (any external FQDN)
- Nested Endpoints (child Traffic Manager profiles)
- Configurable health monitoring (HTTP, HTTPS, TCP)
- Custom headers for health probes
- Traffic View support
- Diagnostic settings (Log Analytics, Storage Account, Event Hub)

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| Target Resources | No | Azure resources for Azure endpoints (Public IP, App Service, etc.) |
| Child TM Profiles | No | For nested endpoints |
| Log Analytics Workspace | No | For diagnostic settings |

## Usage

### Performance Routing with Azure Endpoints

```hcl
module "traffic_manager" {
  source = "../../Networking/TrafficManager"

  resource_group_name = "rg-tm-prod-001"
  name                = "tm-web-prod-001"

  traffic_routing_method = "Performance"

  monitor_config = {
    protocol = "HTTPS"
    port     = 443
    path     = "/health"
  }

  endpoints = [
    {
      name               = "ep-westeurope"
      type               = "azureEndpoints"
      target_resource_id = azurerm_public_ip.west.id
    },
    {
      name               = "ep-eastus"
      type               = "azureEndpoints"
      target_resource_id = azurerm_public_ip.east.id
    }
  ]
}
```

### Weighted Routing with External Endpoints

```hcl
module "traffic_manager" {
  source = "../../Networking/TrafficManager"

  resource_group_name = "rg-tm-prod-001"
  name                = "tm-api-prod-001"

  traffic_routing_method = "Weighted"

  monitor_config = {
    protocol = "HTTPS"
    port     = 443
    path     = "/api/health"
  }

  endpoints = [
    {
      name              = "ep-primary"
      type              = "externalEndpoints"
      target            = "primary.example.com"
      weight            = 80
      endpoint_location = "West Europe"
    },
    {
      name              = "ep-secondary"
      type              = "externalEndpoints"
      target            = "secondary.example.com"
      weight            = 20
      endpoint_location = "East US"
    }
  ]
}
```

### Priority Routing with Nested Endpoints

```hcl
module "traffic_manager" {
  source = "../../Networking/TrafficManager"

  resource_group_name = "rg-tm-prod-001"
  name                = "tm-global-prod-001"

  traffic_routing_method = "Priority"

  monitor_config = {
    protocol = "HTTPS"
    port     = 443
    path     = "/"
  }

  endpoints = [
    {
      name                = "ep-region1"
      type                = "nestedEndpoints"
      target_resource_id  = module.tm_region1.id
      priority            = 1
      endpoint_location   = "West Europe"
      min_child_endpoints = 2
    },
    {
      name                = "ep-region2"
      type                = "nestedEndpoints"
      target_resource_id  = module.tm_region2.id
      priority            = 2
      endpoint_location   = "East US"
      min_child_endpoints = 1
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| name | Explicit profile name | `string` | auto | no |
| name_prefix | Prefix for generated name | `string` | `"tm"` | no |
| workload | Workload name | `string` | `"app"` | no |
| environment | Environment name | `string` | `"prod"` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| profile_status | Profile status (Enabled/Disabled) | `string` | `"Enabled"` | no |
| traffic_routing_method | Routing method | `string` | `"Performance"` | no |
| dns_config_relative_name | DNS relative name | `string` | auto | no |
| dns_config_ttl | DNS TTL in seconds | `number` | `60` | no |
| max_return | Max endpoints for MultiValue | `number` | `null` | no |
| traffic_view_enabled | Enable Traffic View | `bool` | `false` | no |
| monitor_config | Health monitoring config | `object({...})` | defaults | no |
| endpoints | List of endpoints | `list(object({...}))` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |
| diagnostic_settings | Diagnostic settings | `object({...})` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Traffic Manager profile ID |
| name | Traffic Manager profile name |
| fqdn | Traffic Manager profile FQDN |
| profile_id | Traffic Manager profile ID |
| azure_endpoint_ids | Map of Azure endpoint names to IDs |
| external_endpoint_ids | Map of external endpoint names to IDs |
| nested_endpoint_ids | Map of nested endpoint names to IDs |

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
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_traffic_manager_azure_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/traffic_manager_azure_endpoint) | resource |
| [azurerm_traffic_manager_external_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/traffic_manager_external_endpoint) | resource |
| [azurerm_traffic_manager_nested_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/traffic_manager_nested_endpoint) | resource |
| [azurerm_traffic_manager_profile.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/traffic_manager_profile) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Traffic Manager profile. | `bool` | `true` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | (Optional) Diagnostic settings configuration for the Traffic Manager profile.<br/>DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist. | <pre>object({<br/>    name                           = optional(string, "diag-tm")<br/>    log_analytics_workspace_id     = optional(string, null)<br/>    storage_account_id             = optional(string, null)<br/>    eventhub_authorization_rule_id = optional(string, null)<br/>    eventhub_name                  = optional(string, null)<br/>    log_categories                 = optional(list(string), ["ProbeHealthStatusEvents"])<br/>    metric_categories              = optional(list(string), ["AllMetrics"])<br/>  })</pre> | `null` | no |
| <a name="input_dns_config_relative_name"></a> [dns\_config\_relative\_name](#input\_dns\_config\_relative\_name) | (Optional) The relative DNS name for the Traffic Manager profile.<br/>This forms the FQDN: <relative\_name>.trafficmanager.net.<br/>If not set, the profile name is used. | `string` | `null` | no |
| <a name="input_dns_config_ttl"></a> [dns\_config\_ttl](#input\_dns\_config\_ttl) | (Optional) The DNS Time-To-Live (TTL) in seconds. Default is 60. | `number` | `60` | no |
| <a name="input_endpoints"></a> [endpoints](#input\_endpoints) | (Optional) List of Traffic Manager endpoints.<br/><br/>Attributes:<br/>  - name: The name of the endpoint.<br/>  - type: The type of endpoint. Possible values: azureEndpoints, externalEndpoints, nestedEndpoints.<br/>  - target\_resource\_id: The resource ID of the Azure target (for azureEndpoints/nestedEndpoints).<br/>    DEPENDENCY: Target resource must exist.<br/>  - target: The FQDN of the external endpoint (for externalEndpoints).<br/>  - weight: The weight of the endpoint (1-1000, for Weighted routing).<br/>  - priority: The priority of the endpoint (1-1000, for Priority routing).<br/>  - endpoint\_location: The location of the endpoint (required for Performance/Geographic routing with external/nested endpoints).<br/>  - min\_child\_endpoints: Minimum child endpoints for nested endpoint to be considered healthy.<br/>  - min\_child\_endpoints\_ipv4: Minimum IPv4 child endpoints for nested endpoint.<br/>  - min\_child\_endpoints\_ipv6: Minimum IPv6 child endpoints for nested endpoint.<br/>  - geo\_mappings: List of geographic mappings (for Geographic routing).<br/>  - subnet: List of subnet objects with first, last, and scope for Subnet routing.<br/>  - custom\_header: List of custom header objects with name and value.<br/>  - enabled: Whether the endpoint is enabled. | <pre>list(object({<br/>    name                        = string<br/>    type                        = string<br/>    target_resource_id          = optional(string, null)<br/>    target                      = optional(string, null)<br/>    weight                      = optional(number, null)<br/>    priority                    = optional(number, null)<br/>    endpoint_location           = optional(string, null)<br/>    min_child_endpoints         = optional(number, null)<br/>    min_child_endpoints_ipv4    = optional(number, null)<br/>    min_child_endpoints_ipv6    = optional(number, null)<br/>    geo_mappings                = optional(list(string), null)<br/>    subnet = optional(list(object({<br/>      first = string<br/>      last  = optional(string, null)<br/>      scope = optional(number, null)<br/>    })), null)<br/>    custom_header = optional(list(object({<br/>      name  = string<br/>      value = string<br/>    })), null)<br/>    enabled = optional(bool, true)<br/>  }))</pre> | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"prod"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance identifier. | `string` | `"001"` | no |
| <a name="input_max_return"></a> [max\_return](#input\_max\_return) | (Optional) The maximum number of endpoints returned for MultiValue routing.<br/>Only applicable when traffic\_routing\_method is MultiValue. | `number` | `null` | no |
| <a name="input_monitor_config"></a> [monitor\_config](#input\_monitor\_config) | (Optional) Monitor configuration for the Traffic Manager profile.<br/><br/>Attributes:<br/>  - protocol: Protocol for health checks (HTTP, HTTPS, TCP).<br/>  - port: Port number for health checks.<br/>  - path: Path for HTTP/HTTPS health checks.<br/>  - interval\_in\_seconds: Probing interval in seconds (10 or 30).<br/>  - timeout\_in\_seconds: Probe timeout in seconds.<br/>  - tolerated\_number\_of\_failures: Number of consecutive failures before endpoint is degraded.<br/>  - expected\_status\_code\_ranges: List of expected status code ranges (e.g., "200-299").<br/>  - custom\_header: List of custom headers for health checks. | <pre>object({<br/>    protocol                     = optional(string, "HTTPS")<br/>    port                         = optional(number, 443)<br/>    path                         = optional(string, "/")<br/>    interval_in_seconds          = optional(number, 30)<br/>    timeout_in_seconds           = optional(number, 10)<br/>    tolerated_number_of_failures = optional(number, 3)<br/>    expected_status_code_ranges  = optional(list(string), null)<br/>    custom_header = optional(list(object({<br/>      name  = string<br/>      value = string<br/>    })), null)<br/>  })</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Explicit name for the Traffic Manager profile. If provided, overrides generated name. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for generated name. | `string` | `"tm"` | no |
| <a name="input_profile_status"></a> [profile\_status](#input\_profile\_status) | (Optional) The status of the Traffic Manager profile. Possible values: Enabled, Disabled. | `string` | `"Enabled"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Traffic Manager profile will be created.<br/>DEPENDENCY: Resource Group must exist before creating the Traffic Manager profile. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_traffic_routing_method"></a> [traffic\_routing\_method](#input\_traffic\_routing\_method) | (Optional) The traffic routing method for the profile.<br/>Possible values: Performance, Priority, Weighted, Geographic, MultiValue, Subnet. | `string` | `"Performance"` | no |
| <a name="input_traffic_view_enabled"></a> [traffic\_view\_enabled](#input\_traffic\_view\_enabled) | (Optional) Whether Traffic View is enabled for the profile. | `bool` | `false` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload or purpose name, used for naming convention. | `string` | `"app"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_azure_endpoint_ids"></a> [azure\_endpoint\_ids](#output\_azure\_endpoint\_ids) | Map of Azure endpoint names to their IDs. |
| <a name="output_external_endpoint_ids"></a> [external\_endpoint\_ids](#output\_external\_endpoint\_ids) | Map of external endpoint names to their IDs. |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The FQDN of the Traffic Manager profile. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Traffic Manager profile. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Traffic Manager profile. |
| <a name="output_nested_endpoint_ids"></a> [nested\_endpoint\_ids](#output\_nested\_endpoint\_ids) | Map of nested endpoint names to their IDs. |
| <a name="output_profile_id"></a> [profile\_id](#output\_profile\_id) | The unique profile ID of the Traffic Manager profile. |
<!-- END_TF_DOCS -->