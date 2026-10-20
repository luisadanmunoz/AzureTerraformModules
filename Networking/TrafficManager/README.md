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
