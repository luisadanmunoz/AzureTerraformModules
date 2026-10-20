# Azure Function App Module

Terraform module to create and manage **Azure Function Apps** for serverless compute workloads.

## Features

- Linux and Windows Function Apps
- Runtime version support (~4 for latest)
- Multiple language stacks (Node.js, Python, .NET, Java, PowerShell)
- Application Insights integration
- VNet integration
- Managed Identity (System and User Assigned)
- Storage with access key or Managed Identity
- Connection strings support
- IP restrictions and CORS
- Conditional creation with `create = true/false`

## Usage - Basic Linux Function App

```hcl
module "function_app" {
  source = "path/to/Automation/FunctionApp"

  resource_group_name    = "rg-functions-dev-001"
  location               = "westeurope"
  name                   = "func-api-dev-001"
  os_type                = "Linux"
  service_plan_id        = module.app_service_plan.id
  storage_account_name   = module.storage_account.name
  storage_account_access_key = module.storage_account.primary_access_key

  site_config = {
    application_stack = {
      python_version = "3.11"
    }
  }

  tags = {
    Environment = "Development"
  }
}
```

## Usage - Windows Function App with .NET

```hcl
module "function_app" {
  source = "path/to/Automation/FunctionApp"

  resource_group_name    = "rg-functions-prod-001"
  location               = "westeurope"
  name                   = "func-api-prod-001"
  os_type                = "Windows"
  service_plan_id        = module.app_service_plan.id
  storage_account_name   = module.storage_account.name
  storage_account_access_key = module.storage_account.primary_access_key

  site_config = {
    always_on = true
    application_stack = {
      dotnet_version              = "v8.0"
      use_dotnet_isolated_runtime = true
    }
  }

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}
```

## Usage - With VNet Integration and Managed Identity

```hcl
module "function_app" {
  source = "path/to/Automation/FunctionApp"

  resource_group_name           = "rg-functions-prod-001"
  location                      = "westeurope"
  name                          = "func-processor-prod-001"
  os_type                       = "Linux"
  service_plan_id               = module.app_service_plan.id
  storage_account_name          = module.storage_account.name
  storage_uses_managed_identity = true
  virtual_network_subnet_id     = module.subnet.id
  public_network_access_enabled = false

  site_config = {
    always_on              = true
    vnet_route_all_enabled = true
    application_stack = {
      node_version = "20"
    }
    application_insights_connection_string = module.app_insights.connection_string
  }

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
    Purpose     = "Event Processing"
  }
}
```

## Usage - With IP Restrictions

```hcl
module "function_app" {
  source = "path/to/Automation/FunctionApp"

  resource_group_name    = "rg-functions-prod-001"
  location               = "westeurope"
  name                   = "func-api-prod-001"
  os_type                = "Linux"
  service_plan_id        = module.app_service_plan.id
  storage_account_name   = module.storage_account.name
  storage_account_access_key = module.storage_account.primary_access_key

  site_config = {
    application_stack = {
      python_version = "3.11"
    }
    ip_restriction = [
      {
        name       = "AllowCorporate"
        ip_address = "203.0.113.0/24"
        action     = "Allow"
        priority   = 100
      },
      {
        name        = "AllowAzureFrontDoor"
        service_tag = "AzureFrontDoor.Backend"
        action      = "Allow"
        priority    = 200
      }
    ]
  }

  tags = {
    Environment = "Production"
  }
}
```

## Supported Language Stacks

### Linux
| Language | Version Examples |
|----------|-----------------|
| Python | 3.9, 3.10, 3.11 |
| Node.js | 18, 20 |
| .NET | v6.0, v7.0, v8.0 |
| Java | 8, 11, 17 |
| PowerShell | 7.2, 7.4 |

### Windows
| Language | Version Examples |
|----------|-----------------|
| Node.js | ~18, ~20 |
| .NET | v6.0, v7.0, v8.0 |
| Java | 8, 11, 17 |
| PowerShell | 7.2, 7.4 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create the resource | `bool` | `true` | no |
| `resource_group_name` | Name of the Resource Group | `string` | - | yes |
| `location` | Azure Region | `string` | - | yes |
| `name` | Explicit name | `string` | `null` | no |
| `name_prefix` | Prefix for generated name | `string` | `"func"` | no |
| `workload` | Workload name | `string` | `"app"` | no |
| `environment` | Environment name | `string` | `"dev"` | no |
| `instance` | Instance number | `string` | `"001"` | no |
| `os_type` | OS type (Linux, Windows) | `string` | - | yes |
| `service_plan_id` | App Service Plan ID | `string` | - | yes |
| `storage_account_name` | Storage Account name | `string` | - | yes |
| `storage_account_access_key` | Storage Account access key | `string` | `null` | no |
| `storage_uses_managed_identity` | Use Managed Identity for storage | `bool` | `false` | no |
| `functions_extension_version` | Functions runtime version | `string` | `"~4"` | no |
| `builtin_logging_enabled` | Enable built-in logging | `bool` | `true` | no |
| `enabled` | Enable the Function App | `bool` | `true` | no |
| `https_only` | HTTPS only | `bool` | `true` | no |
| `public_network_access_enabled` | Enable public network access | `bool` | `true` | no |
| `app_settings` | Application settings | `map(string)` | `{}` | no |
| `site_config` | Site configuration | `object` | `{}` | no |
| `virtual_network_subnet_id` | Subnet ID for VNet integration | `string` | `null` | no |
| `identity` | Identity configuration | `object` | `null` | no |
| `connection_strings` | Connection strings | `list(object)` | `[]` | no |
| `tags` | Tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the Function App |
| `name` | The name |
| `default_hostname` | The default hostname |
| `outbound_ip_addresses` | Comma-separated outbound IPs |
| `possible_outbound_ip_addresses` | Comma-separated possible outbound IPs |
| `identity` | The identity block |
| `principal_id` | System Assigned Identity Principal ID |
| `tenant_id` | System Assigned Identity Tenant ID |
| `kind` | The Kind value |
| `os_type` | The OS type |

## Dependencies

- **Resource Group** must exist
- **App Service Plan** must exist
- **Storage Account** must exist
- **Subnet** must exist (if VNet integration is used)

## Hosting Plans

| Plan | always_on | Best For |
|------|-----------|----------|
| Consumption | false (required) | Event-driven, cost-sensitive |
| Premium | true/false | Pre-warmed instances, VNet |
| Dedicated (App Service) | true/false | Full App Service features |

## Notes

- `always_on` must be `false` for Consumption plans
- Use `storage_uses_managed_identity = true` for secure storage access
- Enable VNet integration with `virtual_network_subnet_id` for private networking
- Set `vnet_route_all_enabled = true` to route all traffic through VNet
