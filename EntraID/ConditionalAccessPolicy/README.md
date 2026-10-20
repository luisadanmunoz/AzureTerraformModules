# Azure Entra ID Conditional Access Policy

Terraform module for creating Azure Entra ID Conditional Access policies.

## Features

- User, group, and role targeting
- Application and user action conditions
- Platform and location conditions
- Risk-based conditions (sign-in and user risk)
- Grant controls (MFA, compliant device, etc.)
- Session controls (sign-in frequency, persistence)

## Usage

### Require MFA for All Users

```hcl
module "require_mfa" {
  source = "path/to/EntraID/ConditionalAccessPolicy"

  display_name = "Require MFA for all users"
  state        = "enabledForReportingButNotEnforced"

  conditions_users = {
    included_users  = ["All"]
    excluded_groups = [module.break_glass_group.object_id]
  }

  conditions_applications = {
    included_applications = ["All"]
  }

  grant_controls = {
    operator          = "OR"
    built_in_controls = ["mfa"]
  }
}
```

### Block Legacy Authentication

```hcl
module "block_legacy" {
  source = "path/to/EntraID/ConditionalAccessPolicy"

  display_name = "Block legacy authentication"
  state        = "enabled"

  conditions_users = {
    included_users = ["All"]
  }

  conditions_applications = {
    included_applications = ["All"]
  }

  conditions_client_app_types = ["exchangeActiveSync", "other"]

  grant_controls = {
    operator          = "OR"
    built_in_controls = ["block"]
  }
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
| state | Policy state | `string` | `"disabled"` | no |
| conditions_users | User conditions | `object` | All users | no |
| conditions_applications | App conditions | `object` | All apps | no |
| conditions_client_app_types | Client app types | `list(string)` | `["all"]` | no |
| conditions_platforms | Platform conditions | `object` | `null` | no |
| conditions_locations | Location conditions | `object` | `null` | no |
| grant_controls | Grant controls | `object` | MFA | no |
| session_controls | Session controls | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Terraform resource ID |
| object_id | The object ID |
| display_name | The display name |
| state | The policy state |

## Best Practices

1. **Report-Only First**: Deploy in `enabledForReportingButNotEnforced` mode first
2. **Break Glass**: Always exclude emergency access accounts
3. **Least Privilege**: Target specific apps/users when possible
4. **Named Locations**: Use named locations for trusted networks
