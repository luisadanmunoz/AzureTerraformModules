# Azure Entra ID Directory Role

Terraform module for activating Azure Entra ID built-in directory roles.

## Features

- Activate built-in directory roles
- Reference by display name or template ID
- Required before assigning roles to users/groups

## Usage

```hcl
module "global_admin_role" {
  source = "path/to/EntraID/DirectoryRole"

  display_name = "Global Administrator"
}

module "user_admin_role" {
  source = "path/to/EntraID/DirectoryRole"

  display_name = "User Administrator"
}
```

## Common Directory Roles

| Display Name | Template ID |
|--------------|-------------|
| Global Administrator | 62e90394-69f5-4237-9190-012177145e10 |
| User Administrator | fe930be7-5e62-47db-91af-98c3a49a38b1 |
| Application Administrator | 9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3 |
| Cloud Application Administrator | 158c047a-c907-4556-b7ef-446551a6b5f7 |
| Security Administrator | 194ae4cb-b126-40b2-bd5b-6091b380977d |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azuread | >= 2.45.0, < 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| display_name | The display name of the role | `string` | `null` | yes* |
| template_id | The template ID of the role | `string` | `null` | yes* |
| create | Whether to activate the role | `bool` | `true` | no |

*One of display_name or template_id must be provided.

## Outputs

| Name | Description |
|------|-------------|
| id | The Terraform resource ID |
| object_id | The object ID |
| display_name | The display name |
| template_id | The template ID |
| description | The role description |
