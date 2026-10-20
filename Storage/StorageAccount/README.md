# Azure Storage Account Terraform Module

This Terraform module creates and manages an Azure Storage Account with support for advanced features including network rules, blob properties, managed identities, customer-managed keys, immutability policies, static websites, and diagnostic settings.

## Features

- Configurable naming convention or explicit naming
- Secure defaults (public access disabled, TLS 1.2, infrastructure encryption enabled, OAuth authentication)
- Network rules with private link access support
- Blob versioning, change feed, and retention policies
- Managed Identity (System and/or User Assigned)
- Customer Managed Key encryption
- Immutability policies for compliance
- Static website hosting
- Custom domain support
- Diagnostic settings integration
- Conditional creation using `create` flag

## Usage

### Basic Example

```hcl
module "storage_account" {
  source = "../../Storage/StorageAccount"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name = "stmyappdev001"

  tags = {
    Environment = "Development"
    Project     = "MyApp"
  }
}
```

### With Network Rules and Blob Properties

```hcl
module "storage_account" {
  source = "../../Storage/StorageAccount"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name                        = "stmyappprod001"
  account_replication_type    = "GRS"
  public_network_access_enabled = true

  network_rules = {
    default_action             = "Deny"
    bypass                     = ["AzureServices", "Logging", "Metrics"]
    ip_rules                   = ["203.0.113.0/24"]
    virtual_network_subnet_ids = [azurerm_subnet.example.id]
  }

  blob_properties = {
    versioning_enabled  = true
    change_feed_enabled = true
    delete_retention_policy = {
      days = 30
    }
    container_delete_retention_policy = {
      days = 30
    }
  }

  tags = {
    Environment = "Production"
  }
}
```

### With Managed Identity and Customer Managed Key

```hcl
module "storage_account" {
  source = "../../Storage/StorageAccount"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name = "stmyappsecure001"

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.example.id]
  }

  customer_managed_key = {
    key_vault_key_id          = azurerm_key_vault_key.example.id
    user_assigned_identity_id = azurerm_user_assigned_identity.example.id
  }

  tags = {
    Environment = "Production"
    Security    = "CMK-Enabled"
  }
}
```

### With Static Website

```hcl
module "storage_account" {
  source = "../../Storage/StorageAccount"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name                          = "stwebsitedev001"
  account_kind                  = "StorageV2"
  public_network_access_enabled = true

  static_website = {
    index_document     = "index.html"
    error_404_document = "404.html"
  }

  tags = {
    Environment = "Development"
    Purpose     = "StaticWebsite"
  }
}
```

### Data Lake Storage (HNS Enabled)

```hcl
module "storage_account" {
  source = "../../Storage/StorageAccount"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  name           = "stdatalakedev001"
  is_hns_enabled = true

  tags = {
    Environment = "Development"
    Purpose     = "DataLake"
  }
}
```

### Disable Module Creation

```hcl
module "storage_account" {
  source = "../../Storage/StorageAccount"

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
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the Storage Account | `bool` | `true` | no |
| resource_group_name | The name of the Resource Group (DEPENDENCY) | `string` | n/a | yes |
| location | The Azure region for deployment (DEPENDENCY) | `string` | n/a | yes |
| name | Explicit name for the Storage Account (3-24 chars, lowercase/numbers only) | `string` | `null` | no |
| name\_prefix | Prefix for generated name | `string` | `"st"` | no |
| workload | Workload or application name for naming | `string` | `"shared"` | no |
| environment | Environment name for naming | `string` | `"dev"` | no |
| instance | Instance identifier for naming | `string` | `"001"` | no |
| account\_tier | Storage Account tier (Standard/Premium) | `string` | `"Standard"` | no |
| account\_replication\_type | Replication type (LRS/GRS/RAGRS/ZRS/GZRS/RAGZRS) | `string` | `"LRS"` | no |
| account\_kind | Account kind (BlobStorage/BlockBlobStorage/FileStorage/Storage/StorageV2) | `string` | `"StorageV2"` | no |
| access\_tier | Access tier (Hot/Cool) | `string` | `"Hot"` | no |
| min\_tls\_version | Minimum TLS version | `string` | `"TLS1_2"` | no |
| enable\_https\_traffic\_only | Forces HTTPS traffic only | `bool` | `true` | no |
| allow\_nested\_items\_to\_be\_public | Allow nested items to be public | `bool` | `false` | no |
| shared\_access\_key\_enabled | Allow Shared Key authorization | `bool` | `true` | no |
| is\_hns\_enabled | Enable Hierarchical Namespace (Data Lake) | `bool` | `false` | no |
| nfsv3\_enabled | Enable NFSv3 protocol | `bool` | `false` | no |
| large\_file\_share\_enabled | Enable large file shares | `bool` | `false` | no |
| infrastructure\_encryption\_enabled | Enable infrastructure encryption | `bool` | `true` | no |
| public\_network\_access\_enabled | Enable public network access | `bool` | `false` | no |
| default\_to\_oauth\_authentication | Default to OAuth authentication in portal | `bool` | `true` | no |
| cross\_tenant\_replication\_enabled | Enable cross-tenant replication | `bool` | `false` | no |
| network\_rules | Network rules configuration | `object` | `null` | no |
| blob\_properties | Blob properties configuration | `object` | `null` | no |
| identity | Managed identity configuration | `object` | `null` | no |
| customer\_managed\_key | Customer managed key configuration (DEPENDENCY) | `object` | `null` | no |
| immutability\_policy | Immutability policy configuration | `object` | `null` | no |
| static\_website | Static website configuration | `object` | `null` | no |
| custom\_domain | Custom domain configuration | `object` | `null` | no |
| tags | Map of tags to assign | `map(string)` | `{}` | no |
| diagnostic\_settings | Diagnostic settings configuration (DEPENDENCY) | `object` | `null` | no |

## Outputs

| Name | Description | Sensitive |
|------|-------------|:---------:|
| id | The ID of the Storage Account | no |
| name | The name of the Storage Account | no |
| primary\_access\_key | The primary access key | yes |
| primary\_connection\_string | The primary connection string | yes |
| primary\_blob\_endpoint | The primary blob endpoint URL | no |
| primary\_blob\_host | The primary blob hostname with port | no |
| primary\_file\_endpoint | The primary file endpoint URL | no |
| primary\_queue\_endpoint | The primary queue endpoint URL | no |
| primary\_table\_endpoint | The primary table endpoint URL | no |
| primary\_dfs\_endpoint | The primary DFS endpoint URL (Data Lake) | no |
| identity | The managed identity block (principal\_id, tenant\_id) | no |
| diagnostic\_settings\_id | The ID of the diagnostic settings | no |

## Security Defaults

This module follows security best practices with the following defaults:

- **Public network access disabled** (`public_network_access_enabled = false`)
- **Nested items cannot be public** (`allow_nested_items_to_be_public = false`)
- **Infrastructure encryption enabled** (`infrastructure_encryption_enabled = true`)
- **TLS 1.2 minimum** (`min_tls_version = "TLS1_2"`)
- **HTTPS only** (`enable_https_traffic_only = true`)
- **OAuth authentication by default** (`default_to_oauth_authentication = true`)
- **Cross-tenant replication disabled** (`cross_tenant_replication_enabled = false`)

## Dependencies

Resources that must exist before using this module:

- **Resource Group** - Must exist before creating the Storage Account
- **Subnet(s)** - If using network rules with virtual network subnet IDs
- **Key Vault Key** - If using customer managed key encryption
- **User Assigned Identity** - If using UserAssigned identity or customer managed key
- **Log Analytics Workspace / Event Hub** - If using diagnostic settings
