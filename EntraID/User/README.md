# Azure Entra ID User

Terraform module for creating and managing Azure Entra ID Users.

## Features

- User account creation and management
- Password policies and initial password
- Contact and organizational information
- Manager assignment
- Usage location for licensing

## Usage

```hcl
module "user" {
  source = "path/to/EntraID/User"

  display_name        = "John Doe"
  user_principal_name = "john.doe@company.com"

  given_name     = "John"
  surname        = "Doe"
  department     = "Engineering"
  job_title      = "Software Engineer"
  usage_location = "US"

  password              = "InitialP@ssw0rd!"
  force_password_change = true
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
| display_name | The display name | `string` | n/a | yes |
| user_principal_name | The UPN (user@domain.com) | `string` | n/a | yes |
| create | Whether to create the user | `bool` | `true` | no |
| account_enabled | Whether account is enabled | `bool` | `true` | no |
| password | Initial password | `string` | `null` | no |
| force_password_change | Force password change on login | `bool` | `true` | no |
| usage_location | Two-letter country code | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Terraform resource ID |
| object_id | The object ID |
| user_principal_name | The UPN |
| mail | The primary email |
