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
| [azuread_user.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_account_enabled"></a> [account\_enabled](#input\_account\_enabled) | Whether the account is enabled. | `bool` | `true` | no |
| <a name="input_business_phones"></a> [business\_phones](#input\_business\_phones) | A list of business phone numbers for the user. | `list(string)` | `[]` | no |
| <a name="input_city"></a> [city](#input\_city) | The city of the user. | `string` | `null` | no |
| <a name="input_company_name"></a> [company\_name](#input\_company\_name) | The company name of the user. | `string` | `null` | no |
| <a name="input_country"></a> [country](#input\_country) | The country of the user. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the user. | `bool` | `true` | no |
| <a name="input_department"></a> [department](#input\_department) | The department in which the user works. | `string` | `null` | no |
| <a name="input_disable_password_expiration"></a> [disable\_password\_expiration](#input\_disable\_password\_expiration) | Whether to disable password expiration. | `bool` | `false` | no |
| <a name="input_disable_strong_password"></a> [disable\_strong\_password](#input\_disable\_strong\_password) | Whether to disable strong password requirement. | `bool` | `false` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name for the user. | `string` | n/a | yes |
| <a name="input_employee_id"></a> [employee\_id](#input\_employee\_id) | The employee identifier assigned by the organization. | `string` | `null` | no |
| <a name="input_employee_type"></a> [employee\_type](#input\_employee\_type) | The type of employee (e.g., Employee, Contractor). | `string` | `null` | no |
| <a name="input_force_password_change"></a> [force\_password\_change](#input\_force\_password\_change) | Whether to force password change on first login. | `bool` | `true` | no |
| <a name="input_given_name"></a> [given\_name](#input\_given\_name) | The given name (first name) of the user. | `string` | `null` | no |
| <a name="input_job_title"></a> [job\_title](#input\_job\_title) | The job title of the user. | `string` | `null` | no |
| <a name="input_mail"></a> [mail](#input\_mail) | The primary email address of the user. | `string` | `null` | no |
| <a name="input_mail_nickname"></a> [mail\_nickname](#input\_mail\_nickname) | The mail alias for the user. | `string` | `null` | no |
| <a name="input_manager_id"></a> [manager\_id](#input\_manager\_id) | The object ID of the user's manager. | `string` | `null` | no |
| <a name="input_mobile_phone"></a> [mobile\_phone](#input\_mobile\_phone) | The mobile phone number of the user. | `string` | `null` | no |
| <a name="input_office_location"></a> [office\_location](#input\_office\_location) | The office location of the user. | `string` | `null` | no |
| <a name="input_password"></a> [password](#input\_password) | The initial password for the user. | `string` | `null` | no |
| <a name="input_postal_code"></a> [postal\_code](#input\_postal\_code) | The postal code of the user. | `string` | `null` | no |
| <a name="input_show_in_address_list"></a> [show\_in\_address\_list](#input\_show\_in\_address\_list) | Whether to show the user in the global address list. | `bool` | `true` | no |
| <a name="input_state"></a> [state](#input\_state) | The state or province of the user. | `string` | `null` | no |
| <a name="input_street_address"></a> [street\_address](#input\_street\_address) | The street address of the user. | `string` | `null` | no |
| <a name="input_surname"></a> [surname](#input\_surname) | The surname (family name) of the user. | `string` | `null` | no |
| <a name="input_usage_location"></a> [usage\_location](#input\_usage\_location) | The usage location (two-letter country code) for license assignment. | `string` | `null` | no |
| <a name="input_user_principal_name"></a> [user\_principal\_name](#input\_user\_principal\_name) | The user principal name (UPN) in the format user@domain.com. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The Terraform resource ID of the user. |
| <a name="output_mail"></a> [mail](#output\_mail) | The primary email address. |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | The object ID of the user. |
| <a name="output_onpremises_sam_account_name"></a> [onpremises\_sam\_account\_name](#output\_onpremises\_sam\_account\_name) | The on-premises SAM account name. |
| <a name="output_user_principal_name"></a> [user\_principal\_name](#output\_user\_principal\_name) | The user principal name (UPN). |
<!-- END_TF_DOCS -->