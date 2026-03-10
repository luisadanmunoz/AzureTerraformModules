# Azure Network Watcher Terraform Module

This module creates an Azure Network Watcher and optionally configures NSG Flow Logs with Traffic Analytics support.

## Features

- Network Watcher creation with standard naming convention
- NSG Flow Log configuration with retention policies
- Traffic Analytics integration with Log Analytics workspace
- Flow Log versioning (v1 / v2)
- Conditional resource creation via `create` flag

## Dependencies

| Resource | Required | Description |
|----------|----------|-------------|
| Resource Group | **Yes** | Must exist |
| Storage Account | Per Flow Log | Required for each flow log entry |
| Network Security Group | Per Flow Log | NSG to attach the flow log to |
| Log Analytics Workspace | Optional | Required when Traffic Analytics is enabled |

## Usage

### Basic Network Watcher

```hcl
module "network_watcher" {
  source = "../../Networking/NetworkWatcher"

  resource_group_name = "rg-network-prod-001"
  location            = "westeurope"

  name = "nw-shared-prod-001"

  tags = {
    Environment = "Production"
  }
}
```

### Network Watcher with Flow Logs and Traffic Analytics

```hcl
module "network_watcher" {
  source = "../../Networking/NetworkWatcher"

  resource_group_name = "rg-network-prod-001"
  location            = "westeurope"

  name = "nw-shared-prod-001"

  flow_logs = [
    {
      name                      = "fl-web-nsg"
      network_security_group_id = "/subscriptions/.../networkSecurityGroups/nsg-web"
      storage_account_id        = "/subscriptions/.../storageAccounts/stflowlogs001"
      enabled                   = true
      retention_policy_enabled  = true
      retention_policy_days     = 90
      version                   = 2

      traffic_analytics_enabled               = true
      traffic_analytics_workspace_id          = "workspace-guid"
      traffic_analytics_workspace_region      = "westeurope"
      traffic_analytics_workspace_resource_id = "/subscriptions/.../workspaces/law-prod"
      traffic_analytics_interval_in_minutes   = 10
    }
  ]

  tags = {
    Environment = "Production"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls resource creation | `bool` | `true` | no |
| resource_group_name | Resource Group name | `string` | n/a | **yes** |
| location | Azure region | `string` | n/a | **yes** |
| name | Explicit Network Watcher name | `string` | auto | no |
| name_prefix | Prefix for generated name | `string` | `"nw"` | no |
| workload | Workload name | `string` | `"shared"` | no |
| environment | Environment name | `string` | `"prod"` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| flow_logs | List of NSG Flow Log configurations | `list(object)` | `[]` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

### flow_logs Object Attributes

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Flow log resource name | `string` | n/a | **yes** |
| network_security_group_id | NSG resource ID | `string` | n/a | **yes** |
| storage_account_id | Storage Account ID for logs | `string` | n/a | **yes** |
| enabled | Enable the flow log | `bool` | `true` | no |
| retention_policy_enabled | Enable retention policy | `bool` | `true` | no |
| retention_policy_days | Retention in days | `number` | `90` | no |
| version | Flow log version (1 or 2) | `number` | `2` | no |
| traffic_analytics_enabled | Enable Traffic Analytics | `bool` | `false` | no |
| traffic_analytics_workspace_id | Log Analytics workspace GUID | `string` | `null` | no |
| traffic_analytics_workspace_region | Workspace region | `string` | `null` | no |
| traffic_analytics_workspace_resource_id | Workspace resource ID | `string` | `null` | no |
| traffic_analytics_interval_in_minutes | Processing interval (10 or 60) | `number` | `60` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Network Watcher ID |
| name | Network Watcher name |

## Important Notes

- Azure automatically creates a Network Watcher per region in the `NetworkWatcherRG` resource group. If one already exists, you may need to import it or set `create = false`.
- Only one Network Watcher can exist per region per subscription.
- Flow Logs require a Storage Account in the same region as the NSG.
- Traffic Analytics requires a Log Analytics workspace and increases cost based on the processing interval.
- Flow Log version 2 provides additional fields including bytes and packets per flow.
