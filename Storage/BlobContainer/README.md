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
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_container_access_type"></a> [container\_access\_type](#input\_container\_access\_type) | (Optional) The access level configured for the Blob Container.<br/>Possible values: "blob", "container", "private". Defaults to "private".<br/>- "private":   No anonymous access. All requests must be authorized.<br/>- "blob":      Anonymous read access for blobs only.<br/>- "container": Anonymous read access for the container and its blobs. | `string` | `"private"` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether to create the Blob Container. Set to false to disable resource creation without removing module code. | `bool` | `true` | no |
| <a name="input_default_encryption_scope"></a> [default\_encryption\_scope](#input\_default\_encryption\_scope) | (Optional) The default encryption scope to use for blobs uploaded to this container.<br/>DEPENDENCY: The encryption scope must exist on the Storage Account before referencing. | `string` | `null` | no |
| <a name="input_encryption_scope_override_enabled"></a> [encryption\_scope\_override\_enabled](#input\_encryption\_scope\_override\_enabled) | (Optional) Whether to allow blobs to override the default encryption scope. Defaults to true. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) The environment name (e.g., dev, staging, prod), used for naming convention. | `string` | `"dev"` | no |
| <a name="input_immutability_policy"></a> [immutability\_policy](#input\_immutability\_policy) | (Optional) Immutability policy configuration for the Blob Container.<br/>When configured, blobs in the container cannot be modified or deleted for the specified period.<br/><br/>Attributes:<br/>  - expiry\_in\_days: (Required) The number of days that blobs are immutable.<br/>  - policy\_mode:    (Required) The immutability policy mode. Possible values: "Unlocked", "Locked".<br/>                    WARNING: Once set to "Locked", the policy cannot be reversed or removed. | <pre>object({<br/>    expiry_in_days = number<br/>    policy_mode    = string<br/>  })</pre> | `null` | no |
| <a name="input_instance"></a> [instance](#input\_instance) | (Optional) Instance number or identifier for naming convention. | `string` | `"001"` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | (Optional) A mapping of metadata key-value pairs to assign to the Blob Container. | `map(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The explicit name for the Blob Container. If provided, overrides name\_prefix/name\_suffix logic. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix to prepend to the generated Blob Container name. Used when 'name' is not provided. | `string` | `"blob"` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | (Optional) Suffix to append to the generated Blob Container name. Used when 'name' is not provided. | `string` | `""` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | (Required) The ID of the Storage Account where the Blob Container will be created.<br/>DEPENDENCY: Storage Account must exist before creating the Blob Container. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to resources that support tagging. | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Optional) The workload or purpose name, used for naming convention. | `string` | `"default"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_has_immutability_policy"></a> [has\_immutability\_policy](#output\_has\_immutability\_policy) | Whether the Blob Container has an immutability policy configured. |
| <a name="output_has_legal_hold"></a> [has\_legal\_hold](#output\_has\_legal\_hold) | Whether the Blob Container has a legal hold configured. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Blob Container. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Blob Container. |
| <a name="output_resource_manager_id"></a> [resource\_manager\_id](#output\_resource\_manager\_id) | The Resource Manager ID of the Blob Container. |
<!-- END_TF_DOCS -->