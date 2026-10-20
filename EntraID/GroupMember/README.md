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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.45.0, < 3.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.45.0, < 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azuread_group_member.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the group membership. | `bool` | `true` | no |
| <a name="input_group_object_id"></a> [group\_object\_id](#input\_group\_object\_id) | The object ID of the group to add the member to. | `string` | n/a | yes |
| <a name="input_member_object_id"></a> [member\_object\_id](#input\_member\_object\_id) | The object ID of the member (user, group, service principal, or device). | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The Terraform resource ID of the group membership. |
<!-- END_TF_DOCS -->