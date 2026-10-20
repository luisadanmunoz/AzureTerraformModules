# Terraform Module: Fortinet FortiGate

Este módulo de Terraform despliega una máquina virtual Linux en Azure con Fortinet FortiGate preinstalado y configurado.

## Recursos

Este módulo define los siguientes recursos:

- `random_password.password`: Genera una contraseña aleatoria para la VM.
- `azurerm_key_vault_secret.vm_secret`: Almacena la contraseña en Azure Key Vault.
- `azurerm_network_interface.ha`: Configura la interfaz de red de alta disponibilidad.
- `azurerm_network_interface.public`: Configura la interfaz de red pública.
- `azurerm_network_interface.mgmt`: Configura la interfaz de administración.
- `azurerm_network_interface.private`: Configura la interfaz de red privada.
- `azurerm_linux_virtual_machine.linux_vm`: Despliega la máquina virtual Linux con Fortinet FortiGate.

## Variables

Las siguientes variables pueden ser configuradas al utilizar este módulo:

| Nombre                           | Tipo        | Descripción                                                  | Por defecto |
|----------------------------------|------------|--------------------------------------------------------------|------------|
| `secret_name`                    | `string`   | Nombre del secreto en Key Vault.                            | -          |
| `keyvault_id`                    | `string`   | ID del Key Vault donde se almacenará la contraseña.        | -          |
| `tags`                           | `map(any)` | Etiquetas comunes para los recursos.                        | `{}`       |
| `vm_name`                        | `string`   | Nombre de la máquina virtual.                               | -          |
| `location`                       | `string`   | Ubicación de la máquina virtual.                           | -          |
| `resource_group_name`            | `string`   | Nombre del grupo de recursos.                              | -          |
| `subnet_id_ha`                   | `string`   | ID de la subred de alta disponibilidad.                     | -          |
| `private_ip_address_ha`          | `string`   | Dirección IP privada de la HA.                              | -          |
| `subnet_id_public`               | `string`   | ID de la subred pública.                                    | -          |
| `private_ip_address_public`      | `string`   | Dirección IP privada pública.                               | -          |
| `subnet_id_mgmt`                 | `string`   | ID de la subred de administración.                         | -          |
| `private_ip_address_mgmt`        | `string`   | Dirección IP privada de administración.                     | -          |
| `subnet_id_private`              | `string`   | ID de la subred privada.                                    | -          |
| `private_ip_address_private`     | `string`   | Dirección IP privada de la red privada.                     | -          |
| `size`                           | `string`   | Tamaño de la máquina virtual.                              | -          |
| `admin_username`                 | `string`   | Nombre del usuario administrador.                          | -          |
| `publisher`                      | `string`   | Publicador de la imagen de Fortinet.                       | -          |
| `offer`                          | `string`   | Oferta de la imagen de Fortinet.                           | -          |
| `sku`                            | `string`   | SKU de la imagen de Fortinet.                              | -          |
| `os_version`                     | `string`   | Versión del sistema operativo de la imagen de Fortinet.    | -          |
| `os_disk`                        | `string`   | Nombre del disco del sistema operativo.                    | -          |
| `floating-public`                | `bool`     | Habilita la IP flotante pública.                           | `false`    |
| `floating-private`               | `bool`     | Habilita la IP flotante privada.                           | `false`    |

## Uso

Ejemplo de uso del módulo:

```hcl
module "fortinet_fortigate" {
  source                = "./ruta/al/modulo"
  vm_name               = "fortigate-instance"
  resource_group_name   = "mi-grupo-de-recursos"
  location              = "East US"
  size                  = "Standard_D2s_v3"
  subnet_id_ha          = "subnet-ha-id"
  private_ip_address_ha = "10.0.0.4"
  subnet_id_public      = "subnet-public-id"
  private_ip_address_public = "10.0.1.4"
  subnet_id_mgmt        = "subnet-mgmt-id"
  private_ip_address_mgmt = "10.0.2.4"
  subnet_id_private     = "subnet-private-id"
  private_ip_address_private = "10.0.3.4"
  admin_username        = "admin"
  publisher             = "fortinet"
  offer                 = "fortinet_fortigate-vm_v5"
  sku                   = "fortinet_fg-vm_payg_2023"
  os_version            = "7.2.8"
  os_disk               = "fortigate-os-disk"
  floating-public       = false
  floating-private      = false
}
```

## Requisitos

- Terraform >= 0.12
- Provider `azurerm` correctamente configurado.

## Autor

Este módulo ha sido desarrollado para la implementación de Fortinet FortiGate en Azure sobre una máquina virtual Linux.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.1.3 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.3 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_key_vault_secret.vm_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_linux_virtual_machine.linux_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.ha](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface.mgmt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface.private](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/3.1.3/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | n/a | `string` | n/a | yes |
| <a name="input_floating-private"></a> [floating-private](#input\_floating-private) | n/a | `bool` | n/a | yes |
| <a name="input_floating-public"></a> [floating-public](#input\_floating-public) | n/a | `bool` | n/a | yes |
| <a name="input_keyvault_id"></a> [keyvault\_id](#input\_keyvault\_id) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_offer"></a> [offer](#input\_offer) | n/a | `string` | n/a | yes |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | n/a | `string` | n/a | yes |
| <a name="input_os_version"></a> [os\_version](#input\_os\_version) | n/a | `string` | n/a | yes |
| <a name="input_private_ip_address_allocation_ha"></a> [private\_ip\_address\_allocation\_ha](#input\_private\_ip\_address\_allocation\_ha) | n/a | `string` | n/a | yes |
| <a name="input_private_ip_address_allocation_mgmt"></a> [private\_ip\_address\_allocation\_mgmt](#input\_private\_ip\_address\_allocation\_mgmt) | n/a | `string` | n/a | yes |
| <a name="input_private_ip_address_allocation_private"></a> [private\_ip\_address\_allocation\_private](#input\_private\_ip\_address\_allocation\_private) | n/a | `string` | n/a | yes |
| <a name="input_private_ip_address_allocation_public"></a> [private\_ip\_address\_allocation\_public](#input\_private\_ip\_address\_allocation\_public) | n/a | `string` | n/a | yes |
| <a name="input_private_ip_address_ha"></a> [private\_ip\_address\_ha](#input\_private\_ip\_address\_ha) | n/a | `string` | n/a | yes |
| <a name="input_private_ip_address_mgmt"></a> [private\_ip\_address\_mgmt](#input\_private\_ip\_address\_mgmt) | n/a | `string` | n/a | yes |
| <a name="input_private_ip_address_private"></a> [private\_ip\_address\_private](#input\_private\_ip\_address\_private) | n/a | `string` | n/a | yes |
| <a name="input_private_ip_address_private_floating-private"></a> [private\_ip\_address\_private\_floating-private](#input\_private\_ip\_address\_private\_floating-private) | n/a | `string` | n/a | yes |
| <a name="input_private_ip_address_public"></a> [private\_ip\_address\_public](#input\_private\_ip\_address\_public) | n/a | `string` | n/a | yes |
| <a name="input_private_ip_address_public_floating-public"></a> [private\_ip\_address\_public\_floating-public](#input\_private\_ip\_address\_public\_floating-public) | n/a | `string` | n/a | yes |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | n/a | `string` | n/a | yes |
| <a name="input_publisher"></a> [publisher](#input\_publisher) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | n/a | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | n/a | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id_ha"></a> [subnet\_id\_ha](#input\_subnet\_id\_ha) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id_mgmt"></a> [subnet\_id\_mgmt](#input\_subnet\_id\_mgmt) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id_private"></a> [subnet\_id\_private](#input\_subnet\_id\_private) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id_public"></a> [subnet\_id\_public](#input\_subnet\_id\_public) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->