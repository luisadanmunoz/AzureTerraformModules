# Azure Entra ID Directory Role Assignment

Terraform module for assigning Azure Entra ID directory roles to principals.

## Features

- Assign roles to users, groups, or service principals
- Scoped assignments to administrative units
- Application-scoped role assignments

## Usage

```hcl
module "user_admin_role" {
  source = "path/to/EntraID/DirectoryRole"
  display_name = "User Administrator"
}

module "role_assignment" {
  source = "path/to/EntraID/DirectoryRoleAssignment"

  role_id             = module.user_admin_role.object_id
  principal_object_id = module.security_group.object_id
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azuread | >= 2.45.0, < 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| role_id | Object ID of the directory role | `string` | n/a | yes |
| principal_object_id | Object ID of the principal | `string` | n/a | yes |
| create | Whether to create the assignment | `bool` | `true` | no |
| app_scope_id | App scope for scoped assignments | `string` | `null` | no |
| directory_scope_id | Directory scope (e.g., AU ID) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Terraform resource ID |
