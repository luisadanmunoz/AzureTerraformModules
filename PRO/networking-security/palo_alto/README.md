# Terraform Module: Palo Alto VM-Series Firewall

Este módulo de Terraform despliega una máquina virtual con Palo Alto VM-Series Firewall en Azure.

## Recursos

Este módulo define los siguientes recursos:

- `random_password.pass_palo_01`: Genera una contraseña aleatoria para Palo Alto.
- `azurerm_key_vault_secret.keyvault_secret_01`: Almacena la contraseña en Azure Key Vault.
- `azurerm_network_interface.FW1_MGMT_nic`: Configura la interfaz de administración del firewall.
- `azurerm_network_interface.FW1_TST_nic`: Configura la interfaz de red de confianza (Trust).
- `azurerm_network_interface.FW1_UNT_nic`: Configura la interfaz de red no confiable (Untrust).
- `azurerm_virtual_machine.VM_FW1`: Crea la máquina virtual Palo Alto VM-Series.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                          | Tipo        | Descripción                                             | Por defecto |
|---------------------------------|------------|---------------------------------------------------------|------------|
| `keyvault_name`                 | `string`   | Nombre del Key Vault donde se almacenará la contraseña. | -          |
| `keyvault_resourcegroup_name`   | `string`   | Nombre del grupo de recursos del Key Vault.            | -          |
| `keyvault_secret_name_01`       | `string`   | Nombre del secreto en Key Vault.                       | -          |
| `vnet_name_01`                  | `string`   | Nombre de la red virtual de Palo Alto.                 | -          |
| `vnet_resourcegroup_01`         | `string`   | Grupo de recursos de la red virtual.                   | -          |
| `subnet_name_01`                | `string`   | Nombre de la subred de administración.                 | -          |
| `subnet_name_02`                | `string`   | Nombre de la subred de confianza (Trust).              | -          |
| `subnet_name_03`                | `string`   | Nombre de la subred no confiable (Untrust).            | -          |
| `interface_name_01`             | `string`   | Nombre de la interfaz de administración.               | -          |
| `interface_name_02`             | `string`   | Nombre de la interfaz de confianza (Trust).            | -          |
| `interface_name_03`             | `string`   | Nombre de la interfaz no confiable (Untrust).          | -          |
| `interface_privateip_allocation_01` | `string` | Asignación de IP para la interfaz de administración.    | -          |
| `interface_privateip_allocation_02` | `string` | Asignación de IP para la interfaz de confianza.        | -          |
| `interface_privateip_allocation_03` | `string` | Asignación de IP para la interfaz no confiable.        | -          |
| `vm_name_01`                    | `string`   | Nombre de la máquina virtual Palo Alto.               | -          |
| `vm_size_01`                    | `string`   | Tamaño de la máquina virtual.                         | -          |
| `vm_osdisk_name_01`              | `string`   | Nombre del disco del sistema operativo.               | -          |
| `vm_image_publisher_01`          | `string`   | Publicador de la imagen de Palo Alto.                | -          |
| `vm_image_offer_01`              | `string`   | Oferta de la imagen de Palo Alto.                    | -          |
| `vm_image_sku_01`                | `string`   | SKU de la imagen de Palo Alto.                       | -          |
| `vm_image_version_01`            | `string`   | Versión de la imagen de Palo Alto.                   | -          |
| `zones`                          | `string`   | Zona de disponibilidad para la VM.                   | -          |
| `tags`                           | `map(any)` | Etiquetas opcionales para los recursos.              | `{}`       |

## Outputs

Este módulo expone los siguientes outputs:

| Nombre  | Descripción                                  |
|---------|----------------------------------------------|
| `id`    | ID de la interfaz de red no confiable.     |
| `name`  | Nombre de la interfaz de red no confiable. |

## Uso

Ejemplo de uso del módulo:

```hcl
module "palo_alto" {
  source                      = "./ruta/al/modulo"
  keyvault_name               = "mi-keyvault"
  keyvault_resourcegroup_name = "mi-grupo-de-recursos"
  keyvault_secret_name_01     = "paloalto-secret"
  vnet_name_01                = "mi-vnet"
  vnet_resourcegroup_01       = "mi-grupo-de-recursos"
  subnet_name_01              = "mgmt-subnet"
  subnet_name_02              = "trust-subnet"
  subnet_name_03              = "untrust-subnet"
  interface_name_01           = "fw-mgmt-nic"
  interface_name_02           = "fw-trust-nic"
  interface_name_03           = "fw-untrust-nic"
  vm_name_01                  = "fw-instance"
  vm_size_01                  = "Standard_D3_v2"
  vm_osdisk_name_01           = "fw-os-disk"
  vm_image_publisher_01       = "paloaltonetworks"
  vm_image_offer_01           = "vmseries-flex"
  vm_image_sku_01             = "byol"
  vm_image_version_01         = "11.0.401"
  zones                       = "1"
  tags                        = { env = "prod" }
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.
- Aceptar los términos de Palo Alto con:
  ```sh
  az vm image terms accept --urn paloaltonetworks:vmseries-flex:byol:11.0.401
  ```

## Autor

Este módulo ha sido desarrollado para la implementación de Palo Alto VM-Series Firewall en Azure.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_key_vault_secret.keyvault_secret_01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_network_interface.FW1_MGMT_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface.FW1_TST_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface.FW1_UNT_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine.VM_FW1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine) | resource |
| [random_password.pass_palo_01](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_key_vault.keyvault_01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_subnet.subnet_01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.subnet_02](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.subnet_03](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet_01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_interface_config_name_01"></a> [interface\_config\_name\_01](#input\_interface\_config\_name\_01) | n/a | `string` | n/a | yes |
| <a name="input_interface_config_name_02"></a> [interface\_config\_name\_02](#input\_interface\_config\_name\_02) | n/a | `string` | n/a | yes |
| <a name="input_interface_config_name_03"></a> [interface\_config\_name\_03](#input\_interface\_config\_name\_03) | n/a | `string` | n/a | yes |
| <a name="input_interface_name_01"></a> [interface\_name\_01](#input\_interface\_name\_01) | n/a | `string` | n/a | yes |
| <a name="input_interface_name_02"></a> [interface\_name\_02](#input\_interface\_name\_02) | n/a | `string` | n/a | yes |
| <a name="input_interface_name_03"></a> [interface\_name\_03](#input\_interface\_name\_03) | n/a | `string` | n/a | yes |
| <a name="input_interface_privateip_address_01"></a> [interface\_privateip\_address\_01](#input\_interface\_privateip\_address\_01) | n/a | `string` | n/a | yes |
| <a name="input_interface_privateip_allocation_01"></a> [interface\_privateip\_allocation\_01](#input\_interface\_privateip\_allocation\_01) | n/a | `string` | n/a | yes |
| <a name="input_interface_privateip_allocation_02"></a> [interface\_privateip\_allocation\_02](#input\_interface\_privateip\_allocation\_02) | n/a | `string` | n/a | yes |
| <a name="input_interface_privateip_allocation_03"></a> [interface\_privateip\_allocation\_03](#input\_interface\_privateip\_allocation\_03) | n/a | `string` | n/a | yes |
| <a name="input_keyvault_name"></a> [keyvault\_name](#input\_keyvault\_name) | ############################################################################# PALO ALTO KEYVAULT ############################################################################# | `string` | n/a | yes |
| <a name="input_keyvault_resourcegroup_name"></a> [keyvault\_resourcegroup\_name](#input\_keyvault\_resourcegroup\_name) | n/a | `string` | n/a | yes |
| <a name="input_keyvault_secret_name_01"></a> [keyvault\_secret\_name\_01](#input\_keyvault\_secret\_name\_01) | n/a | `string` | n/a | yes |
| <a name="input_subnet_name_01"></a> [subnet\_name\_01](#input\_subnet\_name\_01) | ############################################################################# PALO ALTO NIC MANAGEMENT ############################################################################# | `string` | n/a | yes |
| <a name="input_subnet_name_02"></a> [subnet\_name\_02](#input\_subnet\_name\_02) | ############################################################################# PALO ALTO NIC TRUST ############################################################################# | `string` | n/a | yes |
| <a name="input_subnet_name_03"></a> [subnet\_name\_03](#input\_subnet\_name\_03) | ############################################################################# PALO ALTO NIC UNTRUST ############################################################################# | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `{}` | no |
| <a name="input_vm_image_offer_01"></a> [vm\_image\_offer\_01](#input\_vm\_image\_offer\_01) | n/a | `string` | n/a | yes |
| <a name="input_vm_image_publisher_01"></a> [vm\_image\_publisher\_01](#input\_vm\_image\_publisher\_01) | n/a | `string` | n/a | yes |
| <a name="input_vm_image_sku_01"></a> [vm\_image\_sku\_01](#input\_vm\_image\_sku\_01) | n/a | `string` | n/a | yes |
| <a name="input_vm_image_version_01"></a> [vm\_image\_version\_01](#input\_vm\_image\_version\_01) | n/a | `string` | n/a | yes |
| <a name="input_vm_location_01"></a> [vm\_location\_01](#input\_vm\_location\_01) | n/a | `string` | n/a | yes |
| <a name="input_vm_name_01"></a> [vm\_name\_01](#input\_vm\_name\_01) | ############################################################################# PALO ALTO VIRTUAL MACHINE ############################################################################# | `string` | n/a | yes |
| <a name="input_vm_osdisk_name_01"></a> [vm\_osdisk\_name\_01](#input\_vm\_osdisk\_name\_01) | n/a | `string` | n/a | yes |
| <a name="input_vm_resourcegroup_01"></a> [vm\_resourcegroup\_01](#input\_vm\_resourcegroup\_01) | n/a | `string` | n/a | yes |
| <a name="input_vm_size_01"></a> [vm\_size\_01](#input\_vm\_size\_01) | n/a | `string` | n/a | yes |
| <a name="input_vnet_name_01"></a> [vnet\_name\_01](#input\_vnet\_name\_01) | ############################################################################# PALO ALTO NETWORKING ############################################################################# | `string` | n/a | yes |
| <a name="input_vnet_resourcegroup_01"></a> [vnet\_resourcegroup\_01](#input\_vnet\_resourcegroup\_01) | n/a | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | ############################################################################# PALO ALTO OUTPUT ############################################################################# |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->