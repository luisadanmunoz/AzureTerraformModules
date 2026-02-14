# Role Definition

Terraform module for Azure Custom Role Definition.

## Features

- Custom RBAC roles with fine-grained permissions
- Control plane (actions) and data plane (data_actions) permissions
- Assignable scope configuration
- Support for not_actions and not_data_actions exclusions

## Usage

### Basic Custom Role

```hcl
module "custom_reader" {
  source = "./Gobernanza/RoleDefinition"

  name        = "Custom VM Reader"
  scope       = data.azurerm_subscription.current.id
  description = "Can view VMs but not manage them"

  permissions = [
    {
      actions = [
        "Microsoft.Compute/virtualMachines/read",
        "Microsoft.Compute/virtualMachines/instanceView/read"
      ]
    }
  ]
}
```

### DevOps Role with Exclusions

```hcl
module "devops_role" {
  source = "./Gobernanza/RoleDefinition"

  name        = "DevOps Engineer"
  scope       = data.azurerm_subscription.current.id
  description = "Can manage resources except IAM and networking"

  permissions = [
    {
      actions = [
        "Microsoft.Compute/*",
        "Microsoft.Storage/*",
        "Microsoft.Web/*"
      ]
      not_actions = [
        "Microsoft.Authorization/*",
        "Microsoft.Network/virtualNetworks/*"
      ]
    }
  ]
}
```

### Data Plane Role

```hcl
module "blob_processor" {
  source = "./Gobernanza/RoleDefinition"

  name        = "Blob Processor"
  scope       = data.azurerm_subscription.current.id
  description = "Can read and process blobs"

  permissions = [
    {
      actions = [
        "Microsoft.Storage/storageAccounts/read"
      ]
      data_actions = [
        "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
        "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write"
      ]
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.70.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Role name | `string` | n/a | yes |
| scope | Role scope | `string` | n/a | yes |
| permissions | Permissions list | `list(object)` | n/a | yes |
| description | Description | `string` | `null` | no |
| assignable_scopes | Where role can be assigned | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Role Definition ID |
| role_definition_id | Role Definition GUID |
| name | Role name |
| role_definition_resource_id | Role resource ID |

## Permission Types

| Type | Scope | Example |
|------|-------|---------|
| actions | Control plane | `Microsoft.Compute/virtualMachines/read` |
| not_actions | Control plane exclusions | `Microsoft.Authorization/*` |
| data_actions | Data plane | `Microsoft.Storage/.../blobs/read` |
| not_data_actions | Data plane exclusions | `Microsoft.KeyVault/.../secrets/delete` |

## Best Practices

1. **Principle of least privilege** - Grant minimum required permissions
2. **Use not_actions** - Exclude sensitive operations explicitly
3. **Document roles** - Clear descriptions for auditing
4. **Limit assignable scopes** - Restrict where role can be used
5. **Prefer built-in roles** - Only create custom when necessary
