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
| <a name="module_mover_eastus_westeurope"></a> [mover\_eastus\_westeurope](#module\_mover\_eastus\_westeurope) | ../../ | n/a |
| <a name="module_mover_eastus_westus"></a> [mover\_eastus\_westus](#module\_mover\_eastus\_westus) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_mover_westeurope_id"></a> [mover\_westeurope\_id](#output\_mover\_westeurope\_id) | The ID of the East US to West Europe mover. |
| <a name="output_mover_westus_id"></a> [mover\_westus\_id](#output\_mover\_westus\_id) | The ID of the East US to West US mover. |
| <a name="output_mover_westus_principal_id"></a> [mover\_westus\_principal\_id](#output\_mover\_westus\_principal\_id) | The principal ID of the East US to West US mover. |
<!-- END_TF_DOCS -->