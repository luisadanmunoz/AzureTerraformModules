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
| [azuread_conditional_access_policy.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/conditional_access_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_conditions_applications"></a> [conditions\_applications](#input\_conditions\_applications) | Application conditions for the policy. | <pre>object({<br/>    included_applications = optional(list(string), ["All"])<br/>    excluded_applications = optional(list(string), [])<br/>    included_user_actions = optional(list(string), [])<br/>  })</pre> | <pre>{<br/>  "included_applications": [<br/>    "All"<br/>  ]<br/>}</pre> | no |
| <a name="input_conditions_client_app_types"></a> [conditions\_client\_app\_types](#input\_conditions\_client\_app\_types) | Client app types for the policy. Possible values: all, browser, mobileAppsAndDesktopClients, exchangeActiveSync, other. | `list(string)` | <pre>[<br/>  "all"<br/>]</pre> | no |
| <a name="input_conditions_locations"></a> [conditions\_locations](#input\_conditions\_locations) | Location conditions for the policy. | <pre>object({<br/>    included_locations = optional(list(string), [])<br/>    excluded_locations = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_conditions_platforms"></a> [conditions\_platforms](#input\_conditions\_platforms) | Platform conditions for the policy. | <pre>object({<br/>    included_platforms = optional(list(string), [])<br/>    excluded_platforms = optional(list(string), [])<br/>  })</pre> | `null` | no |
| <a name="input_conditions_sign_in_risk_levels"></a> [conditions\_sign\_in\_risk\_levels](#input\_conditions\_sign\_in\_risk\_levels) | Sign-in risk levels. Possible values: low, medium, high, hidden, none. | `list(string)` | `[]` | no |
| <a name="input_conditions_user_risk_levels"></a> [conditions\_user\_risk\_levels](#input\_conditions\_user\_risk\_levels) | User risk levels. Possible values: low, medium, high, hidden, none. | `list(string)` | `[]` | no |
| <a name="input_conditions_users"></a> [conditions\_users](#input\_conditions\_users) | User conditions for the policy. | <pre>object({<br/>    included_users  = optional(list(string), [])<br/>    excluded_users  = optional(list(string), [])<br/>    included_groups = optional(list(string), [])<br/>    excluded_groups = optional(list(string), [])<br/>    included_roles  = optional(list(string), [])<br/>    excluded_roles  = optional(list(string), [])<br/>    included_guests_or_external_users = optional(object({<br/>      guest_or_external_user_types = optional(list(string), [])<br/>      external_tenants = optional(object({<br/>        membership_kind = optional(string)<br/>        members         = optional(list(string), [])<br/>      }))<br/>    }))<br/>    excluded_guests_or_external_users = optional(object({<br/>      guest_or_external_user_types = optional(list(string), [])<br/>      external_tenants = optional(object({<br/>        membership_kind = optional(string)<br/>        members         = optional(list(string), [])<br/>      }))<br/>    }))<br/>  })</pre> | <pre>{<br/>  "included_users": [<br/>    "All"<br/>  ]<br/>}</pre> | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the policy. | `bool` | `true` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name for the conditional access policy. | `string` | n/a | yes |
| <a name="input_grant_controls"></a> [grant\_controls](#input\_grant\_controls) | Grant controls for the policy. | <pre>object({<br/>    operator                          = optional(string, "OR")<br/>    built_in_controls                 = optional(list(string), [])<br/>    custom_authentication_factors     = optional(list(string), [])<br/>    terms_of_use                      = optional(list(string), [])<br/>    authentication_strength_policy_id = optional(string)<br/>  })</pre> | <pre>{<br/>  "built_in_controls": [<br/>    "mfa"<br/>  ],<br/>  "operator": "OR"<br/>}</pre> | no |
| <a name="input_session_controls"></a> [session\_controls](#input\_session\_controls) | Session controls for the policy. | <pre>object({<br/>    application_enforced_restrictions_enabled = optional(bool)<br/>    cloud_app_security_policy                 = optional(string)<br/>    disable_resilience_defaults               = optional(bool)<br/>    persistent_browser_mode                   = optional(string)<br/>    sign_in_frequency                         = optional(number)<br/>    sign_in_frequency_period                  = optional(string)<br/>    sign_in_frequency_authentication_type     = optional(string)<br/>    sign_in_frequency_interval                = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_state"></a> [state](#input\_state) | The state of the policy. Possible values: enabled, disabled, enabledForReportingButNotEnforced. | `string` | `"disabled"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the policy. |
| <a name="output_id"></a> [id](#output\_id) | The Terraform resource ID of the policy. |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | The object ID of the policy. |
| <a name="output_state"></a> [state](#output\_state) | The state of the policy. |
<!-- END_TF_DOCS -->