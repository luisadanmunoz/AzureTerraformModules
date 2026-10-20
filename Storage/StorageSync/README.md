# Azure Storage Sync Terraform Module

This Terraform module creates and manages an Azure Storage Sync Service (Azure File Sync) with support for Sync Groups and Cloud Endpoints. Azure File Sync enables centralizing your organization's file shares in Azure Files while keeping the flexibility, performance, and compatibility of an on-premises file server.

## Features

- Configurable naming convention or explicit naming
- Incoming traffic policy configuration
- Multiple Sync Groups support
- Cloud Endpoints for Azure File Share synchronization
- Conditional creation using `create` flag
- Default tagging with terraform-managed and module tags

## Usage

### Basic Example

```hcl
module "storage_sync" {
  source = "../../Storage/StorageSync"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name = "ss-myapp-dev-001"

  tags = {
    Environment = "Development"
    Project     = "MyApp"
  }
}
```

### With Sync Group

```hcl
module "storage_sync" {
  source = "../../Storage/StorageSync"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name = "ss-filesync-prod-001"

  sync_groups = {
    "documents" = {
      name = "sync-group-documents"
    }
    "backups" = {
      name = "sync-group-backups"
    }
  }

  tags = {
    Environment = "Production"
    Project     = "FileSync"
  }
}
```

### With Sync Group and Cloud Endpoint

```hcl
module "storage_sync" {
  source = "../../Storage/StorageSync"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name = "ss-filesync-prod-001"

  sync_groups = {
    "documents" = {
      name = "sync-group-documents"
    }
  }

  cloud_endpoints = {
    "docs-endpoint" = {
      sync_group_key     = "documents"
      file_share_name    = "documents-share"
      storage_account_id = azurerm_storage_account.example.id
    }
  }

  tags = {
    Environment = "Production"
    Project     = "FileSync"
  }
}
```

### With Virtual Network Restriction

```hcl
module "storage_sync" {
  source = "../../Storage/StorageSync"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name                    = "ss-secure-prod-001"
  incoming_traffic_policy = "AllowVirtualNetworksOnly"

  sync_groups = {
    "secure-sync" = {
      name = "sync-group-secure"
    }
  }

  tags = {
    Environment = "Production"
    Security    = "Restricted"
  }
}
```

### Using Naming Convention

```hcl
module "storage_sync" {
  source = "../../Storage/StorageSync"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Uses naming convention: ss-analytics-prod-001
  name_prefix = "ss"
  workload    = "analytics"
  environment = "prod"
  instance    = "001"

  tags = {
    Environment = "Production"
  }
}
```

### Disable Module Creation

```hcl
module "storage_sync" {
  source = "../../Storage/StorageSync"

  create = false

  resource_group_name = "rg-placeholder"
  location            = "westeurope"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.70.0, < 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_sync.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_sync) | resource |
| [azurerm_storage_sync_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_sync_group) | resource |
| [azurerm_storage_sync_cloud_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_sync_cloud_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the Storage Sync resources | `bool` | `true` | no |
| resource\_group\_name | The name of the Resource Group (DEPENDENCY) | `string` | n/a | yes |
| location | The Azure region for deployment (DEPENDENCY) | `string` | n/a | yes |
| name | Explicit name for the Storage Sync | `string` | `null` | no |
| name\_prefix | Prefix for generated name | `string` | `"ss"` | no |
| workload | Workload or application name for naming | `string` | `"shared"` | no |
| environment | Environment name for naming | `string` | `"dev"` | no |
| instance | Instance identifier for naming | `string` | `"001"` | no |
| incoming\_traffic\_policy | Incoming traffic policy (AllowAllTraffic/AllowVirtualNetworksOnly) | `string` | `"AllowAllTraffic"` | no |
| sync\_groups | Map of Sync Groups to create | `map(object)` | `{}` | no |
| cloud\_endpoints | Map of Cloud Endpoints to create (DEPENDENCY) | `map(object)` | `{}` | no |
| tags | Map of tags to assign | `map(string)` | `{}` | no |

### sync_groups Object Attributes

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| name | The name of the Sync Group | `string` | yes |

### cloud_endpoints Object Attributes

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| sync\_group\_key | Key from sync_groups map to associate with | `string` | yes |
| file\_share\_name | Name of the Azure File Share to sync | `string` | yes |
| storage\_account\_id | ID of the Storage Account containing the File Share | `string` | yes |
| storage\_account\_tenant\_id | Tenant ID of the Storage Account | `string` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Storage Sync Service |
| name | The name of the Storage Sync Service |
| sync\_group\_ids | Map of Sync Group keys to their IDs |
| cloud\_endpoint\_ids | Map of Cloud Endpoint keys to their IDs |

## Dependencies

Resources that must exist before using this module:

- **Resource Group** - Must exist before creating the Storage Sync Service
- **Storage Account** - If using cloud endpoints, the Storage Account must exist
- **File Share** - If using cloud endpoints, the File Share must exist in the Storage Account

## Architecture

Azure File Sync consists of the following components:

1. **Storage Sync Service** - The top-level Azure resource for Azure File Sync
2. **Sync Group** - Defines the sync topology for a set of files
3. **Cloud Endpoint** - An Azure File Share that serves as the cloud endpoint
4. **Server Endpoint** - A specific path on a registered server (configured separately)

This module manages the Storage Sync Service, Sync Groups, and Cloud Endpoints. Server Endpoints require the Azure File Sync agent installed on Windows Server and are typically configured outside of this module.

## Notes

- Each Sync Group can have only one Cloud Endpoint
- Server Endpoints require the Azure File Sync agent and are registered separately
- Cloud Endpoints can only be created after the Storage Sync Service and Sync Group exist
- The Storage Account must be in the same region as the Storage Sync Service for optimal performance
