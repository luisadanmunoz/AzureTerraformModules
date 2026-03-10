# ContainerAppEnvironment (Azure Container App Environment)

Terraform module for Azure Container App Environment.

## Features

- Consumption and Dedicated workload profiles
- VNet integration with internal load balancer
- Zone redundancy support
- Dapr components integration
- Azure Files storage mounting
- Custom certificates
- Log Analytics integration
- Application Insights for Dapr

## Usage

### Basic Environment

```hcl
module "environment" {
  source = "./Containers/ContainerAppEnvironment"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "apps"
  environment = "dev"

  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
}
```

### With VNet Integration

```hcl
module "environment" {
  source = "./Containers/ContainerAppEnvironment"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "enterprise"
  environment = "prod"

  log_analytics_workspace_id     = azurerm_log_analytics_workspace.main.id
  infrastructure_subnet_id       = azurerm_subnet.container_apps.id
  internal_load_balancer_enabled = true
  zone_redundancy_enabled        = true
}
```

### With Workload Profiles

```hcl
module "environment" {
  source = "./Containers/ContainerAppEnvironment"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "mixed"
  environment = "prod"

  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  workload_profiles = [
    {
      name                  = "Consumption"
      workload_profile_type = "Consumption"
    },
    {
      name                  = "dedicated-d4"
      workload_profile_type = "D4"
      minimum_count         = 1
      maximum_count         = 3
    },
    {
      name                  = "dedicated-e4"
      workload_profile_type = "E4"
      minimum_count         = 0
      maximum_count         = 5
    }
  ]
}
```

### With Dapr Components

```hcl
module "environment" {
  source = "./Containers/ContainerAppEnvironment"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "dapr"
  environment = "dev"

  log_analytics_workspace_id                  = azurerm_log_analytics_workspace.main.id
  dapr_application_insights_connection_string = azurerm_application_insights.main.connection_string

  dapr_components = [
    {
      name           = "statestore"
      component_type = "state.azure.blobstorage"
      version        = "v1"
      scopes         = ["app1", "app2"]
      metadata = [
        {
          name  = "accountName"
          value = azurerm_storage_account.main.name
        },
        {
          name        = "accountKey"
          secret_name = "storage-key"
        },
        {
          name  = "containerName"
          value = "state"
        }
      ]
      secret = [
        {
          name  = "storage-key"
          value = azurerm_storage_account.main.primary_access_key
        }
      ]
    },
    {
      name           = "pubsub"
      component_type = "pubsub.azure.servicebus"
      version        = "v1"
      metadata = [
        {
          name        = "connectionString"
          secret_name = "sb-connection"
        }
      ]
      secret = [
        {
          name  = "sb-connection"
          value = azurerm_servicebus_namespace.main.default_primary_connection_string
        }
      ]
    }
  ]
}
```

### With Storage

```hcl
module "environment" {
  source = "./Containers/ContainerAppEnvironment"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  workload    = "storage"
  environment = "dev"

  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  storages = [
    {
      name         = "shared-files"
      account_name = azurerm_storage_account.main.name
      share_name   = azurerm_storage_share.data.name
      access_key   = azurerm_storage_account.main.primary_access_key
      access_mode  = "ReadWrite"
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Resource group name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| name | Environment name | `string` | `null` | no |
| workload | Workload name | `string` | `""` | no |
| environment | Environment name | `string` | `""` | no |
| log_analytics_workspace_id | Log Analytics ID | `string` | `null` | no |
| infrastructure_subnet_id | Subnet ID for VNet | `string` | `null` | no |
| internal_load_balancer_enabled | Use internal LB | `bool` | `false` | no |
| zone_redundancy_enabled | Enable zone redundancy | `bool` | `false` | no |
| workload_profiles | Workload profiles | `list(object)` | `[]` | no |
| dapr_components | Dapr components | `list(object)` | `[]` | no |
| storages | Storage configurations | `list(object)` | `[]` | no |
| certificates | Certificates | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Environment ID |
| name | Environment name |
| default_domain | Default domain |
| static_ip_address | Static IP address |
| docker_bridge_cidr | Docker bridge CIDR |
| platform_reserved_cidr | Platform reserved CIDR |
| platform_reserved_dns_ip_address | DNS IP address |
| dapr_component_ids | Map of Dapr component IDs |
| storage_ids | Map of storage IDs |
| certificate_ids | Map of certificate IDs |

## Workload Profiles

| Type | Description | vCPUs | Memory |
|------|-------------|-------|--------|
| Consumption | Serverless, pay-per-use | Variable | Variable |
| D4 | Dedicated compute | 4 | 16 GB |
| D8 | Dedicated compute | 8 | 32 GB |
| D16 | Dedicated compute | 16 | 64 GB |
| D32 | Dedicated compute | 32 | 128 GB |
| E4 | Memory optimized | 4 | 32 GB |
| E8 | Memory optimized | 8 | 64 GB |
| E16 | Memory optimized | 16 | 128 GB |
| E32 | Memory optimized | 32 | 256 GB |

## Notes

- Subnet requires delegation to Microsoft.App/environments
- Zone redundancy requires multiple availability zones in the region
- Internal load balancer requires VNet integration
- Dapr components are shared across all apps in the environment
