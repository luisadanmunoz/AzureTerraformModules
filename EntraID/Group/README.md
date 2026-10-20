# Azure Entra ID Group

Terraform module for creating and managing Azure Entra ID (formerly Azure AD) Groups.

## Features

- **Security Groups**: Create security-enabled groups for RBAC
- **Microsoft 365 Groups**: Create mail-enabled unified groups
- **Dynamic Membership**: Configure rule-based automatic membership
- **Role Assignment**: Groups assignable to Azure AD roles
- **Visibility Control**: Public, private, or hidden membership

## Usage

### Security Group

```hcl
module "security_group" {
  source = "path/to/EntraID/Group"

  display_name     = "sg-app-admins"
  description      = "Application administrators"
  security_enabled = true

  owners  = [data.azuread_client_config.current.object_id]
  members = ["user-object-id-1", "user-object-id-2"]
}
```

### Dynamic Security Group

```hcl
module "dynamic_group" {
  source = "path/to/EntraID/Group"

  display_name     = "sg-all-developers"
  security_enabled = true
  types            = ["DynamicMembership"]

  dynamic_membership = {
    enabled = true
    rule    = "user.department -eq \"Development\""
  }
}
```

### Microsoft 365 Group

```hcl
module "m365_group" {
  source = "path/to/EntraID/Group"

  display_name     = "team-project-alpha"
  mail_enabled     = true
  mail_nickname    = "team-project-alpha"
  security_enabled = true
  types            = ["Unified"]
  visibility       = "Private"

  owners = [data.azuread_client_config.current.object_id]
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
| display_name | The display name for the group | `string` | n/a | yes |
| create | Whether to create the group | `bool` | `true` | no |
| description | Description of the group | `string` | `null` | no |
| security_enabled | Whether it's a security group | `bool` | `true` | no |
| mail_enabled | Whether mail is enabled | `bool` | `false` | no |
| types | Group types (DynamicMembership, Unified) | `set(string)` | `[]` | no |
| assignable_to_role | Can be assigned to Azure AD roles | `bool` | `false` | no |
| owners | Object IDs of owners | `set(string)` | `[]` | no |
| members | Object IDs of members | `set(string)` | `[]` | no |
| dynamic_membership | Dynamic membership rule | `object` | `null` | no |
| visibility | Group visibility | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Terraform resource ID |
| object_id | The object ID of the group |
| display_name | The display name |
| mail | The SMTP address |

## Best Practices

1. **Naming Convention**: Use prefixes like `sg-` for security groups
2. **Owners**: Always assign at least one owner
3. **Dynamic Rules**: Use dynamic membership for large, rule-based groups
4. **Role-Assignable**: Enable only when needed (cannot be changed after creation)
