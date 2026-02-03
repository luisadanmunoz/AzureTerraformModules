# Azure Storage Table Terraform Module

This module creates one or more Azure Storage Tables within an existing Storage Account, with optional access control list (ACL) configuration for shared access policies.

## Features

- Create a single Storage Table with generated or explicit naming
- Create multiple Storage Tables via a `tables` map using `for_each`
- Access control list (ACL) configuration with signed identifiers and access policies
- Flexible naming convention with prefix/suffix support
- `create` flag to enable/disable resource creation
- Default tags for resource tracking (`terraform-managed`, `module`)

## Dependencies

Before using this module, ensure the following resources exist:

| Resource | Required | Description |
|----------|----------|-------------|
| Storage Account | **Yes** | The Storage Account where tables will be created |

## Usage

### Basic Example - Single Table

```hcl
module "storage_table" {
  source = "../../Storage/StorageTable"

  # DEPENDENCY: Storage Account must exist
  storage_account_name = "mystorageaccount001"

  name = "myapptable"
}
```

### With Naming Convention

```hcl
module "storage_table" {
  source = "../../Storage/StorageTable"

  storage_account_name = "mystorageaccount001"

  # Uses naming convention: tableshareddev001
  name_prefix = "table"
  workload    = "shared"
  environment = "dev"
  instance    = "001"
}
```

### Single Table with ACL

```hcl
module "storage_table" {
  source = "../../Storage/StorageTable"

  storage_account_name = "mystorageaccount001"
  name                 = "orderstable"

  acl = [
    {
      id = "readpolicy"
      access_policy = {
        start       = "2025-01-01T00:00:00Z"
        expiry      = "2026-01-01T00:00:00Z"
        permissions = "r"
      }
    },
    {
      id = "fullaccess"
      access_policy = {
        start       = "2025-01-01T00:00:00Z"
        expiry      = "2026-01-01T00:00:00Z"
        permissions = "raud"
      }
    }
  ]
}
```

### Multiple Tables

```hcl
module "storage_tables" {
  source = "../../Storage/StorageTable"

  storage_account_name = "mystorageaccount001"

  tables = {
    orders = {
      acl = []
    }
    customers = {
      acl = [
        {
          id = "readonly"
          access_policy = {
            start       = "2025-01-01T00:00:00Z"
            expiry      = "2026-01-01T00:00:00Z"
            permissions = "r"
          }
        }
      ]
    }
    inventory = {
      acl = []
    }
  }
}
```

### Disabled Module

```hcl
module "storage_table" {
  source = "../../Storage/StorageTable"

  create               = false
  storage_account_name = "mystorageaccount001"
  name                 = "disabledtable"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the Storage Table(s) | `bool` | `true` | no |
| storage_account_name | Name of the Storage Account (DEPENDENCY: must exist) | `string` | n/a | **yes** |
| name | Explicit name for the single Storage Table | `string` | `null` | no |
| name_prefix | Prefix for generated name | `string` | `"table"` | no |
| name_suffix | Suffix for generated name | `string` | `""` | no |
| workload | Workload name for naming convention | `string` | `"shared"` | no |
| environment | Environment name for naming convention | `string` | `"dev"` | no |
| instance | Instance identifier | `string` | `"001"` | no |
| tables | Map of tables to create via for_each (overrides single-table mode) | `map(object({...}))` | `{}` | no |
| acl | List of ACL entries for the single Storage Table | `list(object({...}))` | `[]` | no |
| tags | Map of tags to assign to resources | `map(string)` | `{}` | no |

### ACL Object Structure

```hcl
acl = [
  {
    id = "policy-name"        # Required: unique identifier (1-64 chars)
    access_policy = {          # Optional: access policy block
      start       = "ISO8601" # Start time in UTC
      expiry      = "ISO8601" # Expiry time in UTC
      permissions = "raud"    # Combination of: r(ead), a(dd), u(pdate), d(elete)
    }
  }
]
```

### Tables Map Structure

```hcl
tables = {
  "tablename" = {
    acl = [...]  # Optional: same ACL structure as above
  }
}
```

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Storage Table (single table mode) |
| name | The name of the Storage Table (single table mode) |
| table_ids | Map of table names to their IDs (multiple tables mode) |
| table_names | Map of table keys to their names (multiple tables mode) |

## Table Naming Rules

Azure Storage Table names have specific requirements:

- Must start with a letter
- Must be 3-63 characters long
- Can only contain alphanumeric characters (no hyphens, underscores, or special characters)
- Are case-insensitive

## ACL Permissions

The `permissions` field in the access policy supports the following values:

| Permission | Description |
|------------|-------------|
| `r` | Read - query entities, query table metadata |
| `a` | Add - add entities to the table |
| `u` | Update - update entities in the table |
| `d` | Delete - delete entities from the table |

Permissions can be combined, e.g., `raud` for full access or `r` for read-only.

## Notes

- When `tables` is provided, the single-table variables (`name`, `acl`) are ignored
- Storage Table names must follow Azure naming restrictions (alphanumeric only, starting with a letter)
- The `create` flag controls all table resources in the module
- ACL entries use signed identifiers, which can be referenced by shared access signatures (SAS)
- A maximum of 5 ACL entries can be defined per table
