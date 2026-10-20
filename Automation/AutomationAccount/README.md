# Azure Automation Account Module

Terraform module to create and manage **Azure Automation Account** with support for managed identities, customer-managed keys, private endpoints, and diagnostic settings.

## Features

- Basic and Free SKU support
- System Assigned and User Assigned Managed Identities
- Customer Managed Key (CMK) encryption
- Private Endpoints for secure connectivity
- Diagnostic settings integration (Log Analytics, Storage, Event Hub)
- Local authentication control
- Public network access control
- Conditional creation with `create = true/false`

## Usage - Basic

```hcl
module "automation_account" {
  source = "path/to/Automation/AutomationAccount"

  resource_group_name = "rg-automation-dev-001"
  location            = "westeurope"

  tags = {
    Environment = "Development"
  }
}
```

## Usage - With System Assigned Identity

```hcl
module "automation_account" {
  source = "path/to/Automation/AutomationAccount"

  resource_group_name = "rg-automation-dev-001"
  location            = "westeurope"
  name                = "aa-runbooks-dev-001"

  identity = {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}
```

## Usage - With User Assigned Identity and CMK

```hcl
module "automation_account" {
  source = "path/to/Automation/AutomationAccount"

  resource_group_name = "rg-automation-prod-001"
  location            = "westeurope"
  name                = "aa-runbooks-prod-001"

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.automation.id]
  }

  encryption = {
    key_vault_key_id          = azurerm_key_vault_key.automation.id
    user_assigned_identity_id = azurerm_user_assigned_identity.automation.id
  }

  public_network_access_enabled = false
  local_authentication_enabled  = false

  tags = {
    Environment = "Production"
  }
}
```

## Usage - With Private Endpoints

```hcl
module "automation_account" {
  source = "path/to/Automation/AutomationAccount"

  resource_group_name = "rg-automation-prod-001"
  location            = "westeurope"
  name                = "aa-runbooks-prod-001"

  public_network_access_enabled = false

  identity = {
    type = "SystemAssigned"
  }

  private_endpoints = [
    {
      name              = "pe-aa-webhook"
      subnet_id         = azurerm_subnet.private_endpoints.id
      subresource_names = ["Webhook"]
      private_dns_zone_ids = [
        azurerm_private_dns_zone.automation_webhook.id
      ]
    },
    {
      name              = "pe-aa-dsc"
      subnet_id         = azurerm_subnet.private_endpoints.id
      subresource_names = ["DSCAndHybridWorker"]
      private_dns_zone_ids = [
        azurerm_private_dns_zone.automation_dsc.id
      ]
    }
  ]

  tags = {
    Environment = "Production"
  }
}
```

## Usage - With Diagnostic Settings

```hcl
module "automation_account" {
  source = "path/to/Automation/AutomationAccount"

  resource_group_name = "rg-automation-prod-001"
  location            = "westeurope"
  name                = "aa-runbooks-prod-001"

  identity = {
    type = "SystemAssigned"
  }

  diagnostic_settings = {
    name                       = "diag-aa-runbooks"
    log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
    enabled_log_categories     = ["JobLogs", "JobStreams", "DscNodeStatus", "AuditEvent"]
    metric_categories          = ["AllMetrics"]
  }

  tags = {
    Environment = "Production"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `create` | Controls whether to create the resource | `bool` | `true` | no |
| `resource_group_name` | Name of the Resource Group | `string` | - | yes |
| `location` | Azure Region | `string` | - | yes |
| `name` | Explicit name for the Automation Account | `string` | `null` | no |
| `name_prefix` | Prefix for generated name | `string` | `"aa"` | no |
| `workload` | Workload name for naming convention | `string` | `"automation"` | no |
| `environment` | Environment name | `string` | `"dev"` | no |
| `instance` | Instance number | `string` | `"001"` | no |
| `sku_name` | SKU: Free or Basic | `string` | `"Basic"` | no |
| `local_authentication_enabled` | Enable local authentication | `bool` | `true` | no |
| `public_network_access_enabled` | Enable public network access | `bool` | `true` | no |
| `identity` | Managed identity configuration | `object` | `null` | no |
| `encryption` | CMK encryption configuration | `object` | `null` | no |
| `private_endpoints` | List of private endpoints | `list(object)` | `[]` | no |
| `diagnostic_settings` | Diagnostic settings configuration | `object` | `null` | no |
| `tags` | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the Automation Account |
| `name` | The name of the Automation Account |
| `dsc_server_endpoint` | The DSC Server Endpoint URL |
| `dsc_primary_access_key` | The Primary Access Key for DSC (sensitive) |
| `dsc_secondary_access_key` | The Secondary Access Key for DSC (sensitive) |
| `hybrid_service_url` | The URL of the Hybrid Worker Service |
| `identity` | The identity block |
| `principal_id` | The Principal ID of System Assigned Identity |
| `tenant_id` | The Tenant ID of System Assigned Identity |
| `private_endpoint_ids` | Map of Private Endpoint names to IDs |
| `private_endpoint_ips` | Map of Private Endpoint names to private IPs |

## Dependencies

- **Resource Group** must exist before creating the Automation Account
- **User Assigned Identity** must exist if using UserAssigned identity type
- **Key Vault Key** must exist if using CMK encryption
- **Subnet** must exist for Private Endpoints
- **Private DNS Zones** should exist for Private Endpoint DNS integration
- **Log Analytics Workspace** / **Storage Account** / **Event Hub** must exist for diagnostic settings
