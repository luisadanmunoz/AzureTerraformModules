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
| [azuread_directory_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_app_scope_id"></a> [app\_scope\_id](#input\_app\_scope\_id) | The app scope ID for scoped role assignments (e.g., for application-scoped roles). | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the role assignment. | `bool` | `true` | no |
| <a name="input_directory_scope_id"></a> [directory\_scope\_id](#input\_directory\_scope\_id) | The directory scope ID for scoped role assignments (e.g., administrative unit ID). | `string` | `null` | no |
| <a name="input_principal_object_id"></a> [principal\_object\_id](#input\_principal\_object\_id) | The object ID of the principal (user, group, or service principal) to assign the role to. | `string` | n/a | yes |
| <a name="input_role_id"></a> [role\_id](#input\_role\_id) | The object ID of the directory role to assign. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The Terraform resource ID of the role assignment. |
<!-- END_TF_DOCS -->