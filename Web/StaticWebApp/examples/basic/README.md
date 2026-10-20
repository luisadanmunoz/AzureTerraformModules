<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0, < 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0, < 5.0.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_swa_free"></a> [swa\_free](#module\_swa\_free) | ../../ | n/a |
| <a name="module_swa_standard"></a> [swa\_standard](#module\_swa\_standard) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_free_swa_hostname"></a> [free\_swa\_hostname](#output\_free\_swa\_hostname) | The hostname of the free Static Web App. |
| <a name="output_standard_swa_hostname"></a> [standard\_swa\_hostname](#output\_standard\_swa\_hostname) | The hostname of the standard Static Web App. |
| <a name="output_standard_swa_principal_id"></a> [standard\_swa\_principal\_id](#output\_standard\_swa\_principal\_id) | The principal ID of the standard Static Web App. |
<!-- END_TF_DOCS -->