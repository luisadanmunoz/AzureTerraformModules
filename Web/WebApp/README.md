# Azure Web App Terraform Module

This Terraform module creates an Azure Web App (Linux or Windows) with comprehensive configuration options including authentication, backup, logging, and VNet integration.

## Features

- Support for both Linux and Windows Web Apps
- Flexible naming convention with support for custom names or generated names
- Application stack configuration for multiple runtimes
- Managed identity support (System Assigned, User Assigned, or both)
- Authentication settings v2 with multiple identity providers
- Backup configuration with customizable schedules
- HTTP and application logging
- VNet integration
- Connection strings and app settings
- Sticky settings for deployment slots
- Mounted storage accounts

## Usage

### Basic Linux Web App with Node.js

```hcl
module "webapp" {
  source = "./WebApp"

  resource_group_name = "rg-example"
  location            = "eastus"
  name                = "app-example-nodejs"
  service_plan_id     = azurerm_service_plan.example.id

  os_type = "Linux"

  site_config = {
    application_stack = {
      node_version = "18-lts"
    }
  }

  app_settings = {
    "NODE_ENV" = "production"
  }

  tags = {
    Environment = "Production"
  }
}
```

### Windows Web App with .NET

```hcl
module "webapp_windows" {
  source = "./WebApp"

  resource_group_name = "rg-example"
  location            = "eastus"
  name                = "app-example-dotnet"
  service_plan_id     = azurerm_service_plan.example.id

  os_type = "Windows"

  site_config = {
    application_stack = {
      dotnet_version = "v8.0"
      current_stack  = "dotnet"
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

### Linux Web App with Docker Container

```hcl
module "webapp_docker" {
  source = "./WebApp"

  resource_group_name = "rg-example"
  location            = "eastus"
  name                = "app-example-docker"
  service_plan_id     = azurerm_service_plan.example.id

  os_type = "Linux"

  site_config = {
    application_stack = {
      docker_image     = "nginx"
      docker_image_tag = "latest"
    }
  }
}
```

### Web App with VNet Integration and Private Endpoints

```hcl
module "webapp_vnet" {
  source = "./WebApp"

  resource_group_name = "rg-example"
  location            = "eastus"
  name                = "app-example-vnet"
  service_plan_id     = azurerm_service_plan.example.id

  os_type                       = "Linux"
  public_network_access_enabled = false
  virtual_network_subnet_id     = azurerm_subnet.webapp.id

  site_config = {
    application_stack = {
      python_version = "3.11"
    }
  }
}
```

### Web App with Authentication (Azure AD)

```hcl
module "webapp_auth" {
  source = "./WebApp"

  resource_group_name = "rg-example"
  location            = "eastus"
  name                = "app-example-auth"
  service_plan_id     = azurerm_service_plan.example.id

  os_type = "Linux"

  site_config = {
    application_stack = {
      node_version = "18-lts"
    }
  }

  auth_settings_v2 = {
    auth_enabled           = true
    require_authentication = true
    unauthenticated_action = "RedirectToLoginPage"
    default_provider       = "azureactivedirectory"

    active_directory_v2 = {
      client_id                  = "your-client-id"
      tenant_auth_endpoint       = "https://login.microsoftonline.com/your-tenant-id/v2.0"
      client_secret_setting_name = "AZURE_CLIENT_SECRET"
    }
  }

  app_settings = {
    "AZURE_CLIENT_SECRET" = "your-client-secret"
  }
}
```

### Web App with Backup Configuration

```hcl
module "webapp_backup" {
  source = "./WebApp"

  resource_group_name = "rg-example"
  location            = "eastus"
  name                = "app-example-backup"
  service_plan_id     = azurerm_service_plan.example.id

  os_type = "Linux"

  site_config = {
    application_stack = {
      dotnet_version = "8.0"
    }
  }

  backup = {
    name                = "daily-backup"
    storage_account_url = "https://storageaccount.blob.core.windows.net/backups?sv=..."

    schedule = {
      frequency_interval    = 1
      frequency_unit        = "Day"
      retention_period_days = 30
    }
  }
}
```

### Web App with Logging

```hcl
module "webapp_logs" {
  source = "./WebApp"

  resource_group_name = "rg-example"
  location            = "eastus"
  name                = "app-example-logs"
  service_plan_id     = azurerm_service_plan.example.id

  os_type = "Linux"

  site_config = {
    application_stack = {
      java_version = "17"
    }
  }

  logs = {
    detailed_error_messages = true
    failed_request_tracing  = true

    http_logs = {
      file_system = {
        retention_in_days = 7
        retention_in_mb   = 50
      }
    }

    application_logs = {
      file_system_level = "Information"
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create the Web App resource | `bool` | `true` | no |
| resource_group_name | The name of the resource group in which to create the Web App | `string` | n/a | yes |
| location | The Azure region where the Web App will be created | `string` | n/a | yes |
| name | The name of the Web App. If provided, overrides generated name | `string` | `null` | no |
| name_prefix | Prefix for the generated Web App name | `string` | `"app"` | no |
| workload | The workload name for the Web App | `string` | `null` | no |
| environment | The environment name (e.g., dev, staging, prod) | `string` | `null` | no |
| instance | The instance identifier for the Web App | `string` | `null` | no |
| tags | A map of tags to assign to the resource | `map(string)` | `{}` | no |
| service_plan_id | The ID of the App Service Plan to host the Web App | `string` | n/a | yes |
| os_type | The operating system type for the Web App (Linux or Windows) | `string` | `"Linux"` | no |
| https_only | Whether the Web App should only accept HTTPS requests | `bool` | `true` | no |
| public_network_access_enabled | Whether public network access is allowed for the Web App | `bool` | `true` | no |
| virtual_network_subnet_id | The ID of the subnet for VNet integration | `string` | `null` | no |
| site_config | The site configuration for the Web App | `object` | `{}` | no |
| app_settings | A map of app settings for the Web App | `map(string)` | `{}` | no |
| connection_strings | A list of connection strings for the Web App | `list(object)` | `[]` | no |
| identity | The managed identity configuration for the Web App | `object` | `null` | no |
| auth_settings_v2 | The authentication settings v2 for the Web App | `object` | `null` | no |
| sticky_settings | The sticky settings for deployment slots | `object` | `null` | no |
| backup | The backup configuration for the Web App | `object` | `null` | no |
| logs | The logging configuration for the Web App | `object` | `null` | no |
| storage_account | The storage account configuration for mounted storage | `list(object)` | `[]` | no |

### site_config Object

| Name | Description | Type | Default |
|------|-------------|------|---------|
| always_on | Whether the Web App should always be running | `bool` | `true` |
| ftps_state | State of FTP/FTPS service (AllAllowed, FtpsOnly, Disabled) | `string` | `"Disabled"` |
| http2_enabled | Whether HTTP/2 is enabled | `bool` | `true` |
| minimum_tls_version | Minimum TLS version | `string` | `"1.2"` |
| app_command_line | App command line to launch | `string` | `null` |
| health_check_path | Path for health check | `string` | `null` |
| worker_count | Number of workers | `number` | `null` |
| application_stack | Application stack configuration | `object` | `null` |

### application_stack Object (Linux)

| Name | Description | Type |
|------|-------------|------|
| docker_image | Docker image name | `string` |
| docker_image_tag | Docker image tag | `string` |
| dotnet_version | .NET version | `string` |
| java_version | Java version | `string` |
| node_version | Node.js version | `string` |
| php_version | PHP version | `string` |
| python_version | Python version | `string` |
| ruby_version | Ruby version | `string` |
| go_version | Go version | `string` |

### application_stack Object (Windows)

| Name | Description | Type |
|------|-------------|------|
| dotnet_version | .NET version | `string` |
| java_version | Java version | `string` |
| node_version | Node.js version | `string` |
| php_version | PHP version | `string` |
| python_version | Python version | `string` |
| current_stack | Current application stack | `string` |

### identity Object

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| type | Identity type (SystemAssigned, UserAssigned, SystemAssigned, UserAssigned) | `string` | yes |
| identity_ids | List of User Assigned Identity IDs | `list(string)` | no |

### connection_strings Object

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| name | Connection string name | `string` | yes |
| type | Connection string type (SQLServer, SQLAzure, MySQL, PostgreSQL, Custom) | `string` | yes |
| value | Connection string value | `string` | yes |

### backup Object

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| name | Backup name | `string` | yes |
| storage_account_url | Storage account URL with SAS token | `string` | yes |
| enabled | Whether backup is enabled | `bool` | no |
| schedule | Backup schedule configuration | `object` | yes |

### backup.schedule Object

| Name | Description | Type | Default |
|------|-------------|------|---------|
| frequency_interval | Backup frequency interval | `number` | n/a |
| frequency_unit | Backup frequency unit (Day, Hour) | `string` | n/a |
| retention_period_days | Backup retention in days | `number` | `30` |
| start_time | Backup start time | `string` | `null` |
| keep_at_least_one_backup | Keep at least one backup | `bool` | `true` |

### logs Object

| Name | Description | Type | Default |
|------|-------------|------|---------|
| detailed_error_messages | Enable detailed error messages | `bool` | `false` |
| failed_request_tracing | Enable failed request tracing | `bool` | `false` |
| http_logs | HTTP logs configuration | `object` | `null` |
| application_logs | Application logs configuration | `object` | `null` |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Web App |
| name | The name of the Web App |
| default_hostname | The default hostname of the Web App |
| outbound_ip_addresses | A comma-separated list of outbound IP addresses |
| possible_outbound_ip_addresses | A comma-separated list of possible outbound IP addresses |
| identity | The managed identity of the Web App (principal_id, tenant_id) |

## Dependencies

This module has the following dependencies that must exist before creating the Web App:

1. **Resource Group** - The resource group specified in `resource_group_name` must exist
2. **App Service Plan** - The App Service Plan specified in `service_plan_id` must exist
3. **Virtual Network Subnet** (optional) - If VNet integration is required, the subnet specified in `virtual_network_subnet_id` must exist

## License

MIT License

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
| [azurerm_linux_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_windows_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | A map of app settings for the Web App | `map(string)` | `{}` | no |
| <a name="input_auth_settings_v2"></a> [auth\_settings\_v2](#input\_auth\_settings\_v2) | The authentication settings v2 for the Web App | <pre>object({<br/>    auth_enabled                            = optional(bool, true)<br/>    runtime_version                         = optional(string, "~1")<br/>    config_file_path                        = optional(string)<br/>    require_authentication                  = optional(bool, true)<br/>    unauthenticated_action                  = optional(string, "RedirectToLoginPage")<br/>    default_provider                        = optional(string)<br/>    excluded_paths                          = optional(list(string))<br/>    require_https                           = optional(bool, true)<br/>    http_route_api_prefix                   = optional(string, "/.auth")<br/>    forward_proxy_convention                = optional(string)<br/>    forward_proxy_custom_host_header_name   = optional(string)<br/>    forward_proxy_custom_scheme_header_name = optional(string)<br/>    login = optional(object({<br/>      logout_endpoint                   = optional(string)<br/>      token_store_enabled               = optional(bool)<br/>      token_refresh_extension_time      = optional(number)<br/>      token_store_path                  = optional(string)<br/>      token_store_sas_setting_name      = optional(string)<br/>      preserve_url_fragments_for_logins = optional(bool)<br/>      allowed_external_redirect_urls    = optional(list(string))<br/>      cookie_expiration_convention      = optional(string)<br/>      cookie_expiration_time            = optional(string)<br/>      validate_nonce                    = optional(bool)<br/>      nonce_expiration_time             = optional(string)<br/>    }))<br/>    active_directory_v2 = optional(object({<br/>      client_id                            = string<br/>      tenant_auth_endpoint                 = optional(string)<br/>      client_secret_setting_name           = optional(string)<br/>      client_secret_certificate_thumbprint = optional(string)<br/>      jwt_allowed_groups                   = optional(list(string))<br/>      jwt_allowed_client_applications      = optional(list(string))<br/>      www_authentication_disabled          = optional(bool)<br/>      allowed_groups                       = optional(list(string))<br/>      allowed_identities                   = optional(list(string))<br/>      allowed_applications                 = optional(list(string))<br/>      login_parameters                     = optional(map(string))<br/>      allowed_audiences                    = optional(list(string))<br/>    }))<br/>    azure_static_web_app_v2 = optional(object({<br/>      client_id = string<br/>    }))<br/>    custom_oidc_v2 = optional(list(object({<br/>      name                          = string<br/>      client_id                     = string<br/>      openid_configuration_endpoint = string<br/>      name_claim_type               = optional(string)<br/>      scopes                        = optional(list(string))<br/>      client_credential_method      = optional(string)<br/>      client_secret_setting_name    = optional(string)<br/>      authorisation_endpoint        = optional(string)<br/>      token_endpoint                = optional(string)<br/>      issuer_endpoint               = optional(string)<br/>      certification_uri             = optional(string)<br/>    })))<br/>    facebook_v2 = optional(object({<br/>      app_id                  = string<br/>      app_secret_setting_name = string<br/>      graph_api_version       = optional(string)<br/>      login_scopes            = optional(list(string))<br/>    }))<br/>    github_v2 = optional(object({<br/>      client_id                  = string<br/>      client_secret_setting_name = string<br/>      login_scopes               = optional(list(string))<br/>    }))<br/>    google_v2 = optional(object({<br/>      client_id                  = string<br/>      client_secret_setting_name = string<br/>      allowed_audiences          = optional(list(string))<br/>      login_scopes               = optional(list(string))<br/>    }))<br/>    microsoft_v2 = optional(object({<br/>      client_id                  = string<br/>      client_secret_setting_name = string<br/>      allowed_audiences          = optional(list(string))<br/>      login_scopes               = optional(list(string))<br/>    }))<br/>    twitter_v2 = optional(object({<br/>      consumer_key                 = string<br/>      consumer_secret_setting_name = string<br/>    }))<br/>    apple_v2 = optional(object({<br/>      client_id                  = string<br/>      client_secret_setting_name = string<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_backup"></a> [backup](#input\_backup) | The backup configuration for the Web App | <pre>object({<br/>    name                = string<br/>    storage_account_url = string<br/>    enabled             = optional(bool, true)<br/>    schedule = object({<br/>      frequency_interval       = number<br/>      frequency_unit           = string<br/>      retention_period_days    = optional(number, 30)<br/>      start_time               = optional(string)<br/>      keep_at_least_one_backup = optional(bool, true)<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_connection_strings"></a> [connection\_strings](#input\_connection\_strings) | A list of connection strings for the Web App | <pre>list(object({<br/>    name  = string<br/>    type  = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Web App resource | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (e.g., dev, staging, prod) | `string` | `null` | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | Whether the Web App should only accept HTTPS requests | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | The managed identity configuration for the Web App | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance identifier for the Web App | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Web App will be created | `string` | n/a | yes |
| <a name="input_logs"></a> [logs](#input\_logs) | The logging configuration for the Web App | <pre>object({<br/>    detailed_error_messages = optional(bool, false)<br/>    failed_request_tracing  = optional(bool, false)<br/>    http_logs = optional(object({<br/>      azure_blob_storage = optional(object({<br/>        sas_url           = string<br/>        retention_in_days = optional(number, 7)<br/>      }))<br/>      file_system = optional(object({<br/>        retention_in_days = optional(number, 7)<br/>        retention_in_mb   = optional(number, 35)<br/>      }))<br/>    }))<br/>    application_logs = optional(object({<br/>      file_system_level = optional(string, "Warning")<br/>      azure_blob_storage = optional(object({<br/>        level             = string<br/>        sas_url           = string<br/>        retention_in_days = optional(number, 7)<br/>      }))<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Web App. If provided, overrides generated name | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the generated Web App name | `string` | `"app"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The operating system type for the Web App | `string` | `"Linux"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for the Web App | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Web App | `string` | n/a | yes |
| <a name="input_service_plan_id"></a> [service\_plan\_id](#input\_service\_plan\_id) | The ID of the App Service Plan to host the Web App | `string` | n/a | yes |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | The site configuration for the Web App | <pre>object({<br/>    always_on             = optional(bool, true)<br/>    ftps_state            = optional(string, "Disabled")<br/>    http2_enabled         = optional(bool, true)<br/>    minimum_tls_version   = optional(string, "1.2")<br/>    app_command_line      = optional(string)<br/>    health_check_path     = optional(string)<br/>    worker_count          = optional(number)<br/>    application_stack = optional(object({<br/>      # Linux application stack<br/>      docker_image       = optional(string)<br/>      docker_image_tag   = optional(string)<br/>      dotnet_version     = optional(string)<br/>      java_version       = optional(string)<br/>      node_version       = optional(string)<br/>      php_version        = optional(string)<br/>      python_version     = optional(string)<br/>      ruby_version       = optional(string)<br/>      go_version         = optional(string)<br/>      # Windows application stack<br/>      current_stack = optional(string)<br/>    }))<br/>  })</pre> | `{}` | no |
| <a name="input_sticky_settings"></a> [sticky\_settings](#input\_sticky\_settings) | The sticky settings for deployment slots | <pre>object({<br/>    app_setting_names       = optional(list(string))<br/>    connection_string_names = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | The storage account configuration for mounted storage | <pre>list(object({<br/>    name         = string<br/>    type         = string<br/>    account_name = string<br/>    share_name   = string<br/>    access_key   = string<br/>    mount_path   = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_virtual_network_subnet_id"></a> [virtual\_network\_subnet\_id](#input\_virtual\_network\_subnet\_id) | The ID of the subnet for VNet integration | `string` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name for the Web App | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_default_hostname"></a> [default\_hostname](#output\_default\_hostname) | The default hostname of the Web App |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Web App |
| <a name="output_identity"></a> [identity](#output\_identity) | The managed identity of the Web App |
| <a name="output_name"></a> [name](#output\_name) | The name of the Web App |
| <a name="output_outbound_ip_addresses"></a> [outbound\_ip\_addresses](#output\_outbound\_ip\_addresses) | A comma-separated list of outbound IP addresses for the Web App |
| <a name="output_possible_outbound_ip_addresses"></a> [possible\_outbound\_ip\_addresses](#output\_possible\_outbound\_ip\_addresses) | A comma-separated list of possible outbound IP addresses for the Web App |
<!-- END_TF_DOCS -->