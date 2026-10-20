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
| <a name="module_vmss_linux"></a> [vmss\_linux](#module\_vmss\_linux) | ../../ | n/a |
| <a name="module_vmss_windows"></a> [vmss\_windows](#module\_vmss\_windows) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_linux_vmss_autoscale_id"></a> [linux\_vmss\_autoscale\_id](#output\_linux\_vmss\_autoscale\_id) | Linux VMSS autoscale setting ID |
| <a name="output_linux_vmss_id"></a> [linux\_vmss\_id](#output\_linux\_vmss\_id) | Linux VMSS ID |
| <a name="output_linux_vmss_password"></a> [linux\_vmss\_password](#output\_linux\_vmss\_password) | Linux VMSS admin password |
| <a name="output_windows_vmss_id"></a> [windows\_vmss\_id](#output\_windows\_vmss\_id) | Windows VMSS ID |
| <a name="output_windows_vmss_password"></a> [windows\_vmss\_password](#output\_windows\_vmss\_password) | Windows VMSS admin password |
<!-- END_TF_DOCS -->