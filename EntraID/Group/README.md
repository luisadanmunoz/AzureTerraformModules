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
| [azuread_group.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_assignable_to_role"></a> [assignable\_to\_role](#input\_assignable\_to\_role) | Whether the group can be assigned to an Azure AD role. | `bool` | `false` | no |
| <a name="input_auto_subscribe_new_members"></a> [auto\_subscribe\_new\_members](#input\_auto\_subscribe\_new\_members) | Whether new members are auto-subscribed to receive email notifications (Microsoft 365 groups only). | `bool` | `null` | no |
| <a name="input_behaviors"></a> [behaviors](#input\_behaviors) | A set of behaviors for a Microsoft 365 group. | `set(string)` | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the group. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | A description for the group. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name for the group. | `string` | n/a | yes |
| <a name="input_dynamic_membership"></a> [dynamic\_membership](#input\_dynamic\_membership) | Dynamic membership rule for the group. | <pre>object({<br/>    enabled = bool<br/>    rule    = string<br/>  })</pre> | `null` | no |
| <a name="input_external_senders_allowed"></a> [external\_senders\_allowed](#input\_external\_senders\_allowed) | Whether external senders can send messages to the group (Microsoft 365 groups only). | `bool` | `null` | no |
| <a name="input_hide_from_address_lists"></a> [hide\_from\_address\_lists](#input\_hide\_from\_address\_lists) | Whether the group is hidden from the global address list. | `bool` | `null` | no |
| <a name="input_hide_from_outlook_clients"></a> [hide\_from\_outlook\_clients](#input\_hide\_from\_outlook\_clients) | Whether the group is hidden from Outlook clients. | `bool` | `null` | no |
| <a name="input_mail_enabled"></a> [mail\_enabled](#input\_mail\_enabled) | Whether the group is mail-enabled. | `bool` | `false` | no |
| <a name="input_mail_nickname"></a> [mail\_nickname](#input\_mail\_nickname) | The mail alias for the group, unique in the organization. | `string` | `null` | no |
| <a name="input_members"></a> [members](#input\_members) | A set of object IDs of members to add to the group. | `set(string)` | `[]` | no |
| <a name="input_onpremises_group_type"></a> [onpremises\_group\_type](#input\_onpremises\_group\_type) | The on-premises group type for directory sync. | `string` | `null` | no |
| <a name="input_owners"></a> [owners](#input\_owners) | A set of object IDs of principals that will be granted ownership. | `set(string)` | `[]` | no |
| <a name="input_prevent_duplicate_names"></a> [prevent\_duplicate\_names](#input\_prevent\_duplicate\_names) | If true, will return an error if an existing group is found with the same name. | `bool` | `true` | no |
| <a name="input_provisioning_options"></a> [provisioning\_options](#input\_provisioning\_options) | A set of provisioning options for a Microsoft 365 group. | `set(string)` | `[]` | no |
| <a name="input_security_enabled"></a> [security\_enabled](#input\_security\_enabled) | Whether the group is a security group. | `bool` | `true` | no |
| <a name="input_theme"></a> [theme](#input\_theme) | The theme color for a Microsoft 365 group. | `string` | `null` | no |
| <a name="input_types"></a> [types](#input\_types) | A set of group types to configure. Possible values: DynamicMembership, Unified. | `set(string)` | `[]` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | The group visibility. Possible values: Private, Public, Hiddenmembership. | `string` | `null` | no |
| <a name="input_writeback_enabled"></a> [writeback\_enabled](#input\_writeback\_enabled) | Whether writeback is enabled for the group. | `bool` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The display name of the group. |
| <a name="output_id"></a> [id](#output\_id) | The Terraform resource ID of the group. |
| <a name="output_mail"></a> [mail](#output\_mail) | The SMTP address for the group. |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | The object ID of the group. |
| <a name="output_onpremises_sam_account_name"></a> [onpremises\_sam\_account\_name](#output\_onpremises\_sam\_account\_name) | The on-premises SAM account name. |
| <a name="output_onpremises_security_identifier"></a> [onpremises\_security\_identifier](#output\_onpremises\_security\_identifier) | The on-premises security identifier (SID). |
<!-- END_TF_DOCS -->