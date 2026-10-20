<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_acr_premium"></a> [acr\_premium](#module\_acr\_premium) | ../../ | n/a |
| <a name="module_acr_standard"></a> [acr\_standard](#module\_acr\_standard) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_docker_login_command"></a> [docker\_login\_command](#output\_docker\_login\_command) | n/a |
| <a name="output_premium_login_server"></a> [premium\_login\_server](#output\_premium\_login\_server) | n/a |
| <a name="output_standard_login_server"></a> [standard\_login\_server](#output\_standard\_login\_server) | n/a |
<!-- END_TF_DOCS -->