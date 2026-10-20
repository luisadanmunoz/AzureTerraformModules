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
| <a name="module_hostpool_personal"></a> [hostpool\_personal](#module\_hostpool\_personal) | ../../ | n/a |
| <a name="module_hostpool_pooled"></a> [hostpool\_pooled](#module\_hostpool\_pooled) | ../../ | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_personal_hostpool_id"></a> [personal\_hostpool\_id](#output\_personal\_hostpool\_id) | The ID of the Personal Host Pool |
| <a name="output_pooled_hostpool_id"></a> [pooled\_hostpool\_id](#output\_pooled\_hostpool\_id) | The ID of the Pooled Host Pool |
| <a name="output_pooled_hostpool_registration_token"></a> [pooled\_hostpool\_registration\_token](#output\_pooled\_hostpool\_registration\_token) | The registration token for the Pooled Host Pool |
<!-- END_TF_DOCS -->