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
| [azurerm_storage_table.multiple](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [azurerm_storage_table.single](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_acl"></a> [acl](#input\_acl) | (Optional) List of access control entries for the single Storage Table (used when 'tables' is not set).<br/><br/>Each ACL entry contains:<br/>  - id: Unique identifier for the ACL entry (up to 64 characters).<br/>  - access\_policy: (Optional) Access policy configuration.<br/>    - start: Start time in UTC for the access policy (ISO 8601 format).<br/>    - expiry: Expiry time in UTC for the access policy (ISO 8601 format).<br/>    - permissions: Allowed permissions string (combination of r, a, u, d). | <pre>list(object({<br/>    id = string<br/>    access_policy = optional(object({<br/>      start       = string<br/>      expiry      = string<br/>      permissions = string<br/>    }), null)<br/>  }))</pre> | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Storage Table(s). Set to false to disable resource creation without removing module code. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) The environment name (e.g., dev, staging, prod), used for naming convention. | `string` | `"dev"` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number or identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the Storage Table. If provided, overrides the name\_prefix-based generated name. Ignored when 'tables' is set. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix to prepend to the generated Storage Table name. Used when 'name' is not provided. | `string` | `"table"` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | (Optional) Suffix to append to the generated Storage Table name. Used when 'name' is not provided. | `string` | `""` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | (Required) The name of the Storage Account where the Table(s) will be created.<br/>DEPENDENCY: Storage Account must exist before creating Storage Tables. | `string` | n/a | yes |
| <a name="input_tables"></a> [tables](#input\_tables) | (Optional) Map of Storage Tables to create via for\_each. When provided, the single-table<br/>variables (name, acl) are ignored.<br/><br/>Each key is the table name, and the value is an object with:<br/>  - acl: (Optional) List of access control entries for the table.<br/>    Each ACL entry contains:<br/>      - id: Unique identifier for the ACL entry (up to 64 characters).<br/>      - access\_policy: (Optional) Access policy configuration.<br/>        - start: Start time in UTC for the access policy (ISO 8601 format).<br/>        - expiry: Expiry time in UTC for the access policy (ISO 8601 format).<br/>        - permissions: Allowed permissions string (combination of r, a, u, d). | <pre>map(object({<br/>    acl = optional(list(object({<br/>      id = string<br/>      access_policy = optional(object({<br/>        start       = string<br/>        expiry      = string<br/>        permissions = string<br/>      }), null)<br/>    })), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the resources. These tags are merged with the module's default tags. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) The workload or application name, used for naming convention. | `string` | `"shared"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Storage Table (single table mode). |
| <a name="output_name"></a> [name](#output\_name) | The name of the Storage Table (single table mode). |
| <a name="output_table_ids"></a> [table\_ids](#output\_table\_ids) | Map of table names to their IDs (multiple tables mode). |
| <a name="output_table_names"></a> [table\_names](#output\_table\_names) | Map of table keys to their names (multiple tables mode). |
<!-- END_TF_DOCS -->