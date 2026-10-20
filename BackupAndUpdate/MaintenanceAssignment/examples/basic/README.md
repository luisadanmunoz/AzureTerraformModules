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
| <a name="module_dynamic_maintenance"></a> [dynamic\_maintenance](#module\_dynamic\_maintenance) | ../../ | n/a |
| <a name="module_vm_maintenance"></a> [vm\_maintenance](#module\_vm\_maintenance) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_maintenance_configuration.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maintenance_configuration) | resource |
| [azurerm_network_interface.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_windows_virtual_machine.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_dynamic_scope_id"></a> [dynamic\_scope\_id](#output\_dynamic\_scope\_id) | Dynamic scope assignment ID |
| <a name="output_vm_maintenance_ids"></a> [vm\_maintenance\_ids](#output\_vm\_maintenance\_ids) | Maintenance assignment IDs for VMs |
<!-- END_TF_DOCS -->