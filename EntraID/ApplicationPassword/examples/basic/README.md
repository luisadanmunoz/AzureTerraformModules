<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.45.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.45.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_secret_basic"></a> [secret\_basic](#module\_secret\_basic) | ../../ | n/a |
| <a name="module_secret_fixed_dates"></a> [secret\_fixed\_dates](#module\_secret\_fixed\_dates) | ../../ | n/a |
| <a name="module_secret_primary"></a> [secret\_primary](#module\_secret\_primary) | ../../ | n/a |
| <a name="module_secret_secondary"></a> [secret\_secondary](#module\_secret\_secondary) | ../../ | n/a |
| <a name="module_secret_short_lived"></a> [secret\_short\_lived](#module\_secret\_short\_lived) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azuread_application.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_application_client_id"></a> [application\_client\_id](#output\_application\_client\_id) | Client ID of the application |
| <a name="output_basic_secret_end_date"></a> [basic\_secret\_end\_date](#output\_basic\_secret\_end\_date) | Expiration date of the basic secret |
| <a name="output_basic_secret_id"></a> [basic\_secret\_id](#output\_basic\_secret\_id) | Key ID of the basic secret |
| <a name="output_primary_secret_id"></a> [primary\_secret\_id](#output\_primary\_secret\_id) | Key ID of the primary rotating secret |
| <a name="output_secondary_secret_id"></a> [secondary\_secret\_id](#output\_secondary\_secret\_id) | Key ID of the secondary rotating secret |
| <a name="output_short_lived_secret_end_date"></a> [short\_lived\_secret\_end\_date](#output\_short\_lived\_secret\_end\_date) | Expiration date of the short-lived secret |
| <a name="output_short_lived_secret_id"></a> [short\_lived\_secret\_id](#output\_short\_lived\_secret\_id) | Key ID of the short-lived secret |
<!-- END_TF_DOCS -->