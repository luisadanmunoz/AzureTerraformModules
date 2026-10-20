# Azure File Share Terraform Module

Reusable Terraform module for creating and managing Azure File Shares within an existing Storage Account. Supports SMB and NFS protocols, access tier configuration, quota management, and access control lists (ACLs).

## Features

- Conditional creation using the `create` toggle
- Flexible naming with explicit name or auto-generated prefix/suffix
- SMB and NFS protocol support
- Access tier configuration (Hot, Cool, TransactionOptimized, Premium)
- Access Control List (ACL) management with dynamic policies
- Metadata assignment
- Default tagging with merge support

## Usage

### Basic SMB File Share

```hcl
module "file_share" {
  source = "../../Storage/FileShare"

  name               = "documents"
  storage_account_id = azurerm_storage_account.example.id
  quota              = 50

  tags = {
    Environment = "dev"
    Project     = "myapp"
  }
}
```

### NFS File Share (Premium)

```hcl
module "nfs_share" {
  source = "../../Storage/FileShare"

  name               = "nfs-data"
  storage_account_id = azurerm_storage_account.premium.id
  quota              = 100
  access_tier        = "Premium"
  enabled_protocol   = "NFS"

  tags = {
    Environment = "prod"
    Project     = "data-platform"
  }
}
```

### File Share with ACL Policies

```hcl
module "file_share_acl" {
  source = "../../Storage/FileShare"

  name               = "shared-files"
  storage_account_id = azurerm_storage_account.example.id
  quota              = 100
  access_tier        = "Hot"

  acl = [
    {
      id = "read-policy"
      access_policy = {
        permissions = "rl"
        start       = "2025-01-01T00:00:00Z"
        expiry      = "2025-12-31T23:59:59Z"
      }
    },
    {
      id = "write-policy"
      access_policy = {
        permissions = "rwdl"
        start       = "2025-01-01T00:00:00Z"
        expiry      = "2025-06-30T23:59:59Z"
      }
    }
  ]

  tags = {
    Environment = "staging"
  }
}
```

### Disable Resource Creation

```hcl
module "file_share_disabled" {
  source = "../../Storage/FileShare"

  create             = false
  storage_account_id = "placeholder"
  quota              = 1
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
| [azurerm_storage_share.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the File Share | `bool` | `true` | no |
| name | Explicit name for the File Share (overrides generated name) | `string` | `null` | no |
| name\_prefix | Prefix used to generate the File Share name | `string` | `"share"` | no |
| name\_suffix | Suffix appended to the generated File Share name | `string` | `""` | no |
| storage\_account\_id | The ID of the Storage Account (DEPENDENCY: must exist) | `string` | n/a | yes |
| quota | Maximum size of the File Share in GB (1-102400) | `number` | n/a | yes |
| access\_tier | Access tier: Hot, Cool, TransactionOptimized, or Premium | `string` | `"TransactionOptimized"` | no |
| enabled\_protocol | Protocol for the File Share: SMB or NFS | `string` | `"SMB"` | no |
| metadata | Mapping of metadata to assign to the File Share | `map(string)` | `null` | no |
| acl | List of ACL entries with id and optional access\_policy | `list(object)` | `[]` | no |
| tags | Map of tags to assign (merged with default tags) | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the File Share |
| name | The name of the File Share |
| url | The URL of the File Share |
| resource\_manager\_id | The Resource Manager ID of the File Share |

## Dependencies

This module has the following external dependencies:

- **Storage Account**: Must exist before creating the File Share. Pass its ID via `storage_account_id`. For NFS shares, the Storage Account must be of kind `FileStorage` with `Premium` tier and `https_traffic_only_enabled = false`.

## Notes

- **SMB shares** support all access tiers (Hot, Cool, TransactionOptimized, Premium).
- **NFS shares** require a Premium FileStorage account and only support the `Premium` access tier.
- **ACL policies** are only supported for SMB shares.
- The `quota` value represents the maximum size in GB. For Premium shares, this also determines the provisioned size and IOPS.
