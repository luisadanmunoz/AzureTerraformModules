# Azure Blob Container Module

Reusable Terraform module for creating and managing Azure Storage Blob Containers with support for access control, encryption scopes, immutability policies, and metadata.

## Features

- Conditional resource creation with `create` flag
- Flexible naming convention with prefix/suffix support
- Configurable container access levels (private, blob, container)
- Optional immutability policy with Unlocked/Locked modes
- Encryption scope support with override configuration
- Custom metadata assignment
- Default tagging with merge support

## Usage

### Basic Example

```hcl
module "blob_container" {
  source = "../../Storage/BlobContainer"

  storage_account_id = azurerm_storage_account.example.id

  name_prefix = "blob"
  workload    = "data"
  environment = "dev"
  instance    = "001"

  container_access_type = "private"

  tags = {
    Project = "my-project"
  }
}
```

### With Explicit Name

```hcl
module "blob_container" {
  source = "../../Storage/BlobContainer"

  storage_account_id = azurerm_storage_account.example.id
  name               = "my-custom-container"

  container_access_type = "private"

  metadata = {
    purpose = "application-data"
    team    = "engineering"
  }

  tags = {
    Project = "my-project"
  }
}
```

### With Immutability Policy

```hcl
module "blob_container" {
  source = "../../Storage/BlobContainer"

  storage_account_id = azurerm_storage_account.example.id
  name               = "compliance-data"

  container_access_type = "private"

  immutability_policy = {
    expiry_in_days = 365
    policy_mode    = "Unlocked"
  }

  tags = {
    Compliance = "true"
  }
}
```

### With Encryption Scope

```hcl
module "blob_container" {
  source = "../../Storage/BlobContainer"

  storage_account_id = azurerm_storage_account.example.id
  name               = "encrypted-container"

  default_encryption_scope          = "my-encryption-scope"
  encryption_scope_override_enabled = false

  tags = {
    Security = "high"
  }
}
```

### Disabled (No Resources Created)

```hcl
module "blob_container" {
  source = "../../Storage/BlobContainer"

  create             = false
  storage_account_id = "placeholder-id"
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
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Controls whether to create the Blob Container | `bool` | `true` | no |
| storage_account_id | The ID of the Storage Account (DEPENDENCY: must exist) | `string` | n/a | yes |
| name | Explicit name for the Blob Container (overrides generated name) | `string` | `null` | no |
| name_prefix | Prefix for the generated name | `string` | `"blob"` | no |
| name_suffix | Suffix for the generated name | `string` | `""` | no |
| workload | Workload or purpose name for naming convention | `string` | `"default"` | no |
| environment | Environment name for naming convention | `string` | `"dev"` | no |
| instance | Instance number for naming convention | `string` | `"001"` | no |
| container_access_type | Access level: "blob", "container", or "private" | `string` | `"private"` | no |
| metadata | Key-value pairs to assign as metadata | `map(string)` | `null` | no |
| default_encryption_scope | Default encryption scope for blobs | `string` | `null` | no |
| encryption_scope_override_enabled | Allow blobs to override the default encryption scope | `bool` | `true` | no |
| immutability_policy | Immutability policy with expiry_in_days and policy_mode (Unlocked/Locked) | `object` | `null` | no |
| tags | Tags to assign to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Blob Container |
| name | The name of the Blob Container |
| has_immutability_policy | Whether the container has an immutability policy |
| has_legal_hold | Whether the container has a legal hold |
| resource_manager_id | The Resource Manager ID of the Blob Container |

## Dependencies

This module requires the following resources to exist before deployment:

- **Storage Account**: The `storage_account_id` must reference an existing Azure Storage Account.
- **Encryption Scope** (optional): If `default_encryption_scope` is set, the encryption scope must exist on the referenced Storage Account.

## Notes

- Container names must be lowercase, between 3 and 63 characters, and can contain only letters, numbers, and hyphens.
- Once an immutability policy mode is set to `Locked`, it **cannot** be reversed or removed. Use `Unlocked` mode for testing.
- The `default_tags` include `terraform-managed = true` and `module = BlobContainer`. These are merged with user-provided `tags`.
