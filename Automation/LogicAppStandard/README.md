# Azure Logic App Standard Module

Terraform module to create and manage **Azure Logic Apps Standard (single-tenant)** for enterprise workflow automation with VNet integration.

## Features

- Single-tenant Logic Apps with dedicated App Service Plan
- VNet integration for secure network connectivity
- System Assigned and User Assigned Managed Identities
- IP restrictions for workflows and SCM
- Extension bundle configuration
- Scale out settings (pre-warmed instances, elastic scaling)
- HTTPS-only, TLS 1.2 by default
- Conditional creation with `create = true/false`

## Usage - Basic

```hcl
module "logic_app_standard" {
  source = "path/to/Automation/LogicAppStandard"

  resource_group_name        = "rg-automation-dev-001"
  location                   = "westeurope"
  name                       = "logic-std-orders-dev-001"
  app_service_plan_id        = azurerm_service_plan.logic.id
  storage_account_name       = azurerm_storage_account.logic.name
  storage_account_access_key = azurerm_storage_account.logic.primary_access_key

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}
```

## Usage - With VNet Integration

```hcl
module "logic_app_standard" {
  source = "path/to/Automation/LogicAppStandard"

  resource_group_name        = "rg-automation-prod-001"
  location                   = "westeurope"
  name                       = "logic-std-api-prod-001"
  app_service_plan_id        = azurerm_service_plan.logic.id
  storage_account_name       = azurerm_storage_account.logic.name
  storage_account_access_key = azurerm_storage_account.logic.primary_access_key

  # VNet Integration
  virtual_network_subnet_id = azurerm_subnet.logic_integration.id

  identity = {
    type = "SystemAssigned"
  }

  site_config = {
    vnet_route_all_enabled = true
    always_on              = true
  }

  public_network_access_enabled = false

  tags = {
    Environment = "Production"
  }
}
```

## Usage - With IP Restrictions

```hcl
module "logic_app_standard" {
  source = "path/to/Automation/LogicAppStandard"

  resource_group_name        = "rg-automation-prod-001"
  location                   = "westeurope"
  name                       = "logic-std-secure-prod-001"
  app_service_plan_id        = azurerm_service_plan.logic.id
  storage_account_name       = azurerm_storage_account.logic.name
  storage_account_access_key = azurerm_storage_account.logic.primary_access_key

  identity = {
    type = "SystemAssigned"
  }

  site_config = {
    always_on   = true
    http2_enabled = true

    ip_restriction = [
      {
        name       = "AllowVNet"
        action     = "Allow"
        virtual_network_subnet_id = azurerm_subnet.app.id
        priority   = 100
      },
      {
        name       = "AllowOffice"
        action     = "Allow"
        ip_address = "203.0.113.0/24"
        priority   = 200
      }
    ]

    scm_ip_restriction = [
      {
        name       = "AllowDevOps"
        action     = "Allow"
        service_tag = "AzureDevOps"
        priority   = 100
      }
    ]
  }

  tags = {
    Environment = "Production"
  }
}
```

## Usage - With Scaling Configuration

```hcl
module "logic_app_standard" {
  source = "path/to/Automation/LogicAppStandard"

  resource_group_name        = "rg-automation-prod-001"
  location                   = "westeurope"
  name                       = "logic-std-highload-prod-001"
  app_service_plan_id        = azurerm_service_plan.logic.id
  storage_account_name       = azurerm_storage_account.logic.name
  storage_account_access_key = azurerm_storage_account.logic.primary_access_key

  identity = {
    type = "SystemAssigned"
  }

  site_config = {
    always_on                        = true
    pre_warmed_instance_count        = 2
    elastic_instance_minimum         = 1
    app_scale_limit                  = 10
    runtime_scale_monitoring_enabled = true
  }

  tags = {
    Environment = "Production"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create the Logic App | `bool` | `true` | no |
| `resource_group_name` | Name of the Resource Group | `string` | - | yes |
| `location` | Azure Region | `string` | - | yes |
| `name` | Explicit name | `string` | `null` | no |
| `app_service_plan_id` | App Service Plan ID (WS1/WS2/WS3) | `string` | - | yes |
| `storage_account_name` | Storage Account name | `string` | - | yes |
| `storage_account_access_key` | Storage Account access key | `string` | - | yes |
| `storage_account_share_name` | File Share name | `string` | `null` | no |
| `enabled` | Whether enabled | `bool` | `true` | no |
| `version` | Runtime version | `string` | `"~4"` | no |
| `https_only` | HTTPS only | `bool` | `true` | no |
| `public_network_access_enabled` | Public access | `bool` | `true` | no |
| `virtual_network_subnet_id` | VNet integration subnet | `string` | `null` | no |
| `site_config` | Site configuration | `object` | `{}` | no |
| `app_settings` | App settings | `map(string)` | `{}` | no |
| `identity` | Identity configuration | `object` | `null` | no |
| `tags` | Tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the Logic App Standard |
| `name` | The name |
| `default_hostname` | Default hostname |
| `outbound_ip_addresses` | Outbound IP addresses |
| `possible_outbound_ip_addresses` | Possible outbound IPs |
| `site_credential` | Site credentials (sensitive) |
| `custom_domain_verification_id` | Custom domain verification ID |
| `identity` | Identity block |
| `principal_id` | Principal ID |
| `tenant_id` | Tenant ID |
| `kind` | Resource kind |

## Dependencies

- **Resource Group** must exist
- **App Service Plan** with WS1, WS2, or WS3 SKU must exist
- **Storage Account** must exist
- **Subnet** must exist for VNet integration

## Notes

- Requires Workflow Standard (WS1/WS2/WS3) App Service Plan SKU
- Standard tier provides VNet integration, private endpoints
- Workflows are defined in code and deployed separately
- More predictable pricing vs Consumption (pay per App Service Plan)

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
| [azurerm_logic_app_standard.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_standard) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_app_service_plan_id"></a> [app\_service\_plan\_id](#input\_app\_service\_plan\_id) | (Required) The ID of the App Service Plan. DEPENDENCY: Must be WS1, WS2, or WS3 SKU for Logic Apps Standard. | `string` | n/a | yes |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | (Optional) Map of application settings. | `map(string)` | `{}` | no |
| <a name="input_bundle_version"></a> [bundle\_version](#input\_bundle\_version) | (Optional) The version range for extension bundle. Default: [1.*, 2.0.0). | `string` | `"[1.*, 2.0.0)"` | no |
| <a name="input_client_affinity_enabled"></a> [client\_affinity\_enabled](#input\_client\_affinity\_enabled) | (Optional) Whether client affinity is enabled. Default: false. | `bool` | `false` | no |
| <a name="input_client_certificate_mode"></a> [client\_certificate\_mode](#input\_client\_certificate\_mode) | (Optional) Client certificate mode. Values: Required, Optional, OptionalInteractiveUser. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Logic App Standard. | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Whether the Logic App is enabled. Default: true. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) Environment name (e.g., dev, staging, prod). | `string` | `"dev"` | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | (Optional) Whether HTTPS only is enabled. Default: true. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Identity configuration.<br/>- type: (Required) Type of identity. Values: SystemAssigned, UserAssigned, SystemAssigned, UserAssigned.<br/>- identity\_ids: (Optional) List of User Assigned Identity IDs. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number for the naming convention. | `string` | `"001"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Logic App should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name of the Logic App Standard. If not provided, a name will be generated. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the generated name. Default: 'logic'. | `string` | `"logic"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether public network access is enabled. Default: true. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group. DEPENDENCY: Resource Group must exist. | `string` | n/a | yes |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | (Optional) Site configuration block.<br/>- always\_on: (Optional) Whether always on is enabled. Default: false.<br/>- app\_scale\_limit: (Optional) Maximum number of workers.<br/>- ftps\_state: (Optional) FTPS state. Values: AllAllowed, FtpsOnly, Disabled.<br/>- health\_check\_path: (Optional) Health check path.<br/>- http2\_enabled: (Optional) Whether HTTP2 is enabled.<br/>- minimum\_tls\_version: (Optional) Minimum TLS version. Default: 1.2.<br/>- pre\_warmed\_instance\_count: (Optional) Pre-warmed instances.<br/>- runtime\_scale\_monitoring\_enabled: (Optional) Enable runtime scale monitoring.<br/>- use\_32\_bit\_worker: (Optional) Use 32-bit worker. Default: true.<br/>- vnet\_route\_all\_enabled: (Optional) Route all traffic through VNet.<br/>- websockets\_enabled: (Optional) Enable WebSockets.<br/>- elastic\_instance\_minimum: (Optional) Minimum elastic instances.<br/>- ip\_restriction: (Optional) List of IP restrictions.<br/>- scm\_ip\_restriction: (Optional) List of SCM IP restrictions. | <pre>object({<br/>    always_on                      = optional(bool, false)<br/>    app_scale_limit                = optional(number, null)<br/>    ftps_state                     = optional(string, "Disabled")<br/>    health_check_path              = optional(string, null)<br/>    http2_enabled                  = optional(bool, true)<br/>    minimum_tls_version            = optional(string, "1.2")<br/>    pre_warmed_instance_count      = optional(number, null)<br/>    runtime_scale_monitoring_enabled = optional(bool, false)<br/>    use_32_bit_worker              = optional(bool, false)<br/>    vnet_route_all_enabled         = optional(bool, false)<br/>    websockets_enabled             = optional(bool, false)<br/>    elastic_instance_minimum       = optional(number, null)<br/>    dotnet_framework_version       = optional(string, "v6.0")<br/>    ip_restriction = optional(list(object({<br/>      name                      = optional(string, null)<br/>      action                    = optional(string, "Allow")<br/>      ip_address                = optional(string, null)<br/>      virtual_network_subnet_id = optional(string, null)<br/>      service_tag               = optional(string, null)<br/>      priority                  = optional(number, 100)<br/>    })), [])<br/>    scm_ip_restriction = optional(list(object({<br/>      name                      = optional(string, null)<br/>      action                    = optional(string, "Allow")<br/>      ip_address                = optional(string, null)<br/>      virtual_network_subnet_id = optional(string, null)<br/>      service_tag               = optional(string, null)<br/>      priority                  = optional(number, 100)<br/>    })), [])<br/>  })</pre> | `{}` | no |
| <a name="input_storage_account_access_key"></a> [storage\_account\_access\_key](#input\_storage\_account\_access\_key) | (Required) The access key for the Storage Account. | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | (Required) The name of the Storage Account for the Logic App. DEPENDENCY: Storage Account must exist. | `string` | n/a | yes |
| <a name="input_storage_account_share_name"></a> [storage\_account\_share\_name](#input\_storage\_account\_share\_name) | (Optional) The name of the File Share in the Storage Account. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_use_extension_bundle"></a> [use\_extension\_bundle](#input\_use\_extension\_bundle) | (Optional) Whether to use extension bundle. Default: true. | `bool` | `true` | no |
| <a name="input_version"></a> [version](#input\_version) | (Optional) The runtime version for the Logic App. Default: ~4. | `string` | `"~4"` | no |
| <a name="input_virtual_network_subnet_id"></a> [virtual\_network\_subnet\_id](#input\_virtual\_network\_subnet\_id) | (Optional) The ID of the subnet for VNet integration. DEPENDENCY: Subnet must exist. | `string` | `null` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) Workload name for the naming convention. | `string` | `"std"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_custom_domain_verification_id"></a> [custom\_domain\_verification\_id](#output\_custom\_domain\_verification\_id) | The custom domain verification ID. |
| <a name="output_default_hostname"></a> [default\_hostname](#output\_default\_hostname) | The default hostname of the Logic App Standard. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Logic App Standard. |
| <a name="output_identity"></a> [identity](#output\_identity) | The identity block of the Logic App Standard. |
| <a name="output_kind"></a> [kind](#output\_kind) | The kind of the Logic App Standard. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Logic App Standard. |
| <a name="output_outbound_ip_addresses"></a> [outbound\_ip\_addresses](#output\_outbound\_ip\_addresses) | Comma-separated list of outbound IP addresses. |
| <a name="output_possible_outbound_ip_addresses"></a> [possible\_outbound\_ip\_addresses](#output\_possible\_outbound\_ip\_addresses) | Comma-separated list of possible outbound IP addresses. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID of the System Assigned Identity. |
| <a name="output_site_credential"></a> [site\_credential](#output\_site\_credential) | The site credentials for publishing. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The Tenant ID of the System Assigned Identity. |
<!-- END_TF_DOCS -->