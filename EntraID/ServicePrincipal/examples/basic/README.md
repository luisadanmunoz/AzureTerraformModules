<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.45.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.45.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_graph_sp"></a> [graph\_sp](#module\_graph\_sp) | ../../ | n/a |
| <a name="module_sp_basic"></a> [sp\_basic](#module\_sp\_basic) | ../../ | n/a |
| <a name="module_sp_restricted"></a> [sp\_restricted](#module\_sp\_restricted) | ../../ | n/a |
| <a name="module_sp_saml"></a> [sp\_saml](#module\_sp\_saml) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azuread_application.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application.restricted](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application.saml_app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_basic_sp_object_id"></a> [basic\_sp\_object\_id](#output\_basic\_sp\_object\_id) | Object ID of the basic service principal |
| <a name="output_graph_sp_app_roles"></a> [graph\_sp\_app\_roles](#output\_graph\_sp\_app\_roles) | App roles available in Microsoft Graph |
| <a name="output_graph_sp_object_id"></a> [graph\_sp\_object\_id](#output\_graph\_sp\_object\_id) | Object ID of Microsoft Graph service principal |
| <a name="output_restricted_sp_object_id"></a> [restricted\_sp\_object\_id](#output\_restricted\_sp\_object\_id) | Object ID of the restricted service principal |
| <a name="output_saml_sp_object_id"></a> [saml\_sp\_object\_id](#output\_saml\_sp\_object\_id) | Object ID of the SAML service principal |
| <a name="output_saml_sp_saml_metadata_url"></a> [saml\_sp\_saml\_metadata\_url](#output\_saml\_sp\_saml\_metadata\_url) | SAML metadata URL for federation |
<!-- END_TF_DOCS -->