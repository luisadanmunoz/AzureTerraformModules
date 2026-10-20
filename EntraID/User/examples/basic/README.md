<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.45.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.45.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_user"></a> [user](#module\_user) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [random_password.user](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azuread_domains.default](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/domains) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_user_id"></a> [user\_id](#output\_user\_id) | n/a |
| <a name="output_user_upn"></a> [user\_upn](#output\_user\_upn) | n/a |
<!-- END_TF_DOCS -->