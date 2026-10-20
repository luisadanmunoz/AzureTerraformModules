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
| [azurerm_storage_share.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | (Optional) The access tier of the File Share. Possible values are Hot, Cool, TransactionOptimized, and Premium. | `string` | `"TransactionOptimized"` | no |
| <a name="input_acl"></a> [acl](#input\_acl) | (Optional) List of access control list (ACL) entries for the File Share.<br/>Each entry specifies an ACL policy with permissions.<br/><br/>Attributes:<br/>  - id: A unique identifier for the ACL entry.<br/>  - access\_policy: (Optional) Access policy configuration block.<br/>    - start:       (Optional) The start time of the access policy in ISO 8601 format.<br/>    - expiry:      (Optional) The expiry time of the access policy in ISO 8601 format.<br/>    - permissions: (Required) The permissions granted by the access policy (r, w, d, l combinations). | <pre>list(object({<br/>    id = string<br/>    access_policy = optional(object({<br/>      start       = optional(string)<br/>      expiry      = optional(string)<br/>      permissions = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the File Share. Set to false to disable resource creation without removing module code. | `bool` | `true` | no |
| <a name="input_enabled_protocol"></a> [enabled\_protocol](#input\_enabled\_protocol) | (Optional) The protocol used for the File Share. Possible values are SMB and NFS. | `string` | `"SMB"` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | (Optional) A mapping of metadata to assign to the File Share. | `map(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the File Share. If provided, overrides the generated name from name\_prefix. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix used to generate the File Share name when 'name' is not provided. | `string` | `"share"` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | (Optional) Suffix to append to the generated File Share name. Used when 'name' is not provided. | `string` | `""` | no |
| <a name="input_quota"></a> [quota](#input\_quota) | (Required) The maximum size of the File Share in GB.<br/>For SMB shares: 1-102400 GB (100 TiB).<br/>For Premium file shares the minimum is 100 GB. | `number` | n/a | yes |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | (Required) The ID of the Storage Account in which to create the File Share.<br/>DEPENDENCY: Storage Account must exist before creating the File Share. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the File Share. These tags are merged with the default tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the File Share. |
| <a name="output_name"></a> [name](#output\_name) | The name of the File Share. |
| <a name="output_resource_manager_id"></a> [resource\_manager\_id](#output\_resource\_manager\_id) | The Resource Manager ID of the File Share. |
| <a name="output_url"></a> [url](#output\_url) | The URL of the File Share. |
<!-- END_TF_DOCS -->