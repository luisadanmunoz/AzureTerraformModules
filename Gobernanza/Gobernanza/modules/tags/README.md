<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cost_center"></a> [cost\_center](#input\_cost\_center) | value to set the cost center | `string` | n/a | yes |
| <a name="input_criticality"></a> [criticality](#input\_criticality) | value to set the criticality | `string` | `"medium"` | no |
| <a name="input_custom_tags"></a> [custom\_tags](#input\_custom\_tags) | value to set the custom tags | `map(any)` | `{}` | no |
| <a name="input_data_classification"></a> [data\_classification](#input\_data\_classification) | value to set the data classification | `string` | `"internal"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | value to set the environment | `string` | n/a | yes |
| <a name="input_managed_by"></a> [managed\_by](#input\_managed\_by) | value to set the managed by | `string` | `"terraform"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | value to set the owner | `string` | n/a | yes |
| <a name="input_workload_name"></a> [workload\_name](#input\_workload\_name) | value to set the workload name | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_tags"></a> [tags](#output\_tags) | ############################################################################ OUTPUT TAGS ############################################################################ |
<!-- END_TF_DOCS -->