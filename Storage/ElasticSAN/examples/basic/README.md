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
| <a name="module_elastic_san"></a> [elastic\_san](#module\_elastic\_san) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_elastic_san_id"></a> [elastic\_san\_id](#output\_elastic\_san\_id) | The ID of the Elastic SAN. |
| <a name="output_elastic_san_name"></a> [elastic\_san\_name](#output\_elastic\_san\_name) | The name of the Elastic SAN. |
| <a name="output_total_iops"></a> [total\_iops](#output\_total\_iops) | The total IOPS of the Elastic SAN. |
| <a name="output_total_mbps"></a> [total\_mbps](#output\_total\_mbps) | The total throughput in MBps. |
| <a name="output_volume_group_ids"></a> [volume\_group\_ids](#output\_volume\_group\_ids) | The IDs of the volume groups. |
| <a name="output_volumes"></a> [volumes](#output\_volumes) | The volume details including target IQN. |
<!-- END_TF_DOCS -->