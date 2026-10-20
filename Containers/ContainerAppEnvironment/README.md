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
| [azurerm_container_app_environment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment) | resource |
| [azurerm_container_app_environment_certificate.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_certificate) | resource |
| [azurerm_container_app_environment_dapr_component.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_dapr_component) | resource |
| [azurerm_container_app_environment_storage.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_storage) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_certificates"></a> [certificates](#input\_certificates) | List of certificates to add to the environment. | <pre>list(object({<br/>    name                         = string<br/>    certificate_blob_base64      = optional(string)<br/>    certificate_password         = optional(string)<br/>    key_vault_certificate_id     = optional(string)<br/>    certificate_key_vault_id     = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_dapr_application_insights_connection_string"></a> [dapr\_application\_insights\_connection\_string](#input\_dapr\_application\_insights\_connection\_string) | Application Insights connection string for Dapr. | `string` | `null` | no |
| <a name="input_dapr_components"></a> [dapr\_components](#input\_dapr\_components) | List of Dapr components to create in the environment. | <pre>list(object({<br/>    name           = string<br/>    component_type = string<br/>    version        = string<br/>    ignore_errors  = optional(bool, false)<br/>    init_timeout   = optional(string, "5s")<br/>    scopes         = optional(list(string), [])<br/>    metadata = optional(list(object({<br/>      name        = string<br/>      value       = optional(string)<br/>      secret_name = optional(string)<br/>    })), [])<br/>    secret = optional(list(object({<br/>      name  = string<br/>      value = string<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (dev, staging, prod) for naming convention. | `string` | `""` | no |
| <a name="input_infrastructure_resource_group_name"></a> [infrastructure\_resource\_group\_name](#input\_infrastructure\_resource\_group\_name) | Name of the resource group for infrastructure resources. If not set, a generated name will be used. | `string` | `null` | no |
| <a name="input_infrastructure_subnet_id"></a> [infrastructure\_subnet\_id](#input\_infrastructure\_subnet\_id) | The ID of the subnet for the Container App Environment infrastructure. | `string` | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_internal_load_balancer_enabled"></a> [internal\_load\_balancer\_enabled](#input\_internal\_load\_balancer\_enabled) | Whether the Container App Environment should be deployed with an internal load balancer. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Container App Environment will be created. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID of the Log Analytics Workspace for monitoring. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Container App Environment. If not provided, will be generated from naming variables. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the Container App Environment name. | `string` | `"cae"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the Container App Environment will be created. | `string` | n/a | yes |
| <a name="input_storages"></a> [storages](#input\_storages) | List of storage configurations for the environment. | <pre>list(object({<br/>    name             = string<br/>    account_name     = string<br/>    share_name       = string<br/>    access_key       = string<br/>    access_mode      = optional(string, "ReadOnly")<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name for naming convention. | `string` | `""` | no |
| <a name="input_workload_profiles"></a> [workload\_profiles](#input\_workload\_profiles) | List of workload profiles for the Container App Environment. | <pre>list(object({<br/>    name                  = string<br/>    workload_profile_type = string<br/>    minimum_count         = optional(number, 0)<br/>    maximum_count         = optional(number, 0)<br/>  }))</pre> | `[]` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled) | Whether the Container App Environment should be zone redundant. | `bool` | `false` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_certificate_ids"></a> [certificate\_ids](#output\_certificate\_ids) | Map of certificate names to their IDs. |
| <a name="output_dapr_component_ids"></a> [dapr\_component\_ids](#output\_dapr\_component\_ids) | Map of Dapr component names to their IDs. |
| <a name="output_default_domain"></a> [default\_domain](#output\_default\_domain) | The default domain of the Container App Environment. |
| <a name="output_docker_bridge_cidr"></a> [docker\_bridge\_cidr](#output\_docker\_bridge\_cidr) | The Docker bridge CIDR. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Container App Environment. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Container App Environment. |
| <a name="output_platform_reserved_cidr"></a> [platform\_reserved\_cidr](#output\_platform\_reserved\_cidr) | The platform reserved CIDR. |
| <a name="output_platform_reserved_dns_ip_address"></a> [platform\_reserved\_dns\_ip\_address](#output\_platform\_reserved\_dns\_ip\_address) | The platform reserved DNS IP address. |
| <a name="output_static_ip_address"></a> [static\_ip\_address](#output\_static\_ip\_address) | The static IP address of the Container App Environment. |
| <a name="output_storage_ids"></a> [storage\_ids](#output\_storage\_ids) | Map of storage names to their IDs. |
<!-- END_TF_DOCS -->