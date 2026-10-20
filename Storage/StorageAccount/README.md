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
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | (Optional) Defines the access tier for BlobStorage, FileStorage, and StorageV2 accounts. Valid options are Hot and Cool. | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | (Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage, and StorageV2. | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | (Optional) Defines the type of replication to use for this Storage Account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS, and RAGZRS. | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | (Optional) Defines the Tier to use for this Storage Account. Valid options are Standard and Premium. | `string` | `"Standard"` | no |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | (Optional) Allow or disallow nested items within this Account to opt into being public. Default is false for security. | `bool` | `false` | no |
| <a name="input_blob_properties"></a> [blob\_properties](#input\_blob\_properties) | (Optional) Blob properties configuration for the Storage Account.<br/><br/>Attributes:<br/>  - versioning\_enabled: Is versioning enabled?<br/>  - change\_feed\_enabled: Is the blob service properties for change feed events enabled?<br/>  - change\_feed\_retention\_in\_days: The duration of change feed events retention in days (1-146000).<br/>  - last\_access\_time\_enabled: Is the last access time based tracking enabled?<br/>  - delete\_retention\_policy: Specifies the number of days that the blob should be retained (1-365).<br/>  - container\_delete\_retention\_policy: Specifies the number of days that the container should be retained (1-365).<br/>  - cors\_rule: CORS rules for the blob service. | <pre>object({<br/>    versioning_enabled            = optional(bool, true)<br/>    change_feed_enabled           = optional(bool, true)<br/>    change_feed_retention_in_days = optional(number, 30)<br/>    last_access_time_enabled      = optional(bool, false)<br/>    delete_retention_policy = optional(object({<br/>      days = optional(number, 7)<br/>    }), null)<br/>    container_delete_retention_policy = optional(object({<br/>      days = optional(number, 7)<br/>    }), null)<br/>    cors_rule = optional(list(object({<br/>      allowed_headers    = list(string)<br/>      allowed_methods    = list(string)<br/>      allowed_origins    = list(string)<br/>      exposed_headers    = list(string)<br/>      max_age_in_seconds = number<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Storage Account. Set to false to disable resource creation without removing module code. | `bool` | `true` | no |
| <a name="input_cross_tenant_replication_enabled"></a> [cross\_tenant\_replication\_enabled](#input\_cross\_tenant\_replication\_enabled) | (Optional) Should cross-tenant replication be enabled? Default is false for security. | `bool` | `false` | no |
| <a name="input_custom_domain"></a> [custom\_domain](#input\_custom\_domain) | (Optional) Custom domain configuration for the Storage Account.<br/><br/>Attributes:<br/>  - name: The Custom Domain Name to use for the Storage Account.<br/>  - use\_subdomain: Should the indirect CNAME validation method be used? | <pre>object({<br/>    name          = string<br/>    use_subdomain = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | (Optional) Customer Managed Key configuration for the Storage Account.<br/>DEPENDENCY: Key Vault Key and User Assigned Identity must exist before referencing.<br/><br/>Attributes:<br/>  - key\_vault\_key\_id: The ID of the Key Vault Key.<br/>  - user\_assigned\_identity\_id: The ID of a User Assigned Identity. | <pre>object({<br/>    key_vault_key_id          = string<br/>    user_assigned_identity_id = string<br/>  })</pre> | `null` | no |
| <a name="input_default_to_oauth_authentication"></a> [default\_to\_oauth\_authentication](#input\_default\_to\_oauth\_authentication) | (Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. | `bool` | `true` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | (Optional) Diagnostic settings configuration for the Storage Account.<br/>DEPENDENCY: Log Analytics Workspace, Storage Account, or Event Hub must exist before referencing.<br/><br/>Attributes:<br/>  - name: Name of the diagnostic setting.<br/>  - log\_analytics\_workspace\_id: Resource ID of the Log Analytics Workspace.<br/>  - storage\_account\_id: Resource ID of the Storage Account for archival.<br/>  - eventhub\_authorization\_rule\_id: Authorization rule ID for Event Hub.<br/>  - eventhub\_name: Name of the Event Hub.<br/>  - log\_categories: List of log categories to enable.<br/>  - metric\_categories: List of metric categories to enable. | <pre>object({<br/>    name                           = optional(string, "diag-storageaccount")<br/>    log_analytics_workspace_id     = optional(string, null)<br/>    storage_account_id             = optional(string, null)<br/>    eventhub_authorization_rule_id = optional(string, null)<br/>    eventhub_name                  = optional(string, null)<br/>    log_categories                 = optional(list(string), [])<br/>    metric_categories              = optional(list(string), ["Transaction", "Capacity"])<br/>  })</pre> | `null` | no |
| <a name="input_enable_https_traffic_only"></a> [enable\_https\_traffic\_only](#input\_enable\_https\_traffic\_only) | (Optional) Forces HTTPS traffic only. Recommended for security. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) The environment name (e.g., dev, staging, prod), used for naming convention. | `string` | `"dev"` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Managed identity configuration for the Storage Account.<br/><br/>Attributes:<br/>  - type: Specifies the type of Managed Identity. Possible values are SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned.<br/>  - identity\_ids: A list of User Assigned Managed Identity IDs to be assigned. | <pre>object({<br/>    type         = string<br/>    identity_ids = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_immutability_policy"></a> [immutability\_policy](#input\_immutability\_policy) | (Optional) Immutability policy configuration for the Storage Account.<br/><br/>Attributes:<br/>  - allow\_protected\_append\_writes: When enabled, new blocks can be written to an append blob while maintaining immutability.<br/>  - period\_since\_creation\_in\_days: The immutability period for the blobs in the container since the policy creation, in days.<br/>  - state: Defines the mode of the policy. Valid options are Disabled, Unlocked, and Locked. | <pre>object({<br/>    allow_protected_append_writes = optional(bool, true)<br/>    period_since_creation_in_days = number<br/>    state                         = optional(string, "Disabled")<br/>  })</pre> | `null` | no |
| <a name="input_infrastructure_encryption_enabled"></a> [infrastructure\_encryption\_enabled](#input\_infrastructure\_encryption\_enabled) | (Optional) Is infrastructure encryption enabled? Provides an additional layer of encryption. Default is true for security. | `bool` | `true` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number or identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled) | (Optional) Is Hierarchical Namespace enabled? This is used for Azure Data Lake Storage Gen2. | `bool` | `false` | no |
| <a name="input_large_file_share_enabled"></a> [large\_file\_share\_enabled](#input\_large\_file\_share\_enabled) | (Optional) Is Large File Share Enabled? | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure region where the Storage Account will be deployed.<br/>DEPENDENCY: Should match the Resource Group location for optimal performance. | `string` | n/a | yes |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | (Optional) The minimum supported TLS version for the Storage Account. Default is TLS1\_2 for security. | `string` | `"TLS1_2"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the Storage Account. If provided, overrides name\_prefix/workload/environment/instance logic. Must be 3-24 characters, lowercase letters and numbers only. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix to prepend to the generated Storage Account name. Used when 'name' is not provided. Default is 'st'. | `string` | `"st"` | no |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | (Optional) Network rules configuration for the Storage Account.<br/><br/>Attributes:<br/>  - default\_action: Specifies the default action of allow or deny when no other rules match. Valid options are Allow and Deny.<br/>  - bypass: Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.<br/>  - ip\_rules: List of public IP or IP ranges in CIDR format.<br/>  - virtual\_network\_subnet\_ids: List of virtual network subnet IDs to secure the Storage Account.<br/>  - private\_link\_access: List of private link access rules. | <pre>object({<br/>    default_action             = optional(string, "Deny")<br/>    bypass                     = optional(set(string), ["AzureServices"])<br/>    ip_rules                   = optional(list(string), [])<br/>    virtual_network_subnet_ids = optional(list(string), [])<br/>    private_link_access = optional(list(object({<br/>      endpoint_resource_id = string<br/>      endpoint_tenant_id   = optional(string, null)<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_nfsv3_enabled"></a> [nfsv3\_enabled](#input\_nfsv3\_enabled) | (Optional) Is NFSv3 protocol enabled? Requires is\_hns\_enabled set to true and account\_tier set to Premium. | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether the public network access is enabled. Default is false for security. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group where the Storage Account will be created.<br/>DEPENDENCY: Resource Group must exist before creating the Storage Account. | `string` | n/a | yes |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | (Optional) Indicates whether the Storage Account permits requests to be authorized with the account access key via Shared Key. | `bool` | `true` | no |
| <a name="input_static_website"></a> [static\_website](#input\_static\_website) | (Optional) Static website configuration for the Storage Account.<br/><br/>Attributes:<br/>  - index\_document: The webpage that Azure Storage serves for requests to the root of a website or any subfolder.<br/>  - error\_404\_document: The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file. | <pre>object({<br/>    index_document     = optional(string, "index.html")<br/>    error_404_document = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the Storage Account. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) The workload or application name, used for naming convention. | `string` | `"shared"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_diagnostic_settings_id"></a> [diagnostic\_settings\_id](#output\_diagnostic\_settings\_id) | The ID of the diagnostic settings (if created). |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Storage Account. |
| <a name="output_identity"></a> [identity](#output\_identity) | The managed identity block of the Storage Account, containing principal\_id and tenant\_id. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Storage Account. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for the Storage Account. |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | The endpoint URL for blob storage in the primary location. |
| <a name="output_primary_blob_host"></a> [primary\_blob\_host](#output\_primary\_blob\_host) | The hostname with port for blob storage in the primary location. |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The primary connection string for the Storage Account. |
| <a name="output_primary_dfs_endpoint"></a> [primary\_dfs\_endpoint](#output\_primary\_dfs\_endpoint) | The endpoint URL for DFS storage in the primary location (Data Lake). |
| <a name="output_primary_file_endpoint"></a> [primary\_file\_endpoint](#output\_primary\_file\_endpoint) | The endpoint URL for file storage in the primary location. |
| <a name="output_primary_queue_endpoint"></a> [primary\_queue\_endpoint](#output\_primary\_queue\_endpoint) | The endpoint URL for queue storage in the primary location. |
| <a name="output_primary_table_endpoint"></a> [primary\_table\_endpoint](#output\_primary\_table\_endpoint) | The endpoint URL for table storage in the primary location. |
<!-- END_TF_DOCS -->