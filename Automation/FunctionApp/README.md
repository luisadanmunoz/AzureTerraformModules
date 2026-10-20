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
| [azurerm_linux_function_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app) | resource |
| [azurerm_windows_function_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | (Optional) Map of application settings. | `map(string)` | `{}` | no |
| <a name="input_builtin_logging_enabled"></a> [builtin\_logging\_enabled](#input\_builtin\_logging\_enabled) | (Optional) Whether built-in logging is enabled. Default: true. | `bool` | `true` | no |
| <a name="input_client_certificate_enabled"></a> [client\_certificate\_enabled](#input\_client\_certificate\_enabled) | (Optional) Whether client certificates are enabled. Default: false. | `bool` | `false` | no |
| <a name="input_client_certificate_mode"></a> [client\_certificate\_mode](#input\_client\_certificate\_mode) | (Optional) Client certificate mode. Values: Required, Optional, OptionalInteractiveUser. | `string` | `null` | no |
| <a name="input_connection_strings"></a> [connection\_strings](#input\_connection\_strings) | (Optional) List of connection strings.<br/>- name: Name of the connection string.<br/>- type: Type (SQLServer, SQLAzure, Custom, etc.).<br/>- value: Connection string value. | <pre>list(object({<br/>    name  = string<br/>    type  = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Function App. | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether the Function App is enabled. Default: true. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_functions_extension_version"></a> [functions\_extension\_version](#input\_functions\_extension\_version) | (Optional) The runtime version of the Function App. Default: ~4. | `string` | `"~4"` | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | (Optional) Whether HTTPS only is enabled. Default: true. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Identity configuration.<br/>- type: Type of identity. Values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned.<br/>- identity\_ids: List of User Assigned Identity IDs. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Function App should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Function App. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'func'. | `string` | `"func"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | (Required) The OS type for the Function App. Values: Linux, Windows. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether public network access is enabled. Default: true. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_service_plan_id"></a> [service\_plan\_id](#input\_service\_plan\_id) | (Required) The ID of the App Service Plan. DEPENDENCY: App Service Plan must exist. | `string` | n/a | yes |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | (Optional) Site configuration block.<br/>- always\_on: Enable always on. Default: false (must be false for Consumption).<br/>- ftps\_state: FTPS state. Default: Disabled.<br/>- http2\_enabled: Enable HTTP2. Default: true.<br/>- minimum\_tls\_version: Minimum TLS version. Default: 1.2.<br/>- application\_insights\_key: Application Insights key.<br/>- application\_insights\_connection\_string: App Insights connection string.<br/>- application\_stack: Application stack configuration.<br/>- cors: CORS configuration.<br/>- ip\_restriction: List of IP restrictions. | <pre>object({<br/>    always_on                              = optional(bool, false)<br/>    ftps_state                             = optional(string, "Disabled")<br/>    http2_enabled                          = optional(bool, true)<br/>    minimum_tls_version                    = optional(string, "1.2")<br/>    use_32_bit_worker                      = optional(bool, false)<br/>    vnet_route_all_enabled                 = optional(bool, false)<br/>    application_insights_key               = optional(string, null)<br/>    application_insights_connection_string = optional(string, null)<br/>    application_stack = optional(object({<br/>      dotnet_version              = optional(string, null)<br/>      java_version                = optional(string, null)<br/>      node_version                = optional(string, null)<br/>      python_version              = optional(string, null)<br/>      powershell_core_version     = optional(string, null)<br/>      use_dotnet_isolated_runtime = optional(bool, false)<br/>    }), null)<br/>    cors = optional(object({<br/>      allowed_origins     = list(string)<br/>      support_credentials = optional(bool, false)<br/>    }), null)<br/>    ip_restriction = optional(list(object({<br/>      name                      = optional(string, null)<br/>      action                    = optional(string, "Allow")<br/>      ip_address                = optional(string, null)<br/>      virtual_network_subnet_id = optional(string, null)<br/>      service_tag               = optional(string, null)<br/>      priority                  = optional(number, 100)<br/>    })), [])<br/>  })</pre> | `{}` | no |
| <a name="input_storage_account_access_key"></a> [storage\_account\_access\_key](#input\_storage\_account\_access\_key) | (Optional) The access key for the Storage Account. Required if storage\_uses\_managed\_identity is false. | `string` | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | (Required) The name of the Storage Account. DEPENDENCY: Storage Account must exist. | `string` | n/a | yes |
| <a name="input_storage_uses_managed_identity"></a> [storage\_uses\_managed\_identity](#input\_storage\_uses\_managed\_identity) | (Optional) Use Managed Identity to access Storage Account. Default: false. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_virtual_network_subnet_id"></a> [virtual\_network\_subnet\_id](#input\_virtual\_network\_subnet\_id) | (Optional) The ID of the subnet for VNet integration. DEPENDENCY: Subnet must exist. | `string` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"app"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_default_hostname"></a> [default\_hostname](#output\_default\_hostname) | The default hostname of the Function App. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Function App. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity block of the Function App. |
| <a name="output_kind"></a> [kind](#output\_kind) | The Kind value of the Function App. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Function App. |
| <a name="output_os_type"></a> [os\_type](#output\_os\_type) | The OS type of the Function App. |
| <a name="output_outbound_ip_addresses"></a> [outbound\_ip\_addresses](#output\_outbound\_ip\_addresses) | A comma-separated list of outbound IP addresses. |
| <a name="output_possible_outbound_ip_addresses"></a> [possible\_outbound\_ip\_addresses](#output\_possible\_outbound\_ip\_addresses) | A comma-separated list of possible outbound IP addresses. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID of the System Assigned Managed Identity. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The Tenant ID of the System Assigned Managed Identity. |
<!-- END_TF_DOCS -->