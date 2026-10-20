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
| <a name="module_linux_vm"></a> [linux\_vm](#module\_linux\_vm) | ../../ | n/a |
| <a name="module_spot_vm"></a> [spot\_vm](#module\_spot\_vm) | ../../ | n/a |
| <a name="module_windows_vm"></a> [windows\_vm](#module\_windows\_vm) | ../../ | n/a |

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
| <a name="output_linux_vm_id"></a> [linux\_vm\_id](#output\_linux\_vm\_id) | Linux VM ID |
| <a name="output_linux_vm_password"></a> [linux\_vm\_password](#output\_linux\_vm\_password) | Linux VM admin password |
| <a name="output_linux_vm_private_ip"></a> [linux\_vm\_private\_ip](#output\_linux\_vm\_private\_ip) | Linux VM private IP |
| <a name="output_spot_vm_id"></a> [spot\_vm\_id](#output\_spot\_vm\_id) | Spot VM ID |
| <a name="output_windows_vm_id"></a> [windows\_vm\_id](#output\_windows\_vm\_id) | Windows VM ID |
| <a name="output_windows_vm_password"></a> [windows\_vm\_password](#output\_windows\_vm\_password) | Windows VM admin password |
| <a name="output_windows_vm_private_ip"></a> [windows\_vm\_private\_ip](#output\_windows\_vm\_private\_ip) | Windows VM private IP |
<!-- END_TF_DOCS -->