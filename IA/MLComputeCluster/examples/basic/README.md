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
| <a name="module_cpu_cluster"></a> [cpu\_cluster](#module\_cpu\_cluster) | ../../ | n/a |
| <a name="module_gpu_cluster"></a> [gpu\_cluster](#module\_gpu\_cluster) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_machine_learning_workspace.existing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/machine_learning_workspace) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cpu_cluster_id"></a> [cpu\_cluster\_id](#output\_cpu\_cluster\_id) | n/a |
| <a name="output_gpu_cluster_id"></a> [gpu\_cluster\_id](#output\_gpu\_cluster\_id) | n/a |
<!-- END_TF_DOCS -->