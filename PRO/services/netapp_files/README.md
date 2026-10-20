## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_netapp_account.netapp_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account) | resource |
| [azurerm_netapp_pool.netapp_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_commom_tags"></a> [commom\_tags](#input\_commom\_tags) | n/a | `map` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ AZURE NETAPP FILES ############################################################################ | `string` | n/a | yes |
| <a name="input_netapp_pool"></a> [netapp\_pool](#input\_netapp\_pool) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_service_level"></a> [service\_level](#input\_service\_level) | n/a | `string` | n/a | yes |
| <a name="input_size_in_tb"></a> [size\_in\_tb](#input\_size\_in\_tb) | n/a | `string` | n/a | yes |

## Outputs

No outputs.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_netapp_account.netapp_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account) | resource |
| [azurerm_netapp_pool.netapp_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_commom_tags"></a> [commom\_tags](#input\_commom\_tags) | n/a | `map` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ############################################################################ AZURE NETAPP FILES ############################################################################ | `string` | n/a | yes |
| <a name="input_netapp_pool"></a> [netapp\_pool](#input\_netapp\_pool) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_service_level"></a> [service\_level](#input\_service\_level) | n/a | `string` | n/a | yes |
| <a name="input_size_in_tb"></a> [size\_in\_tb](#input\_size\_in\_tb) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->