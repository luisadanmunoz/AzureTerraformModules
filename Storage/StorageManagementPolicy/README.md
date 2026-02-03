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
