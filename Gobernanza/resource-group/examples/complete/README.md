<!-- BEGIN_TF_DOCS -->
# Ejemplo Completo - Infraestructura Azure

Este ejemplo demuestra como usar todos los modulos de Terraform
para desplegar una infraestructura completa en Azure.

## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.80 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | ../../modules/key-vault | n/a |
| <a name="module_log_analytics"></a> [log\_analytics](#module\_log\_analytics) | ../../modules/log-analytics-workspace | n/a |
| <a name="module_nsg_db"></a> [nsg\_db](#module\_nsg\_db) | ../../modules/network-security-group | n/a |
| <a name="module_nsg_web"></a> [nsg\_web](#module\_nsg\_web) | ../../modules/network-security-group | n/a |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | ../../modules/resource-group | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ../../modules/storage-account | n/a |
| <a name="module_subnet_db"></a> [subnet\_db](#module\_subnet\_db) | ../../modules/subnet | n/a |
| <a name="module_subnet_web"></a> [subnet\_web](#module\_subnet\_web) | ../../modules/subnet | n/a |
| <a name="module_vm_web"></a> [vm\_web](#module\_vm\_web) | ../../modules/virtual-machine-linux | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ../../modules/virtual-network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_admin_ssh_public_key"></a> [admin\_ssh\_public\_key](#input\_admin\_ssh\_public\_key) | Clave SSH publica para las VMs | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Entorno de despliegue (dev, staging, prod) | `string` | `"dev"` | no |
| <a name="input_location"></a> [location](#input\_location) | Region de Azure | `string` | `"westeurope"` | no |
| <a name="input_project"></a> [project](#input\_project) | Nombre del proyecto | `string` | `"demo"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_key_vault_name"></a> [key\_vault\_name](#output\_key\_vault\_name) | Nombre del Key Vault |
| <a name="output_key_vault_uri"></a> [key\_vault\_uri](#output\_key\_vault\_uri) | URI del Key Vault |
| <a name="output_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#output\_log\_analytics\_workspace\_id) | ID del Log Analytics Workspace |
| <a name="output_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#output\_log\_analytics\_workspace\_name) | Nombre del Log Analytics Workspace |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | ID del Resource Group |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Nombre del Resource Group |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | Nombre del Storage Account |
| <a name="output_storage_account_primary_blob_endpoint"></a> [storage\_account\_primary\_blob\_endpoint](#output\_storage\_account\_primary\_blob\_endpoint) | Endpoint de blob del Storage Account |
| <a name="output_subnet_db_id"></a> [subnet\_db\_id](#output\_subnet\_db\_id) | ID de la Subnet Database |
| <a name="output_subnet_web_id"></a> [subnet\_web\_id](#output\_subnet\_web\_id) | ID de la Subnet Web |
| <a name="output_vm_web_principal_id"></a> [vm\_web\_principal\_id](#output\_vm\_web\_principal\_id) | Principal ID de la identidad de la VM Web |
| <a name="output_vm_web_private_ip"></a> [vm\_web\_private\_ip](#output\_vm\_web\_private\_ip) | IP privada de la VM Web |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | ID de la Virtual Network |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | Nombre de la Virtual Network |
<!-- END_TF_DOCS -->