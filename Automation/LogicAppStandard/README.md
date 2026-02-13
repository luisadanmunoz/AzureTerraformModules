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
