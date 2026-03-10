# Azure Data Lake Storage Gen2 Filesystem - Terraform Module

## Overview

This Terraform module creates and manages an Azure Data Lake Storage Gen2 Filesystem and optional directory paths within it. It supports Access Control Lists (ACLs), custom properties, and ownership configuration.

**Important:** The target Storage Account **must** have Hierarchical Namespace (HNS) enabled (`is_hns_enabled = true`) for Data Lake Gen2 features to work.

## Usage

### Basic Example

```hcl
module "datalake_filesystem" {
  source = "../../Storage/DataLakeGen2"

  storage_account_id = azurerm_storage_account.example.id

  name_prefix = "dlfs"
  workload    = "analytics"
  environment = "dev"

  tags = {
    project = "data-platform"
  }
}
```

### Complete Example with Paths and ACLs

```hcl
module "datalake_filesystem" {
  source = "../../Storage/DataLakeGen2"

  storage_account_id = azurerm_storage_account.example.id

  name        = "raw-data"
  properties  = {
    "purpose" = "raw-ingestion"
  }

  ace = [
    {
      scope       = "access"
      type        = "user"
      permissions = "rwx"
    },
    {
      scope       = "access"
      type        = "group"
      permissions = "r-x"
    },
    {
      scope       = "access"
      type        = "other"
      permissions = "---"
    }
  ]

  paths = {
    landing = {
      path     = "landing"
      resource = "directory"
      ace = [
        {
          scope       = "access"
          type        = "user"
          permissions = "rwx"
        },
        {
          scope       = "access"
          type        = "other"
          permissions = "---"
        }
      ]
    }
    processed = {
      path     = "processed"
      resource = "directory"
    }
    archived = {
      path     = "archived"
      resource = "directory"
    }
  }

  tags = {
    project = "data-platform"
    team    = "data-engineering"
  }
}
```

### Disable Resource Creation

```hcl
module "datalake_filesystem" {
  source = "../../Storage/DataLakeGen2"

  create             = false
  storage_account_id = "placeholder"
}
```

## Dependencies

This module has the following external dependencies:

| Dependency | Description |
|---|---|
| **Storage Account** | A Storage Account with `is_hns_enabled = true` must exist before deploying this module. Pass its ID via `storage_account_id`. |
| **Azure AD Objects** | (Optional) AAD object IDs are required for `owner`, `group`, and ACL entries of type `user` or `group`. |

## Requirements

| Name | Version |
|---|---|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0, < 5.0.0 |

## Resources

| Name | Type |
|---|---|
| [azurerm_storage_data_lake_gen2_filesystem.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_filesystem) | resource |
| [azurerm_storage_data_lake_gen2_path.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_path) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|---|---|---|---|---|
| `create` | Controls whether to create the Data Lake Gen2 Filesystem. | `bool` | `true` | no |
| `storage_account_id` | The ID of the Storage Account (must have HNS enabled). | `string` | n/a | **yes** |
| `name` | Explicit name for the Filesystem. Overrides generated name. | `string` | `null` | no |
| `name_prefix` | Prefix for the generated Filesystem name. | `string` | `"dlfs"` | no |
| `name_suffix` | Suffix for the generated Filesystem name. | `string` | `""` | no |
| `workload` | Workload or application name for naming convention. | `string` | `"shared"` | no |
| `environment` | Environment name for naming convention. | `string` | `"dev"` | no |
| `instance` | Instance identifier for naming convention. | `string` | `"001"` | no |
| `properties` | Map of custom properties for the Filesystem. | `map(string)` | `{}` | no |
| `owner` | AAD object ID of the Filesystem owner. | `string` | `null` | no |
| `group` | AAD object ID of the Filesystem owning group. | `string` | `null` | no |
| `ace` | List of Access Control Entries for the Filesystem. | `list(object)` | `[]` | no |
| `paths` | Map of directories to create within the Filesystem. | `map(object)` | `{}` | no |
| `tags` | Map of tags to assign to resources. | `map(string)` | `{}` | no |

### `ace` Object Attributes

| Name | Description | Type | Default | Required |
|---|---|---|---|---|
| `scope` | Scope of the ACE (`access` or `default`). | `string` | `"access"` | no |
| `type` | Type of ACE (`user`, `group`, `mask`, `other`). | `string` | n/a | **yes** |
| `id` | AAD object ID. Required when type is `user` or `group`. | `string` | `null` | no |
| `permissions` | Permission string (e.g., `rwx`, `r-x`, `---`). | `string` | n/a | **yes** |

### `paths` Object Attributes

| Name | Description | Type | Default | Required |
|---|---|---|---|---|
| `path` | The path to create within the filesystem. | `string` | n/a | **yes** |
| `resource` | The type of resource (`directory`). | `string` | `"directory"` | no |
| `owner` | AAD object ID of the path owner. | `string` | `null` | no |
| `group` | AAD object ID of the path owning group. | `string` | `null` | no |
| `ace` | List of ACL entries for this path. | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|---|---|
| `id` | The ID of the Data Lake Gen2 Filesystem. |
| `name` | The name of the Data Lake Gen2 Filesystem. |
| `path_ids` | Map of path keys to their resource IDs. |

## Notes

- Filesystem names must be between 3 and 63 characters, contain only lowercase letters, numbers, and hyphens, and must start with a letter or number.
- The Storage Account must have Hierarchical Namespace enabled (`is_hns_enabled = true`).
- ACL entries define POSIX-like permissions for the filesystem and its paths.
- The `owner` and `group` fields accept Azure Active Directory object IDs.
