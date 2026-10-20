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
| [azurerm_role_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_assignable_scopes"></a> [assignable\_scopes](#input\_assignable\_scopes) | List of scopes where this role can be assigned. If null, uses the scope variable. | `list(string)` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the role definition. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the custom role definition. | `string` | n/a | yes |
| <a name="input_permissions"></a> [permissions](#input\_permissions) | List of permissions for the role. | <pre>list(object({<br/>    actions          = optional(list(string), [])<br/>    not_actions      = optional(list(string), [])<br/>    data_actions     = optional(list(string), [])<br/>    not_data_actions = optional(list(string), [])<br/>  }))</pre> | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | The scope at which the role definition is available (subscription or management group ID). | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Role Definition. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Role Definition. |
| <a name="output_role_definition_id"></a> [role\_definition\_id](#output\_role\_definition\_id) | The Role Definition ID (GUID). |
| <a name="output_role_definition_resource_id"></a> [role\_definition\_resource\_id](#output\_role\_definition\_resource\_id) | The Resource ID of the Role Definition. |
<!-- END_TF_DOCS -->