# Azure Entra ID Group Member

Terraform module for managing Azure Entra ID Group memberships.

## Features

- Add users, groups, service principals, or devices to groups
- Manage membership lifecycle with Terraform

## Usage

```hcl
module "group_member" {
  source = "path/to/EntraID/GroupMember"

  group_object_id  = module.security_group.object_id
  member_object_id = data.azuread_user.example.object_id
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
| group_object_id | Object ID of the group | `string` | n/a | yes |
| member_object_id | Object ID of the member | `string` | n/a | yes |
| create | Whether to create the membership | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Terraform resource ID |
