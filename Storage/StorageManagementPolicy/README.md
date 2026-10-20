# Azure Storage Management Policy (Lifecycle Management) Module

Reusable Terraform module to create and manage lifecycle management policies for Azure Storage Accounts.
Storage Management Policies allow you to automate the tiering and deletion of blob data based on
last-modified or creation timestamps, helping optimize storage costs.

## Features

- Automatic blob tiering between Hot, Cool, and Archive access tiers
- Automatic deletion of blobs after a specified number of days
- Snapshot lifecycle management (tiering and deletion)
- Version lifecycle management (tiering and deletion)
- Blob index tag filtering for granular rule targeting
- Prefix-based filtering to scope rules to specific containers or blob paths
- Conditional creation using the `create` flag

## Usage

### Basic - Tiering and Deletion

```hcl
module "lifecycle_policy" {
  source = "../../Storage/StorageManagementPolicy"

  storage_account_id = azurerm_storage_account.example.id

  rules = [
    {
      name    = "move-to-cool-and-archive"
      enabled = true
      filters = {
        blob_types   = ["blockBlob"]
        prefix_match = ["container1/logs"]
      }
      actions = {
        base_blob = {
          tier_to_cool_after_days    = 30
          tier_to_archive_after_days = 90
          delete_after_days          = 365
        }
      }
    }
  ]

  tags = {
    Environment = "production"
  }
}
```

### Snapshot and Version Lifecycle

```hcl
module "lifecycle_policy" {
  source = "../../Storage/StorageManagementPolicy"

  storage_account_id = azurerm_storage_account.example.id

  rules = [
    {
      name    = "manage-snapshots-and-versions"
      enabled = true
      filters = {
        blob_types = ["blockBlob"]
      }
      actions = {
        base_blob = {
          tier_to_cool_after_days              = 30
          auto_tier_to_hot_from_cool_enabled   = true
        }
        snapshot = {
          change_tier_to_cool_after_days    = 7
          change_tier_to_archive_after_days = 30
          delete_after_days                 = 90
        }
        version = {
          change_tier_to_cool_after_days    = 7
          change_tier_to_archive_after_days = 30
          delete_after_days                 = 90
        }
      }
    }
  ]
}
```

### Multiple Rules with Blob Index Tags

```hcl
module "lifecycle_policy" {
  source = "../../Storage/StorageManagementPolicy"

  storage_account_id = azurerm_storage_account.example.id

  rules = [
    {
      name    = "archive-old-logs"
      enabled = true
      filters = {
        blob_types   = ["blockBlob"]
        prefix_match = ["logs/"]
      }
      actions = {
        base_blob = {
          tier_to_archive_after_days = 60
          delete_after_days          = 730
        }
      }
    },
    {
      name    = "delete-temporary-blobs"
      enabled = true
      filters = {
        blob_types = ["blockBlob"]
        match_blob_index_tag = [
          {
            name  = "retention"
            value = "temporary"
          }
        ]
      }
      actions = {
        base_blob = {
          delete_after_days = 7
        }
      }
    },
    {
      name    = "tier-append-blobs"
      enabled = true
      filters = {
        blob_types = ["appendBlob"]
      }
      actions = {
        base_blob = {
          delete_after_days = 180
        }
      }
    }
  ]
}
```

### Conditional Creation (Disabled)

```hcl
module "lifecycle_policy" {
  source = "../../Storage/StorageManagementPolicy"

  create             = false
  storage_account_id = azurerm_storage_account.example.id

  rules = []
}
```

## Requirements

| Name      | Version           |
|-----------|-------------------|
| terraform | >= 1.3.0          |
| azurerm   | >= 3.70.0, < 5.0.0 |

## Providers

| Name    | Version           |
|---------|-------------------|
| azurerm | >= 3.70.0, < 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_management_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `create` | Controls whether to create the storage management policy. | `bool` | `true` | no |
| `tags` | Additional tags to apply to resources that support tagging. | `map(string)` | `{}` | no |
| `storage_account_id` | The ID of the Storage Account. **DEPENDENCY**: Storage Account must exist. | `string` | n/a | **yes** |
| `rules` | List of lifecycle management rules. See [Rules](#rules-variable-structure) section below. | `list(object)` | `[]` | no |

### Rules Variable Structure

Each rule object supports:

| Attribute | Description | Type | Default | Required |
|-----------|-------------|------|---------|----------|
| `name` | Unique name for the rule. | `string` | n/a | **yes** |
| `enabled` | Whether the rule is enabled. | `bool` | `true` | no |
| `filters` | Filters to scope the rule. | `object` | n/a | **yes** |
| `actions` | Actions to apply to matched blobs. | `object` | n/a | **yes** |

#### Filters

| Attribute | Description | Type | Default | Required |
|-----------|-------------|------|---------|----------|
| `blob_types` | Blob types to match (e.g., `blockBlob`, `appendBlob`). | `list(string)` | n/a | **yes** |
| `prefix_match` | Blob name prefixes to match. | `list(string)` | `[]` | no |
| `match_blob_index_tag` | List of blob index tag filters. | `list(object)` | `[]` | no |

#### Actions - base_blob

| Attribute | Description | Type | Default |
|-----------|-------------|------|---------|
| `tier_to_cool_after_days` | Days since modification to move to Cool tier. | `number` | `null` |
| `tier_to_archive_after_days` | Days since modification to move to Archive tier. | `number` | `null` |
| `delete_after_days` | Days since modification to delete blob. | `number` | `null` |
| `auto_tier_to_hot_from_cool_enabled` | Auto-tier from Cool to Hot on access. | `bool` | `null` |

#### Actions - snapshot

| Attribute | Description | Type | Default |
|-----------|-------------|------|---------|
| `change_tier_to_cool_after_days` | Days since creation to move to Cool tier. | `number` | `null` |
| `change_tier_to_archive_after_days` | Days since creation to move to Archive tier. | `number` | `null` |
| `delete_after_days` | Days since creation to delete snapshot. | `number` | `null` |

#### Actions - version

| Attribute | Description | Type | Default |
|-----------|-------------|------|---------|
| `change_tier_to_cool_after_days` | Days since creation to move to Cool tier. | `number` | `null` |
| `change_tier_to_archive_after_days` | Days since creation to move to Archive tier. | `number` | `null` |
| `delete_after_days` | Days since creation to delete version. | `number` | `null` |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the Storage Management Policy. |

## Dependencies

This module requires the following resources to exist before deployment:

- **Storage Account** (`storage_account_id`): The Storage Account must be created before applying a management policy. The account must support blob storage (StorageV2 or BlobStorage account kind).

## Notes

- Only one management policy can exist per Storage Account.
- Archive tiering is only available for `blockBlob` types in StorageV2 and BlobStorage accounts.
- `auto_tier_to_hot_from_cool_enabled` requires `last_access_time_enabled` to be set on the Storage Account blob properties.
- Snapshot and version actions require blob versioning and/or snapshots to be enabled on the Storage Account.
- The `match_blob_index_tag` filter requires the Blob Index feature to be available in your region.

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
| [azurerm_storage_management_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the storage management policy. | `bool` | `true` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | (Optional) List of lifecycle management rules. Each rule defines filters and actions<br/>for managing blob data lifecycle (tiering, deletion, snapshots, versions).<br/>- name: (Required) The name of the rule. Must be unique within the policy.<br/>- enabled: (Optional) Whether the rule is enabled. Defaults to true.<br/>- filters: (Required) Filters to limit the rule to a subset of blobs.<br/>  - blob\_types: (Required) List of blob types to apply the rule to (e.g., ["blockBlob", "appendBlob"]).<br/>  - prefix\_match: (Optional) List of blob name prefixes to match.<br/>  - match\_blob\_index\_tag: (Optional) List of blob index tag filters.<br/>    - name: (Required) The tag name.<br/>    - operation: (Optional) The comparison operator. Defaults to "==".<br/>    - value: (Required) The tag value.<br/>- actions: (Required) Actions to apply to filtered blobs.<br/>  - base\_blob: (Optional) Actions for base blobs.<br/>    - tier\_to\_cool\_after\_days: (Optional) Move to cool storage after N days since modification.<br/>    - tier\_to\_archive\_after\_days: (Optional) Move to archive storage after N days since modification.<br/>    - delete\_after\_days: (Optional) Delete blob after N days since modification.<br/>    - auto\_tier\_to\_hot\_from\_cool\_enabled: (Optional) Auto-tier blobs from cool back to hot on access.<br/>  - snapshot: (Optional) Actions for blob snapshots.<br/>    - change\_tier\_to\_cool\_after\_days: (Optional) Move snapshot to cool after N days since creation.<br/>    - change\_tier\_to\_archive\_after\_days: (Optional) Move snapshot to archive after N days since creation.<br/>    - delete\_after\_days: (Optional) Delete snapshot after N days since creation.<br/>  - version: (Optional) Actions for blob versions.<br/>    - change\_tier\_to\_cool\_after\_days: (Optional) Move version to cool after N days since creation.<br/>    - change\_tier\_to\_archive\_after\_days: (Optional) Move version to archive after N days since creation.<br/>    - delete\_after\_days: (Optional) Delete version after N days since creation. | <pre>list(object({<br/>    name    = string<br/>    enabled = optional(bool, true)<br/>    filters = object({<br/>      blob_types   = list(string)<br/>      prefix_match = optional(list(string), [])<br/>      match_blob_index_tag = optional(list(object({<br/>        name      = string<br/>        operation = optional(string, "==")<br/>        value     = string<br/>      })), [])<br/>    })<br/>    actions = object({<br/>      base_blob = optional(object({<br/>        tier_to_cool_after_days              = optional(number, null)<br/>        tier_to_archive_after_days           = optional(number, null)<br/>        delete_after_days                    = optional(number, null)<br/>        auto_tier_to_hot_from_cool_enabled   = optional(bool, null)<br/>      }), null)<br/>      snapshot = optional(object({<br/>        change_tier_to_cool_after_days    = optional(number, null)<br/>        change_tier_to_archive_after_days = optional(number, null)<br/>        delete_after_days                 = optional(number, null)<br/>      }), null)<br/>      version = optional(object({<br/>        change_tier_to_cool_after_days    = optional(number, null)<br/>        change_tier_to_archive_after_days = optional(number, null)<br/>        delete_after_days                 = optional(number, null)<br/>      }), null)<br/>    })<br/>  }))</pre> | `[]` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | (Required) The ID of the Storage Account where the management policy will be applied.<br/>DEPENDENCY: Storage Account must exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources that support tagging. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Storage Management Policy. |
<!-- END_TF_DOCS -->